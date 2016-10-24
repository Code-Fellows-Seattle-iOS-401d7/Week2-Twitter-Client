//
//  DetailViewController.swift
//  TwitterClient
//
//  Created by Filiz Kurban on 10/19/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var tweetHandle: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var image: UIImageView!

    var tweet: Tweet! 

    override func viewDidLoad() {
        super.viewDidLoad()

        image.isUserInteractionEnabled = true
        let tapRecognizer =  UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        image.addGestureRecognizer(tapRecognizer)

        self.tweetHandle.text = tweet.user?.name
        self.tweetText.text = tweet.text

        if let user = tweet.user {
            if let image = SimpleCache.shared.image(key: user.profileImageUrlString) {
                self.image.image = image
                return
            }

            API.shared.getImageFor(urlString: user.profileImageUrlString, completion: { (image) in
                if image != nil {
                    SimpleCache.shared.setImage(image!, key: user.profileImageUrlString)
                    self.image.image = image
                }
            })
        }
    }

    func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "userTweets", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userTweets" {
            if let destinationViewController = segue.destination as? UserTimelineViewController {
                destinationViewController.user = tweet.user
            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
