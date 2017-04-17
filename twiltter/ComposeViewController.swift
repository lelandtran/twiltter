//
//  ComposeViewController.swift
//  twiltter
//
//  Created by Tran, Leland on 4/13/17.
//  Copyright © 2017 Tran, Leland. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var charCountLabel: UILabel!
    
    var inReplyTo: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tweetTextView.delegate = self
        // Do any additional setup after loading the view.
        nameLabel.text = User.currentUser?.name
        screennameLabel.text = User.currentUser?.screenname
        
        profileImageView.setImageWith(URL(string: (User.currentUser?.profileImageUrl)!)!)
        
        if inReplyTo != nil {
            tweetTextView.text = "@\((inReplyTo?.user?.screenname)!)"
        } else {
            tweetTextView.text = ""
        }
        let charBufferCount = 140 - tweetTextView.text.characters.count
        charCountLabel.text = "\(charBufferCount)"
        tweetTextView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTweet(_ sender: Any) {
        if isValidTweet() {
            if inReplyTo == nil {
                TwitterClient.sharedInstance.send(tweet: tweetTextView.text) {
                    (success, error) in
                    if success {
                        print ("onTweet succeeded!")
                        self.dismiss(animated: true, completion: nil)
                        self.tweetTextView.resignFirstResponder()
                        self.inReplyTo = nil
                    } else {
                        print("something went wrong: \(error)")
                        self.present(self.alertError(title: "Oops!", message: "Oops! Something went wrong"), animated: true)
                    }
                }
            } else {
                TwitterClient.sharedInstance.reply(tweet: tweetTextView.text, inReplyTo: inReplyTo) {
                    (success, error) in
                    if success {
                        print ("onTweet reply succeeded!")
                        self.dismiss(animated: true, completion: nil)
                        self.tweetTextView.resignFirstResponder()
                        self.inReplyTo = nil
                    } else {
                        print("something went wrong with the reply: \(error)")
                        self.present(self.alertError(title: "Oops!", message: "Oops! Something went wrong with the reply"), animated: true)
                    }
                }
            }
        } else {
            present(alertError(title: "Invalid", message: "The tweet is invalid"), animated: true)
        }
    }
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        self.inReplyTo = nil
        tweetTextView.resignFirstResponder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let charBufferCount = 140 - tweetTextView.text.characters.count
        charCountLabel.text = "\(charBufferCount)"
    }
    
    // TODO: should move this to utility class
    func alertError(title: String, message: String) -> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
        
        }
        alertController.addAction(OKAction)
        return alertController
    }
    
    func isValidTweet() -> Bool {
        return isValid(tweet: tweetTextView.text)
    }
    
    func isValid(tweet: String?) -> Bool{
        if tweet == nil {
            return false
        }
        if tweet!.characters.count < 1 {
            return false
        }
        if tweet!.characters.count > 140 {
            return false
        }
        return true
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
