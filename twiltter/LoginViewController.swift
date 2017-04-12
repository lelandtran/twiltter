//
//  ViewController.swift
//  twiltter
//
//  Created by Tran, Leland on 4/10/17.
//  Copyright © 2017 Tran, Leland. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onLogin(_ sender: Any) {
        TwitterClient.sharedInstance.login() {
            (user : User?, error : Error?) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: self)
            }
            else {
                // handle login error
                print("error logging in")
            }
        }
        
    }


}

