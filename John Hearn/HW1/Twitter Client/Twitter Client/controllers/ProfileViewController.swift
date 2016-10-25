//
//  ProfileViewController.swift
//  Twitter Client
//
//  Created by John D Hearn on 10/24/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileHandleLabel: UILabel!
    @IBOutlet weak var profileFollowersCountLabel: UILabel!
    @IBOutlet weak var profileFollowingCountLabel: UILabel!
    @IBOutlet weak var profileLocationLabel: UILabel!
    @IBOutlet weak var profileDescriptionLabel: UILabel!

    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        API.shared.getUserAccount(completion: { (user) in
            self.user = user

            OperationQueue.main.addOperation {
                self.profileNameLabel.text = self.user?.name
                if self.user?.handle != nil {
                    self.profileHandleLabel.text = "@" + (self.user?.handle)!
                }
                self.profileFollowersCountLabel.text = "Followers: \(self.user?.followersCount)"
                self.profileFollowingCountLabel.text = "Following: \(self.user?.followingCount)"

                if self.user?.location != nil {
                    self.profileLocationLabel.text = "\(self.user?.location)"
                }

                if self.user?.description != nil {
                    self.profileDescriptionLabel.text = self.user?.description
                } else {
                    self.profileDescriptionLabel.text = "Location Unknown"
                }
            }
        })
    }


    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

}
