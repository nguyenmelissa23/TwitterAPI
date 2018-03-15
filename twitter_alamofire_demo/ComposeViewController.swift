//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Melissa Phuong Nguyen on 3/13/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate {
    func did(post : Tweet)
    
}

class ComposeViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate{
    

    @IBOutlet weak var textView: UITextField!
    
    @IBOutlet weak var charCount: UIBarButtonItem!
    
    var delegate: ComposeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    // TO DO: display character count down
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let characterLimit = 140
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
//        let characterLeft = "\(characterLimit - newText.characters.count)"
//        print("newText.characters.count", newText.characters.count)
////        charCount.setTitleTextAttributes(characterLeft, for: .normal)
        return newText.characters.count < characterLimit
    }

    
    @IBAction func didTapPost(_ sender: Any) {
        APIManager.shared.composeTweet(with: textView.text!){ (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            }
        }
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
