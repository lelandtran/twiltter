//
//  TweetActionCell.swift
//  twiltter
//
//  Created by Tran, Leland on 4/14/17.
//  Copyright © 2017 Tran, Leland. All rights reserved.
//

import UIKit

class TweetActionCell: UITableViewCell {

    
    var tweet: Tweet!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        TwitterClient.sharedInstance.retweet(tweetId: tweet.id!, completion: { (succeeded: Bool, error: Error?) -> Void in
            if succeeded {
                print("retweet succeeded for tweet \(self.tweet.id!)")
                self.window?.rootViewController?.present(self.alertError(title: "Retweeted", message: "Tweet has been retweeted!"), animated: true)
            } else {
                print("failed retweet for tweet \(self.tweet.id!)")
                print("error: \(error)")
                self.window?.rootViewController?.present(self.alertError(title: "Failure", message: "Retweet failed!"), animated: true)
            }
        })
    }

    @IBAction func onReply(_ sender: Any) {
        // segue handled in TweetDetailViewController
    }
    
    @IBAction func onFavorite(_ sender: Any) {
        TwitterClient.sharedInstance.favorite(tweetId: tweet.id!, completion: { (succeeded: Bool, error: Error?) -> Void in
            if succeeded {
                print("created favorite for tweet \(self.tweet.id!)")
                self.window?.rootViewController?.present(self.alertError(title: "Favorited", message: "Tweet added to your favorites!"), animated: true)
                
            } else {
                print("error favoriting tweet \(self.tweet.id!)")
                self.window?.rootViewController?.present(self.alertError(title: "Failure", message: "Favoriting failed!"), animated: true)
            }
        })
    }
    
    func alertError(title: String, message: String) -> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        alertController.addAction(OKAction)
        return alertController
    }
}
