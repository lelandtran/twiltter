//
//  ProfileViewController.swift
//  twiltter
//
//  Created by Tran, Leland on 4/17/17.
//  Copyright © 2017 Tran, Leland. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var user: User!
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
        print("loaded ProfileViewController with user \(user)")
        if (user.coverImageUrl != nil) {
           coverImageView.setImageWith(URL(string: user.coverImageUrl!)!)
        }
        profileImageView.setImageWith(URL(string: user.profileImageUrl!)!)
        nameLabel.text = user.name
        screennameLabel.text = user.screenname
        tweetsCountLabel.text = "\(user.tweetsCount!)"
        followersCountLabel.text = "\(user.followersCount!)"
        followingCountLabel.text = "\(user.followingCount!)"
        TwitterClient.sharedInstance.userTimeline(withParams: ["screen_name":user.screenname!, "count":20]) {
            (tweets, error) in
            if error != nil {
                print("error getting tweets")
            } else {
                self.tweets = tweets
                print("successfully retrieved \(tweets?.count) tweets")
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tweets?.count: \(tweets?.count)")
        return tweets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        print("tweets?[indexPath.row] \(tweets?[indexPath.row])")
        if tweets != nil {
            cell.tweet = tweets![indexPath.row]
        }
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
