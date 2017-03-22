//
//  ProfileViewController.swift
//  TwitterClient
//
//  Created by Erica Winberry on 10/19/16.
//  Copyright © 2016 Erica Winberry. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileNameText: UILabel!
    
    @IBOutlet weak var screenNameText: UILabel!
    
    @IBOutlet weak var locationTextLabel: UILabel!
    
    @IBOutlet weak var followersTextLabel: UILabel!
    
    @IBOutlet weak var friendsTextLabel: UILabel!
    
    @IBOutlet weak var descriptionTextLabel: UILabel!
    
    @IBOutlet weak var profileActivityIndicator: UIActivityIndicatorView!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileActivityIndicator.startAnimating()
        
        API.shared.getUserAccount(completion: { (user) in
            self.user = user
            OperationQueue.main.addOperation {
                self.profileActivityIndicator.stopAnimating()
                self.profileNameText.text = self.user?.name
                if self.user?.screenName != nil {
                    self.screenNameText.text = "@" + (self.user?.screenName)!
                } 
                if self.user?.location != nil {
                    self.locationTextLabel.text = "Location: " + (self.user?.location)!
                }
                self.followersTextLabel.text = "# of Followers: \(self.user?.followersCount)"
                self.friendsTextLabel.text = "# of Friends: " + String(describing: self.user?.friendsCount)
                if self.user?.description != nil {
                    self.descriptionTextLabel.text = self.user?.description
                } else {
                    self.descriptionTextLabel.text = ""
                }
            }
        })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
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
