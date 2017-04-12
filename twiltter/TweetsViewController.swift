//
//  TweetsViewController.swift
//  twiltter
//
//  Created by Tran, Leland on 4/12/17.
//  Copyright © 2017 Tran, Leland. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

    var tweets : [Tweet]?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.homeTimeline(withParams: nil) { (tweets, error) in
            self.tweets = tweets
            // tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(_ sender: Any) {
        User.currentUser?.logout()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
