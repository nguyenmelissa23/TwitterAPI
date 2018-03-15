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
    var backgroundImageURL: String
    var userDict: [String: Any]
    var screenName: String
    var followersCount: Int
    var friendsCount: Int
    var tweetCount: Int
    
    private static var _current: User?
    static var current: User?{
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.userDict, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
    
    
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as! String
        screenName = dictionary["screen_name"] as!  String
        self.userDict = dictionary
        profileImageURL = dictionary["profile_image_url_https"] as! String
        backgroundImageURL = dictionary["profile_background_image_url_https"] as! String
        followersCount = dictionary["followers_count"] as! Int
        friendsCount = dictionary["friends_count"] as! Int
        tweetCount = dictionary["statuses_count"] as! Int
    }
}
