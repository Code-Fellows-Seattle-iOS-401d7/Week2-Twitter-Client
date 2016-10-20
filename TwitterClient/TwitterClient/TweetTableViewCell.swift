//
//  TweetTableViewCell.swift
//  TwitterClient
//
//  Created by Filiz Kurban on 10/19/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
