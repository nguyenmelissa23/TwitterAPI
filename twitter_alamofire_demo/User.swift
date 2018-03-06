//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var profileImageURL: String
    static var current: User?{
        get {
            if self.current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    self.current = User(dictionary: dictionary)
                }
            }
            return self.current
        }
        set (user) {
            self.current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.userDict, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
    
    var userDict: [String: Any]
    var screenName: String
    
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as! String
        screenName = dictionary["screen_name"] as!  String
        self.userDict = dictionary
        profileImageURL = dictionary["profile_image_url_https"] as! String
    }
}
