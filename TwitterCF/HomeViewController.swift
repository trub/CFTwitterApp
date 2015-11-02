//
//  ViewController.swift
//  TwitterCF
//
//  Created by Michael Babiy on 10/26/15.
//  Copyright © 2015 Michael Babiy. All rights reserved.
//


import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setup table view
        self.setupTableView()
        //authenticate user
        self.getAccount()
        
        //make fake tweets
//        for i in 0..<30
//        {
//            tweets.append(Tweet(text: "test", id: "test"))
//        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupTableView() {
        //for the table view for this controller i am it's delegate
        self.tableView.delegate = self
        //for the table view for this controller i am it's datacourse
        self.tableView.dataSource = self
        
        //set up size of table view cell
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        let customTweetCellXib = UINib(nibName: "CustomCell", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(customTweetCellXib, forCellReuseIdentifier: CustomCellTableViewCell.identifier())
        
        // ...pull to refresh
        let spinner = UIRefreshControl(frame: CGRectMake(0.0, 0.0, 44.0, 44.0))
        spinner.addTarget(self, action: "updateFeed:", forControlEvents: UIControlEvents.AllEvents)
        self.tableView.addSubview(spinner)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == TweetDetailViewController.identifier() {
            //return tweet user clicks
            if let indexPath = self.tableView.indexPathForSelectedRow {
                //take the cell # and index the tweets array
                let tweet = self.tweets[indexPath.row]
                
                let tweetsDetailViewController = segue.destinationViewController as! TweetDetailViewController
                tweetsDetailViewController.tweet = tweet
            }
        }
    }
    
    
    
    //MARK: oct28 --> adds pull to refresh
    
    func updateFeed(sender: AnyObject) {
        
        //simulate network call
        NSOperationQueue().addOperationWithBlock { () -> Void in
            usleep(1000000)
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                if let spinner = sender as? UIRefreshControl {
                    spinner.endRefreshing()
                }
            })
        }
        
    }
    
    
    // MARK: Week 2 Class + Homework.
    
    func getAccount() {
        LoginService.loginTwitter({ (error, account) -> () in
            if let error = error {
                print(error)
                return
            }
            
            if let account = account {
                TwitterService.sharedService.account = account
                self.authenticateUser()
            }
        })
    }
    
    func authenticateUser(){
        TwitterService.getAuthUser { (error, user) -> () in
            if let error = error {
                print(error)
                return
            }
            
            if let user = user {
                TwitterService.sharedService.user = user
                self.getTweets()
            }
        }
    }
    
    func getTweets() {
        TwitterService.tweetsFromHomeTimeline { (error, tweets) -> () in
            if let error = error {
                print(error)
                return
            }
            
            if let tweets = tweets {
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tweets = tweets
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    // MARK: UITableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CustomCellTableViewCell.identifier(), forIndexPath: indexPath) as! CustomCellTableViewCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }

    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(TweetDetailViewController.identifier(), sender: nil)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(TweetDetailViewController.identifier(), sender: nil)
    }
    
}


