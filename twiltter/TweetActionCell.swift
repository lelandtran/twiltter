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
                
            } else {
                print("failed retweet for tweet \(self.tweet.id!)")
                print("error: \(error)")
            }
        })
    }

    @IBAction func onReply(_ sender: Any) {
        
    }
    
    @IBAction func onFavorite(_ sender: Any) {
        TwitterClient.sharedInstance.favorite(tweetId: tweet.id!, completion: { (succeeded: Bool, error: Error?) -> Void in
            if succeeded {
                print("created favorite for tweet \(self.tweet.id!)")
                
            } else {
                print("error favoriting tweet \(self.tweet.id!)")
            }
        })
    }
}
