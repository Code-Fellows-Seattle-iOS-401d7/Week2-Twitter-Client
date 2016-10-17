//
//  ViewController.swift
//  Twitter Client
//
//  Created by John D Hearn on 10/17/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var allTweets = [Tweet]() {
        didSet{
            tableView.reloadData()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        JSONParser.tweetsFrom(data: JSONParser.sampleJSONData) { (success, results) in
            if success{
                if let tweets = results{
                    allTweets = tweets
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return allTweets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath)
        let currentTweet = self.allTweets[indexPath.row]

        cell.textLabel?.text = currentTweet.text
        cell.detailTextLabel?.text = currentTweet.user?.handle
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
}
