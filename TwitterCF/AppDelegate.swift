//
//  AppDelegate.swift
//  TwitterCF
//
//  Created by Michael Babiy on 10/26/15.
//  Copyright © 2015 Michael Babiy. All rights reserved.
//


import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.setupAppearance()
        return true
    }
    
    func setupAppearance() {
        UITabBar.appearance().tintColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 1.0)

//        //get reference to the window
//        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
//        //create viewController
//        let rootViewController = HomeViewController()
//        let navController = UINavigationController(rootViewController: rootViewController)
//        self.window!.rootViewController = navController
//        self.window?.makeKeyAndVisible()
    
    }
}


