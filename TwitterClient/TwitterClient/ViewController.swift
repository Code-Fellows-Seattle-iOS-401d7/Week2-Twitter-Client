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

    func reverseTwitterArray() {
        self.allTweets = Utility.reverse(array: allTweets) as! [Tweet]
    }

    func update() {
        API.shared.getTweets { (tweets, error) in
            if tweets != nil {
                print("Background")
                OperationQueue.main.addOperation {  ////?????
                    self.allTweets = tweets!
                    print("Main")
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

        //textLabel and detailTextLabel comes for free
        cell.textLabel?.text = currentTweet.text
        cell.detailTextLabel?.text = currentTweet.user?.name

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexPath.row value is: ", indexPath.row)
    }
}

