//
//  TweetsViewController.swift
//  twiltter
//
//  Created by Tran, Leland on 4/12/17.
//  Copyright © 2017 Tran, Leland. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var tweets : [Tweet]?
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
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        if tweets != nil {
            cell.tweet = tweets![indexPath.row]
        }
        return cell
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
        let navigationController = segue.destination as! UINavigationController
        let composeViewController = navigationController.topViewController as! ComposeViewController
        print("prepared for segue to \(composeViewController)")
        
    }
    

}