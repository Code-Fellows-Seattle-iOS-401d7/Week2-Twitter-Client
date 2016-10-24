//
//  TweetTableViewCell.swift
//  TwitterClient
//
//  Created by Corey Malek on 10/19/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
  
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!


    var tweet: Tweet! {
        
        didSet{
            
            self.tweetLabel.text = tweet.text
            
            if let user = tweet.user {
                self.usernameLabel.text = user.name
                
                if let image = SimpleCache.shared.image(key: user.profileImageUrlString) {
                    userImageView.image = image
                    return
                }
                
                API.shared.getImageFor(urlString: user.profileImageUrlString, completion: { (image) in
                    if image != nil {
                        SimpleCache.shared.setImage(image!, key: user.profileImageUrlString)
                        self.userImageView.image = image!
                    }
                })
                
            }
            
        }
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        
        
        
        
    }

}
