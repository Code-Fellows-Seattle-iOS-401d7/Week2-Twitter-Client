//
//  TweetTableViewCell.swift
//  Twitter Client
//
//  Created by John D Hearn on 10/19/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
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
