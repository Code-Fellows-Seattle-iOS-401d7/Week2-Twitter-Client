//
//  TimelineViewController.swift
//  TwitterClient
//
//  Created by Erica Winberry on 12/28/16.
//  Copyright © 2016 Erica Winberry. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var user: User?
    
    var userTweets = [Tweet]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userName = user?.name {
            self.title = "\(userName)'s Tweets"
        }

        self.tableView.dataSource = self
        self.tableView.delegate = self
        let nib = UINib(nibName: "TweetCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: TweetTableViewCell.identifier())
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        update()
    }
    
    func update() {
        
        API.shared.getUserTweetsFor(user: self.user!) { (tweets) in
            if tweets != nil {
                OperationQueue.main.addOperation {
                    self.userTweets = tweets!
                }
            }
        }
    }
}

extension TimelineViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier(), for: indexPath) as! TweetTableViewCell
        
        let currentTweet = self.userTweets[indexPath.row]
        
        cell.tweet = currentTweet
        
        return cell
    }
}










