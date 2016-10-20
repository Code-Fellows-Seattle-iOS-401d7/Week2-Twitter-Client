//
//  DetailViewController.swift
//  Twitter Client
//
//  Created by John D Hearn on 10/19/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var tweet: Tweet!


    override func viewDidLoad() {
        super.viewDidLoad()

        print("User's name: \(tweet.user!.name)")
        print("Tweet Text: \(tweet.text)")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
