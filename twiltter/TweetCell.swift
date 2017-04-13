//
//  TweetCell.swift
//  twiltter
//
//  Created by Tran, Leland on 4/12/17.
//  Copyright © 2017 Tran, Leland. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    var tweet : Tweet! {
        didSet {
            tweetLabel.text = tweet.text
            nameLabel.text = tweet.user?.name
            screennameLabel.text = "@\((tweet.user?.screenname!)!)"
            if tweet.createdAt != nil {
                timeLabel.text = getTimeLabel(date: tweet.createdAt!)
            }
            if let profileImageUrlString = tweet.user?.profileImageUrl {
                profileImageView.setImageWith(URL(string: profileImageUrlString)!)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func getTimeLabel(date: Date) -> String {
//        print("getTimeLabel(\(date))")
        if !Calendar.current.isDateInToday(date) {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yy"
            let dateString = formatter.string(from: date)
            return dateString
        }
        let hourDiff = Calendar.current.component(.hour, from: Date()) - Calendar.current.component(.hour, from: date)
        if hourDiff > 0 {
            return "\(hourDiff) h"
        }
        let minDiff = Calendar.current.component(.minute, from: Date()) - Calendar.current.component(.minute, from: date)
        if minDiff > 0 {
            return "\(minDiff) m"
        }
        let secondDiff = Calendar.current.component(.second, from: Date()) - Calendar.current.component(.second, from: date)
        return "\(secondDiff) s"
    }
}
