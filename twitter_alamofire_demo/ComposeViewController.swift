//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Melissa Phuong Nguyen on 3/13/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
protocol ComposeViewControllerDelegate {
    func did(post : Tweet)
    
}

class ComposeViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate{
    


    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var charCount: UIBarButtonItem!
    
    var delegate: ComposeViewControllerDelegate?
    var currentText: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        if let user = User.current{
            usernameLabel.text = user.name
            screennameLabel.text = user.screenName
            let image = URL(string: user.profileImageURL)
            profileImage.af_setImage(withURL: image!)
            charCount.title = "140"
            textView.text = ""
        }
        // Do any additional setup after loading the view.
    }
    
    // TO DO: display character count down
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // TODO: Check the proposed new text character count
        // Allow or disallow the new text
        print("text:", textView.text)
        let characterLimit = 140
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)

        self.charCount.title = "\(characterLimit - newText.count)"

        print("newText.count", newText.count)
        return newText.count < characterLimit
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if (self.currentText) != nil{
            
        }
        

    }
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        <#code#>
//    }

    
    @IBAction func didTapPost(_ sender: Any) {
        APIManager.shared.composeTweet(with: textView.text!){ (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
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
