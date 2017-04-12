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

    var loginCompletion : ((_ user : User?, _ err : Error?) -> Void)?
    
    class var sharedInstance : TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL as! URL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance!
    }
    
    func loginWith(completionHandler : @escaping (_ user : User?, _ error : Error?) -> Void) {
        loginCompletion = completionHandler
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string:"cptwitterdemo://oauth") as! URL, scope: nil, success: { (requestToken : BDBOAuth1Credential?) -> Void in
            print("got request token")
            if let tokenStr = requestToken?.token {
                let authUrl = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(tokenStr)")!
                UIApplication.shared.open(authUrl, options: [:], completionHandler: {
                    (success) in print("opened URL: \(authUrl)")})
            }
        }) { (error : Error?) -> Void in
            print("Failed to get request toekn")
            self.loginCompletion?(nil, error)
        }
    }
    
    func open(url : URL){
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString:url.query), success: {(accessToken : BDBOAuth1Credential?) -> Void in
            print("Got the access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            self.get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (operation : URLSessionDataTask, response : Any) -> Void in
                //                print("user : \(response)")
                var user = User(dictionary: response as! NSDictionary)
                print("user.name: \(user.name!)")
                self.loginCompletion?(user, nil)
            }) { (operation : URLSessionDataTask?, error : Error) -> Void in
                print("error getting current user")
                self.loginCompletion?(nil, error)
            }
            
            self.get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (operation :URLSessionDataTask, response : Any?) in
                //                print("home timeline \(response)")
                var tweets = Tweet.tweetsWith(array: (response as! [NSDictionary]))
                for tweet in tweets {
                    print("tweet.text: \(tweet.text), created: \(tweet.createdAt!)")
                }
            }, failure: { (operation :URLSessionDataTask?, error:Error) in
                print("error in getting home timeline")
                self.loginCompletion?(nil, error)
            })
        }) { (error : Error?) -> Void in
            print("failed to receive access token")
            self.loginCompletion?(nil, error)
        }

    }
}
