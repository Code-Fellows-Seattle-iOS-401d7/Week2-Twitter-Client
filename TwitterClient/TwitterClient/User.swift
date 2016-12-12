//
//  User.swift
//  TwitterClient
//
//  Created by Erica Winberry on 10/17/16.
//  Copyright © 2016 Erica Winberry. All rights reserved.
//

import Foundation


class User {
    
    let name: String
    let profileImageUrlString: String
    let location: String?
    let screenName: String?
    let description: String?
    let followersCount: Int?
    let friendsCount: Int?
    //add more constants here from json, but make sure they're optional
    
    init?(json: [String: Any]) {
        if let name = json["name"] as? String, let imageString = json["profile_image_url"] as? String {
            
            self.name = name
            self.profileImageUrlString = imageString
            self.location = json["location"] as? String
            self.screenName = json["screen_name"] as? String
            self.description = json["description"] as? String
            self.followersCount = json["followers_count"] as? Int
            self.friendsCount = json["friends_count"] as? Int
            
        } else {
            return nil
        }
        
    }
    
}
