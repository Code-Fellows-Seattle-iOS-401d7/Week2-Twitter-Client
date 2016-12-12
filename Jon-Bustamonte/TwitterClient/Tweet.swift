//
//  Tweet.swift
//  TwitterClient
//
//  Created by Jonathan Bustamonte on 10/17/16.
//  Copyright © 2016 Jonathan Bustamonte. All rights reserved.
//

import Foundation

class Tweet {
    let text: String
    let id: String
    let user: User?
    
    init?(json: [String: Any]) {
        if let text = json["text"] as? String, let id = json["id_str"] as? String, let userDict = json["user"] as? [String: Any] {
           
            self.id = id
            self.text = text
            self.user = User(json: userDict)
            
        } else {
            return nil
        }
    }
}
