 //
//  User.swift
//  twiltter
//
//  Created by Tran, Leland on 4/11/17.
//  Copyright © 2017 Tran, Leland. All rights reserved.
//

import UIKit

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
        self.dictionary = dictionary as? NSDictionary
    }
}
