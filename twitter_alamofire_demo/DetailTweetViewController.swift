//
//  DetailTweetViewController.swift
//  twitter_alamofire_demo
//
//  Created by Melissa Phuong Nguyen on 3/5/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class DetailTweetViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    var tweet: Tweet?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tweet = tweet {
            tweetTextLabel.text = tweet.text
            usernameLabel.text = tweet.user.name
            screennameLabel.text = tweet.user.screenName
            timeStampLabel.text = tweet.createdAtString
            let imageURL = URL(string: tweet.user.profileImageURL)
            profileImage.af_setImage(withURL: imageURL! )
            retweetCount.text = "\(tweet.retweetCount) RETWEETS"
            favoriteCount.text = "\(tweet.favoriteCount ) FAVORITES"

        }
    }

    
    
    
    
    @IBAction func didTapReply(_ sender: Any) {
        
    }
    
    @IBAction func didTapRetweet(_ sender: Any) {
        print("did tap retweet")
        if tweet?.retweeted == false {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState.normal)
            tweet?.retweeted = true
            tweet?.retweetCount += 1
            retweetCount.text = "\(tweet!.retweetCount) RETWEETS"
            APIManager.shared.retweet(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                    self.reloadInputViews()
                }
            }
        }else {
            tweet?.retweeted = false
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControlState.normal)
            tweet?.retweetCount -= 1
            retweetCount.text = "\(tweet!.retweetCount) RETWEETS"
            APIManager.shared.unretweet(tweet!) { (tweet: Tweet?, error: Error?) in
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
        if tweet?.favorited == false {
            tweet?.favorited = true
            favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: UIControlState.normal)
            tweet?.favoriteCount += 1
            favoriteCount.text = "\(tweet!.favoriteCount) FAVOTITES"
            APIManager.shared.favorite(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favoriting the following Tweet: \n\(tweet.text)")
                    self.reloadInputViews()
                }
            }
        } else {
            tweet?.favorited = false
            favoriteButton.setImage(UIImage(named: "favor-icon"), for: UIControlState.normal)
            tweet?.favoriteCount -= 1
            favoriteCount.text = "\(tweet!.favoriteCount)"
            
            APIManager.shared.unfavorite(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavorite tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorite the following Tweet: \n\(tweet.text)")
                    self.reloadInputViews()
                }
            }
        }
    }
    
    
    @IBAction func didTapDone(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
