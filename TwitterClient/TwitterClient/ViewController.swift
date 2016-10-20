//
//  ViewController.swift
//  TwitterClient
//
//  Created by Filiz Kurban on 10/17/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    //property observer
    var allTweets = [Tweet]() {
        didSet {
            OperationQueue.main.addOperation { 
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.dataSource = self
        self.tableView.delegate = self

        self.tableView.estimatedRowHeight = 125
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    //ViewDidAppear() is called every time the view appears on screen
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        update()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "showDetailSegue" {
            let selectedIndex = tableView.indexPathForSelectedRow!.row
            let selectedTweet = self.allTweets[selectedIndex]

            if let destinationViewController = segue.destination as? DetailViewController {
                destinationViewController.tweet = selectedTweet
            }
        } else if segue.identifier == "showProfile" {
            if let destinationViewController = segue.destination as? ProfileViewController {
            }
        }
    }


    func reverseTwitterArray() {
        self.allTweets = Utility.reverse(array: allTweets) as! [Tweet]
    }

    func checkThreads() {
        if OperationQueue.current == OperationQueue.main {
            print("on Main Thread")
        } else {
            print("on background thread")
        }
    }

    func update() {
        activityIndicator.startAnimating()
        API.shared.getTweets { (tweets, error) in
            if tweets != nil {
                self.checkThreads()
                OperationQueue.main.addOperation {
                    self.activityIndicator.stopAnimating()
                    self.allTweets = tweets!
                    self.checkThreads()
                }
            }
        }
    }
}


// MARK: TableViewDataSource and TableViewDelegate methods
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTweets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetTableViewCell
        let currentTweet = self.allTweets[indexPath.row]
        cell.tweetText.text = "==>" + currentTweet.text

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexPath.row value is: ", indexPath.row)
    }
}

