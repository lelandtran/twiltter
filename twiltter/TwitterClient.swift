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
    
    func send(tweet: String, completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        self.post("1.1/statuses/update.json", parameters: ["status":tweet], progress: nil, success: { (operation: URLSessionDataTask, response: Any?) in
            print("tweet successfully posted! \(tweet)")
            completion(true, nil)
        }, failure: { (operation: URLSessionDataTask?, error: Error) in
            print("error posting tweet: \(tweet)")
            completion(false, error)
        })
    }
    
    func reply(tweet: String, inReplyTo: Tweet?, completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        self.post("1.1/statuses/update.json", parameters: ["status":tweet, "in_reply_to_status_id":(inReplyTo?.id)!], progress: nil, success: { (operation: URLSessionDataTask, response: Any?) in
            print("reply successful: \(response)")
            print("reply successfully posted! \(tweet)")
            
            completion(true, nil)
        }, failure: { (operation: URLSessionDataTask?, error: Error) in
            print("error posting tweet: \(tweet)")
            completion(false, error)
        })
    }
    
    func retweet(tweetId: Int, completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        self.post("1.1/statuses/retweet/\(tweetId).json", parameters: nil, progress: nil, success: {
            (operation: URLSessionDataTask, response: Any?) in
            print("tweet successfully retweeted: \(tweetId)")
            completion(true, nil)
        }, failure: { (operation: URLSessionDataTask?, error: Error) in
            print("error retweeting tweet \(tweetId)")
            completion(false, error)
        })
    }
    
    func favorite(tweetId: Int, completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        self.post("1.1/favorites/create.json", parameters: ["id":tweetId], progress: nil, success: { (operation: URLSessionDataTask, response: Any?) in
            print("favorited tweet \(tweetId)")
            completion(true, nil)
            }, failure: { (operation: URLSessionDataTask?, error: Error) in
                print("error favoriting tweet \(tweetId)")
                completion(false, error)
        })
    }
    
    func userTimeline(withParams : NSDictionary?, completion : @escaping (_ tweets: [Tweet]?, _ error: Error?) -> Void){
        self.get("1.1/statuses/user_timeline.json", parameters: withParams, progress: nil, success: { (operation :URLSessionDataTask, response : Any?) in
            print("user timeline \(response)")
            let tweets = Tweet.tweetsWith(array: (response as! [NSDictionary]))
                        for tweet in tweets {
                            print("tweet.text: \(tweet.text), created: \(tweet.createdAt!)")
                        }
            completion(tweets, nil)
        }, failure: { (operation :URLSessionDataTask?, error:Error) in
            print("error in getting user timeline with params: \(withParams)")
            self.loginCompletion?(nil, error)
            completion(nil, error)
        })
    }

    func homeTimeline(withParams : NSDictionary?, completion : @escaping (_ tweets: [Tweet]?, _ error: Error?) -> Void){
        self.get("1.1/statuses/home_timeline.json", parameters: withParams, progress: nil, success: { (operation :URLSessionDataTask, response : Any?) in
            print("home timeline \(response)")
            let tweets = Tweet.tweetsWith(array: (response as! [NSDictionary]))
            //            for tweet in tweets {
            //                print("tweet.text: \(tweet.text), created: \(tweet.createdAt!)")
            //            }
            completion(tweets, nil)
        }, failure: { (operation :URLSessionDataTask?, error:Error) in
            print("error in getting home timeline")
            self.loginCompletion?(nil, error)
            completion(nil, error)
        })
    }
    
    func login(withCompletion : @escaping (_ user : User?, _ error : Error?) -> Void) {
        loginCompletion = withCompletion
        
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
            
            TwitterClient.sharedInstance.get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (operation : URLSessionDataTask, response : Any) -> Void in
                //                print("user : \(response)")
                let user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print("user.name: \(user.name!)")
                self.loginCompletion?(user, nil)
            }) { (operation : URLSessionDataTask?, error : Error) -> Void in
                print("error getting current user")
                self.loginCompletion?(nil, error)
            }
            
            
        }) { (error : Error?) -> Void in
            print("failed to receive access token")
            self.loginCompletion?(nil, error)
        }

    }
}
