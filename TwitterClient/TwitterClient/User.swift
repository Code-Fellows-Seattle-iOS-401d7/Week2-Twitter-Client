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
    let profileImageUrl: String
    let screenName: String
    let location: String?
    let description: String?
    let followersCount: Int
    let friendsCount: Int
    //add more constants here from json, but make sure they're optional
    
    init?(json: [String: Any]) {
        if let name = json["name"] as? String, let imageString = json["profile_image_url_https"] as? String, let screenName = json["screen_name"] as? String, let followersCount = json["followers_count"] as? Int, let friendsCount =  json["friends_count"] as? Int {
            
            self.name = name
            self.profileImageUrl = imageString
            self.screenName = screenName
            self.location = json["location"] as? String
            self.description = json["description"] as? String
            self.followersCount = followersCount
            self.friendsCount = friendsCount
            
        } else {
            return nil
        }
        
    }
    
}
