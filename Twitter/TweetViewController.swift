//
//  TweetViewController.swift
//  Twitter
//
//  Created by Paulo Sousa on 10/15/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var tweetLabel: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if(!tweetLabel.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetLabel.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting tweet: \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        }
        
    }
    

}
