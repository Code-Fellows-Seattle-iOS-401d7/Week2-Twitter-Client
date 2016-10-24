//
//  ViewController.swift
//  TwitterClient
//
//  Created by Corey Malek on 10/17/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

import UIKit
import Accounts



class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    
    var allTweets = [Tweet]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "TweetCell", bundle: nil)
        
        self.tableView.register(nib, forCellReuseIdentifier: TweetTableViewCell.identifier())
        self.tableView.estimatedRowHeight = 75
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    func setUpTableView() {
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Example Of Creating A Serial Queue
        
//        let mySerialQueue = OperationQueue()   // create an instance of Operation Queue
//        mySerialQueue.maxConcurrentOperationCount = 1 // use this method and set it = 1, implying that this operation would only happen once 
////        mySerialQueue.addOperation { // then you would use the addOperation method to add functionality to the queue.
//
//        }

        update()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "DetailViewControllerSegue" {
            let selectedIndex = tableView.indexPathForSelectedRow!.row
            let selectedTweet = self.allTweets[selectedIndex]
            
            if let destinationViewController = segue.destination as? DetailViewController {
                destinationViewController.tweet = selectedTweet
            }
        }
    }
    
    func update(){
        
        activityIndicator.startAnimating()
        
        API.shared.getUserTweetsFor { (tweets) in
            if tweets != nil {
                
                OperationQueue.main.addOperation {
                    self.allTweets = tweets!
                    self.activityIndicator.stopAnimating()
                    
                }
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier(), for: indexPath) as! TweetTableViewCell
        
        let currentTweet = self.allTweets[indexPath.row]
        
        cell.tweetLabel.text = currentTweet.text
        
        return cell
        
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "DetailViewControllerSegue", sender: nil)
    }
}


















