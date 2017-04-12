//
//  TwitterClient.swift
//  twiltter
//
//  Created by Tran, Leland on 4/11/17.
//  Copyright © 2017 Tran, Leland. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "OXyDuk54wnd1RBCVoZzS6KkCG"
let twitterConsumerSecret = "FmZeHdGns4TR2j6WpDfHYop2PHILTQ3RMR2Zercaaya8Cxr7d7"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {

    class var sharedInstance : TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL as! URL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance!
    }
}
