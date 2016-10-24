//
//  UserTimelineViewController.swift
//  TwitterClient
//
//  Created by Filiz Kurban on 10/22/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var user: User!
    var tweets = [Tweet]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        let nib = UINib(nibName: "TweetCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: TweetTableViewCell.identifier())

        self.tableView.estimatedRowHeight = 125
        self.tableView.rowHeight = UITableViewAutomaticDimension

    }

    override func viewDidAppear(_ animated: Bool) {
        API.shared.getUserTweetsFor(userName: user.userId) { (tweets, error) in
            if error == nil {
            OperationQueue.main.addOperation {
                self.tweets = tweets!
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: TableViewDataSource and TableViewDelegate methods
extension UserTimelineViewController: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier(), for: indexPath) as! TweetTableViewCell
        let currentTweet = self.tweets[indexPath.row]
        cell.tweet = currentTweet
        tableView.headerView(forSection: 1)
        return cell
    }

}

