//
//  TweetDetailViewController.swift
//  TwitterCF
//
//  Created by Matthew Weintrub on 10/29/15.
//  Copyright © 2015 Michael Babiy. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    var tweet: Tweet!
    
    class func identifier() -> String{
        return "detailVCsegue"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.setupAppearance()
        // self.setupTweetDetailViewController()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupAppearance() {
        if self.tweet.isRetweet {
            if let rqUser = self.tweet.rqUser {
                self.navigationItem.title = rqUser.username
            } else {
                self.navigationItem.title = self.tweet.user?.username
            }
        }
        
        if let user = self.tweet.user {
            self.navigationItem.title = user.username
        }
        
        self.tweetLabel.text = self.tweet.text
        
    }
    
    func setupTweetDetailViewController() {
        self.tweetLabel.text = self.tweet.isRetweet ? self.tweet.rqText : self.tweet.text
    }
}
    


