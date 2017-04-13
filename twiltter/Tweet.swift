//
//  Tweet.swift
//  twiltter
//
//  Created by Tran, Leland on 4/11/17.
//  Copyright © 2017 Tran, Leland. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var user : User?
    var text : String?
    var createdAtString : String?
    var createdAt : Date?
    var profileImageUrl : URL?
    
    init(dictionary : NSDictionary){
        user = User(dictionary : dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM dd HH:mm:ss Z y"
        createdAt = formatter.date(from: createdAtString!)
    }
    
    class func tweetsWith(array : [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
}
