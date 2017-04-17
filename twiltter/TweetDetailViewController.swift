//
//  TweetDetailViewController.swift
//  twiltter
//
//  Created by Tran, Leland on 4/13/17.
//  Copyright © 2017 Tran, Leland. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweet: Tweet?
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        print("tweet \(tweet?.id): \(tweet?.text)")
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        nameLabel.text = tweet?.user?.name
        screennameLabel.text = tweet?.user?.screenname
        tweetTextLabel.text = tweet?.text
        
        if let profileImageUrlString = tweet?.user?.profileImageUrl {
            profileImageView.setImageWith(URL(string: profileImageUrlString)!)
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d/yyyy hh:mm a"
        createdAtLabel.text = formatter.string(from: (tweet?.createdAt)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetActionCell", for: indexPath) as! TweetActionCell
        cell.tweet = tweet!
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let navigationController = segue.destination as! UINavigationController
        let composeViewController = navigationController.topViewController as! ComposeViewController
        composeViewController.inReplyTo = tweet
    }
 

}
