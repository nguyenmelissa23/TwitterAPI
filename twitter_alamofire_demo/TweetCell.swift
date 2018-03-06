//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!

    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            usernameLabel.text = tweet.user.name
            screennameLabel.text = tweet.user.screenName
            timeStampLabel.text = tweet.createdAtString
            let imageURL = URL(string: tweet.user.profileImageURL)
            profileImage.af_setImage(withURL: imageURL! )
            retweetCount.text = "\(tweet.retweetCount)"
            favoriteCount.text = "\(tweet.favoriteCount )"
            
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
    

    
    @IBAction func didTapTweet(_ sender: Any) {
        print("did tap retweet")
        if tweet.retweeted == false {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState.normal)
            tweet.retweeted = true
            tweet.retweetCount += 1
            retweetCount.text = "\(tweet.retweetCount)"
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                    self.reloadInputViews()
                }
            }
        }else {
            tweet.retweeted = false
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControlState.normal)
            tweet.retweetCount -= 1
            retweetCount.text = "\(tweet.retweetCount)"
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                    self.reloadInputViews()
                }
            }
        }
    }

    
    @IBAction func didTapFavorite(_ sender: Any) {
        print("did tap favorite")
        if tweet.favorited == false {
            tweet.favorited = true
            favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: UIControlState.normal)
            tweet.favoriteCount += 1
            favoriteCount.text = "\(tweet.favoriteCount)"
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favoriting the following Tweet: \n\(tweet.text)")
                    self.reloadInputViews()
                }
            }
        } else {
            tweet.favorited = false
            favoriteButton.setImage(UIImage(named: "favor-icon"), for: UIControlState.normal)
            tweet.favoriteCount -= 1
            favoriteCount.text = "\(tweet.favoriteCount)"
            
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavorite tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorite the following Tweet: \n\(tweet.text)")
                    self.reloadInputViews()
                }
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
