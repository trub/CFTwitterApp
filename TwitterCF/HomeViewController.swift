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
        
        // ...pull to refresh
        let spinner = UIRefreshControl(frame: CGRectMake(0.0, 0.0, 44.0, 44.0))
        spinner.addTarget(self, action: "updateFeed:", forControlEvents: UIControlEvents.AllEvents)
        self.tableView.addSubview(spinner)
        
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
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath)
        let tweet = tweets[indexPath.row]
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = tweet.text
        //create a rainbow
        let colorChange = abs(CGFloat(indexPath.row % 20) / CGFloat(20) - 0.5)
        //change cell color
        cell.backgroundColor = UIColor(hue: 0.51, saturation: 0.2 + 0.8*colorChange, brightness: 0.77, alpha: 1)
        
        
        if let user = tweet.user {
            cell.detailTextLabel?.text = "Posted by: \(user.username)"
        } else {
            cell.detailTextLabel?.text = "Posted by: Sponsor."
        }
//        
//        tableView.estimatedRowHeight = 100
//        tableView.rowHeight = UITableViewAutomaticDimension
//        
        return cell
    }
    
    
    //custom cell layout
    
    
}
