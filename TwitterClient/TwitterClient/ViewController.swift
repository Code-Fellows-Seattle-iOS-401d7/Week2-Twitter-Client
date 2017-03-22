//
//  ViewController.swift
//  TwitterClient
//
//  Created by Erica Winberry on 10/17/16.
//  Copyright © 2016 Erica Winberry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var allTweets = [Tweet]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // called only the first time that the view loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    // setting dataSource and delegate in a setupTableView func helps make the view setup explicit to anyone else looking at the code later on (or me, when I can't remember where this happens), especially if there is a lot of complexity.
    func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    // This func is called every time the view appears on screen
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        update()
    }

    func update() {
        API.shared.getTweets { (tweets) in
            if tweets != nil {
                OperationQueue.main.addOperation {
                    self.allTweets = tweets!
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath)
        
        let currentTweet = self.allTweets[indexPath.row]
        
        cell.textLabel?.text = currentTweet.text
        
        cell.detailTextLabel?.text = currentTweet.user?.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("User clicked on tweet at index \(indexPath.row)")
    }
}


