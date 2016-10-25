//
//  TweetTableViewCell.swift
//  Twitter Client
//
//  Created by John D Hearn on 10/19/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var handleLabel: UILabel!

    var tweet: Tweet!{
        didSet{
            self.tweetTextLabel.text = tweet.text
            if let user = tweet.user{
                self.handleLabel.text = user.handle

                if let image = SimpleCache.shared.image(key: user.profileImageUrlString) {
                    userImageView.image = image
                    return

                }

                // refactor this into something readable
                API.shared.getImageFor(urlString: user.profileImageUrlString, completion: {(image) in
                    if image != nil {
                        SimpleCache.shared.set(key: user.profileImageUrlString, image: image!)
                        self.userImageView.image = image!
                    }
                })
            }
        }
    }

    func handleImageCompletion(image: UIImage) {
        // put refactored completion here (for readibility)

    }

    override func awakeFromNib() {
        super.awakeFromNib()

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
