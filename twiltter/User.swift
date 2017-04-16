 //
//  User.swift
//  twiltter
//
//  Created by Tran, Leland on 4/11/17.
//  Copyright © 2017 Tran, Leland. All rights reserved.
//

import UIKit

 
var _currentUser : User?
let currentUserKey = "kCurrentUser"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"
 
 class User: NSObject {

    var name : String?
    var screenname : String?
    var profileImageUrl : String?
    var tagline : String?
    var dictionary : NSDictionary?
    
    init(dictionary : NSDictionary) {
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
        self.dictionary = dictionary as NSDictionary
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NotificationCenter.default.post(name: NSNotification.Name(userDidLogoutNotification), object: nil)
    }
    
    
    class var currentUser : User? {
        get {
            if _currentUser == nil {
                let data = UserDefaults.standard.object(forKey: currentUserKey) as? NSData
                if data != nil {
                    do {
                        let dictionary = try JSONSerialization.jsonObject(with: data as! Data)
                        _currentUser = User(dictionary: dictionary as! NSDictionary)
                    } catch {
                        print("error deserializing data from UserDefaults")
                    }
                }
            }
            return _currentUser
        }

        set(user) {
            _currentUser = user
            if _currentUser != nil {
                do {
                    let data = try JSONSerialization.data(withJSONObject: user!.dictionary!)
                    UserDefaults.standard.set(data, forKey: currentUserKey)
                } catch {
                    print("There was an error deserializing data")
                    UserDefaults.standard.removeObject(forKey: currentUserKey)
                }
            }
            else {
                UserDefaults.standard.set(nil, forKey: currentUserKey)
            }
            UserDefaults.standard.synchronize()
        }
    }
    
    
}
