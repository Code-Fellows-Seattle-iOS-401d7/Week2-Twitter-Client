//
//  DetailViewController.swift
//  TwitterClient
//
//  Created by Filiz Kurban on 10/19/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var user: UILabel!

    var tweet: Tweet!
    @IBOutlet weak var tweetText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweetDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadTweetDetails() {
        self.user.text = tweet.user?.name
        self.tweetText.text = tweet.text
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
