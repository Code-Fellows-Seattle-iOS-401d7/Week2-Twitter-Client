//
//  ViewController.swift
//  TwitterClient
//
//  Created by Jacob Dobson on 10/17/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //outlets
    @IBOutlet weak var tableView: UITableView!
    
    var allTweets = [Tweet]() {
        didSet { // didSet is a property observer, will fire off once complete
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //set up delegate and dataSoure
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        JSONParser.tweetsFrom(data: JSONParser.sampleJSONData) { (success, results) in
            if success {
                if let tweets = results {
                    self.allTweets = tweets
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


// Best practice is to write your dataSource as an extension

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    //implement required methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath)
        let currentTweet = self.allTweets[indexPath.row]
        cell.textLabel?.text = currentTweet.text
        cell.detailTextLabel?.text = currentTweet.user?.name // need to show the userName instead of id
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

