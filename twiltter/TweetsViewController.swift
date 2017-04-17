//
//  TweetsViewController.swift
//  twiltter
//
//  Created by Tran, Leland on 4/12/17.
//  Copyright © 2017 Tran, Leland. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var tweets : [Tweet]?
    
    var isMoreDataLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        TwitterClient.sharedInstance.homeTimeline(withParams: nil) { (tweets, error) in
            self.tweets = tweets
            print("reloading tableView in viewDidAppear")
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(_ sender: Any) {
        User.currentUser?.logout()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        if tweets != nil {
            cell.tweet = tweets![indexPath.row]
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isMoreDataLoading {
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            if (scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                print("will load more data")
                loadMoreData()
            }
        }
    }
    
    func loadMoreData(){
        TwitterClient.sharedInstance.homeTimeline(withParams: ["count":(tweets?.count)!+20]) { (newTweets, error) in
            if error != nil {
                print("error loading more data: \(error)")
            } else {
                print("finished loading more data: \(newTweets)")
                if newTweets != nil {
                    self.tweets = newTweets
                    self.tableView.reloadData()
                }
            }
            self.isMoreDataLoading = false
        }
    }
    
    func refreshControlAction(_ refreshControl : UIRefreshControl){
        TwitterClient.sharedInstance.homeTimeline(withParams: nil) { (tweets, error) in
            self.tweets = tweets
            print("reloading tableView in viewDidAppear")
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
        
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let navigationController = segue.destination as? UINavigationController {
            if let composeViewController = navigationController.topViewController as? ComposeViewController {
                print("prepared for segue to \(composeViewController)")
            }
        }
        if let tweetDetailViewController = segue.destination as? TweetDetailViewController {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let tweet = tweets![indexPath!.row]
            tweetDetailViewController.tweet = tweet
        }
        
    }
    

}
