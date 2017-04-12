//
//  ViewController.swift
//  twiltter
//
//  Created by Tran, Leland on 4/10/17.
//  Copyright © 2017 Tran, Leland. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onLogin(_ sender: Any) {
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
            }
    }


}

