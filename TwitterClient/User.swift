//
//  User.swift
//  TwitterClient
//
//  Created by Filiz Kurban on 10/17/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import Foundation

class User {
    let name: String
    let profileImageUrlString: String
    let location: String?
    let screenName: String?
    let userId: String

    //fallable initializer, if we can't create a user object then return nil to indicate that
    init?(json: [String: Any]) {
        if let name = json["name"] as? String, let pius = json["profile_image_url_https"] as? String, let user_id = json["id_str"] as? String {
            self.name = name
            self.profileImageUrlString = pius
            self.userId = user_id
            self.location = json["location"] as? String // if this fails we have nil as value.
            self.screenName = json["screen_name"] as? String

        } else {
            return nil
        }
    }
}
