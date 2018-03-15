//
//  UserTweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Melissa Phuong Nguyen on 3/14/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class UserTweetCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            let profileImageURL = URL(string: tweet.user.profileImageURL)
            profileImage.af_setImage(withURL: profileImageURL! )
            usernameLabel.text = tweet.user.name
            screennameLabel.text = tweet.user.screenName
            
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
