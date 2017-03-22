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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var allTweets = [Tweet]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    //    var profileInfo: User?
    
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
        let nib = UINib(nibName: "TweetCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: TweetTableViewCell.identifier())
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // This func is called every time the view appears on screen
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        update()
    }
    
    func update() {
        
        activityIndicator.startAnimating()
        
        API.shared.getTweets { (tweets) in
            if tweets != nil {
                OperationQueue.main.addOperation {
                    self.allTweets = tweets!
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "detailViewControllerSegue" {
            let selectedIndex = tableView.indexPathForSelectedRow!.row
            let selectedTweet = self.allTweets[selectedIndex]
            
            if let destinationViewController = segue.destination as? DetailViewController {
                destinationViewController.tweet = selectedTweet
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier(), for: indexPath) as! TweetTableViewCell
        
        let currentTweet = self.allTweets[indexPath.row]
        
        // can do this because we force cast the cell as TweetTableViewCell two lines of code above.
        
        cell.tweet = currentTweet
        
        // polymporphism in action: actually now returning TweetTableViewCell now, because it is a subclass of UITableViewCell.
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailViewControllerSegue", sender: nil)
        print("User clicked on tweet at index \(indexPath.row)")
    }
    
}


