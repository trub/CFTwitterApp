//
//  User.swift
//  TwitterCF
//
//  Created by Matthew Weintrub on 10/28/15.
//  Copyright © 2015 Michael Babiy. All rights reserved.
//

import UIKit

//creates user to reinforce single responsibility
class User {
    //
    var username: String
    let profileImageURL: String
    var image: UIImage?
    
    init(username: String, profileImageURL: String) {
        self.username = username
        self.profileImageURL = profileImageURL
        
    }
}