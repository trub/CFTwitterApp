//
//  Tweet.swift
//  TwitterCF
//
//  Created by Michael Babiy on 10/26/15.
//  Copyright © 2015 Michael Babiy. All rights reserved.
//

import Foundation

//initiates tweet class
class Tweet {
    
    //add text, id JSON parameters + an optional user parameter
    let text: String
    let id: String
    var user: User?
    
    let rqText: String?
    let rqUser: User?
    
    var isRetweet: Bool
    
    //initiate text, id & user and set as itself
    init(text: String, rqText: String? = nil, id: String, user: User? = nil, rqUser: User? = nil, isRetweet: Bool = false) {
        self.text = text
        self.id = id
        self.user = user
        self.isRetweet = isRetweet
        self.rqUser = rqUser
        self.rqText = rqText
    }
}
