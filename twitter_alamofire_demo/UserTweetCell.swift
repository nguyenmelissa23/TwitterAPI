//
//  UserTweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Melissa Phuong Nguyen on 3/14/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class UserTweetCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var replyCount: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    
    
    var tweet: Tweet! {
        didSet {
            let profileImageURL = URL(string: tweet.user.profileImageURL)
            profileImage.af_setImage(withURL: profileImageURL! )
            usernameLabel.text = tweet.user.name
            screennameLabel.text = tweet.user.screenName
            tweetLabel.text = tweet.text
            retweetCount.text = "\(tweet.retweetCount)"
            favoriteCount.text = "\(tweet.favoriteCount)"
            
            if tweet.favorited == true {
                
                favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: UIControlState.normal)
            } else{
                favoriteButton.setImage(UIImage(named: "favor-icon"), for: UIControlState.normal)
            }
            
            if tweet.retweeted == true {
                retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState.normal)
            } else{
                retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControlState.normal)
            }
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
