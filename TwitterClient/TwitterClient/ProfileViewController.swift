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
    
    @IBOutlet weak var descriptionTextLabel: UILabel!
    
    @IBOutlet weak var profileActivityIndicator: UIActivityIndicatorView!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileActivityIndicator.startAnimating()
        
        API.shared.getUserAccount(completion: { (user) in
            OperationQueue.main.addOperation {
                self.user = user
                self.profileActivityIndicator.stopAnimating()
                self.profileNameText.text = self.user?.name
                if self.user?.screenName != nil {
                    self.screenNameText.text = "@" + (self.user?.screenName)!
                }
                if self.user?.location != nil {
                    self.locationTextLabel.text = "Location: " + (self.user?.location)!
                }
                if self.user?.description != nil {
                    self.descriptionTextLabel.text = self.user?.description
                    
                }
            }
        })
        
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
