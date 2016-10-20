//
//  ProfileViewController.swift
//  TwitterClient
//
//  Created by Filiz Kurban on 10/19/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var image: UIImageView!
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserProfile()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadUserProfile() {
        API.shared.getUser { (user, error) in
            if user != nil {
                self.user = user
            OperationQueue.main.addOperation {
                self.userName.text = user?.name
                self.userLocation.text = user?.location
                }
            }
        }
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
