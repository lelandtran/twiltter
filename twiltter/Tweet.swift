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
    var id : Int?
    var rawDictionary : NSDictionary?
    
    init(dictionary : NSDictionary){
        user = User(dictionary : dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        id = dictionary["id"] as? Int
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM dd HH:mm:ss Z y"
        createdAt = formatter.date(from: createdAtString!)
        rawDictionary = dictionary
    }
    
    class func tweetsWith(array : [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
}
