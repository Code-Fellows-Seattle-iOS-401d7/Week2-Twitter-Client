//
//  DetailViewController.swift
//  TwitterClient
//
//  Created by Erica Winberry on 10/19/16.
//  Copyright © 2016 Erica Winberry. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var tweetUserViewLabel: UILabel!
        
    @IBOutlet weak var tweetViewLabel: UILabel!
    
    @IBOutlet weak var tweetDetailImageView: UIImageView!
    
    @IBAction func userImageTapped(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            print("Tap on user icon...")
        }
        self.performSegue(withIdentifier: "timelineViewControllerSegue", sender: sender)
    }
    
    var tweet: Tweet! 
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let userName = tweet.user?.name {
            self.title = "Tweet from \(userName)"
        }
        
        self.tweetUserViewLabel.text = tweet.user?.name
        self.tweetViewLabel.text = tweet.text
        

        if let user = tweet.user {
            if let image = SimpleCache.shared.image(key: user.profileImageUrl) {
                NSLog("Image: \(image)")
                self.tweetDetailImageView.image = image
                return
            }
            
            API.shared.getImageFor(urlString: user.profileImageUrl, completion: { (image) in
                if image != nil {
                    SimpleCache.shared.setImage(image!, with: user.profileImageUrl)
                    self.tweetDetailImageView.image = image!
                }
            })
        }
    }
  

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         super.prepare(for: segue, sender: sender)
        
//        if segue.identifier == "timelineViewControllerSegue" {
//            let user = tweet.user
//        }
        
        if let destinationViewController = segue.destination as? TimelineViewController {
            destinationViewController.user = tweet.user
        }
    }
    
}

//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    super.prepare(for: segue, sender: sender)
//    
//    if segue.identifier == "detailViewControllerSegue" {
//        let selectedIndex = tableView.indexPathForSelectedRow!.row
//        let selectedTweet = self.allTweets[selectedIndex]
//        
//        if let destinationViewController = segue.destination as? DetailViewController {
//            destinationViewController.tweet = selectedTweet
//        }
//    }
//}



