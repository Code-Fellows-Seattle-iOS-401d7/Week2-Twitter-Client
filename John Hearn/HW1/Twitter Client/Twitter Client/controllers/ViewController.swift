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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var allTweets = [Tweet]() {
        didSet{
            tableView.reloadData()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.estimatedRowHeight = 75
        self.tableView.rowHeight = UITableViewAutomaticDimension

        self.tableView.dataSource = self   // We originally set this in the StoryBoard. (Blech)
        self.tableView.delegate = self

        let nib = UINib(nibName: "TweetCell", bundle: Bundle.main)
        self.tableView.register(nib, forCellReuseIdentifier: TweetTableViewCell.identifier())


        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        update()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if segue.identifier == "DetailViewControllerSegue"{
            let selectedIndex = tableView.indexPathForSelectedRow!.row
            let selectedTweet = self.allTweets[selectedIndex]

            if let destinationViewController = segue.destination as? DetailViewController{
                destinationViewController.tweet = selectedTweet
            }
        }
    }

    func update() {

        activityIndicator.startAnimating()
        API.shared.getTweets{ (tweets) in
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

// MARK: TableViewDatSource and TableViewDelegate methods
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return allTweets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier(), for: indexPath) as? TweetTableViewCell
        let currentTweet = self.allTweets[indexPath.row]


        cell?.tweet = currentTweet
        // Storyboard implementation:
        //cell.tweetTextLabel.text = currentTweet.text

        //TODO: Custom cell broke subtitle
        //cell.detailTextLabel?.text = currentTweet.user?.handle
        
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "DetailViewControllerSegue", sender: nil)
    }

}
