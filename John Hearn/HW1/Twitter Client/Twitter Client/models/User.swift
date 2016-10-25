//
//  User.swift
//  Twitter Client
//
//  Created by John D Hearn on 10/17/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

import Foundation

class User{

    let name: String
    let handle: String
    let profileImageUrlString: String
    let location: String?
    let description: String?
    let followingCount: Int
    let followersCount: Int

    init?(json: [String: Any]) {
        if  let name = json["name"] as? String,
            let handle = json["screen_name"] as? String,
            let imageString = json["profile_image_url_https"] as? String,
            let followingCount = json["friends_count"] as? Int,
            let followersCount = json["followers_count"] as? Int {

            self.name = name
            self.handle = handle
            self.profileImageUrlString = imageString
            self.location = json["location"] as? String
            self.description = json["description"] as? String
            self.followingCount = followingCount
            self.followersCount = followersCount

        } else {
            return nil
        }
    }

}
