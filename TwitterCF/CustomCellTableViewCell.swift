//
//  CustomCellTableViewCell.swift
//  TwitterCF
//
//  Created by Matthew Weintrub on 11/2/15.
//  Copyright © 2015 Michael Babiy. All rights reserved.
//

import UIKit

class CustomCellTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var tweet: Tweet? {
        
        didSet {
            if let tweet = self.tweet, user = tweet.user, text = self.tweet?.text {
                
                self.label.text = text
                
                if let image = user.image {
                    self.imgView.image = image
                } else {
                    if let url = NSURL(string: user.profileImageURL) {
                        let downloadQ = dispatch_queue_create("downloadQ", nil)
                        dispatch_async(downloadQ, { () -> Void in
                            let imageData = NSData(contentsOfURL: url)!
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                let image = UIImage(data: imageData)
                                self.imgView.image = image
                                user.image = image
                            })
                        })
                    }
                }
            }
        }
        
    }
    
    class func identifier() -> String {
        return "CustomCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
