//
//  Tweet.swift
//  TwitterClient
//
//  Created by Erica Winberry on 10/17/16.
//  Copyright © 2016 Erica Winberry. All rights reserved.
//

import Foundation


class Tweet {
    
    let text: String
    let id: String
    let user: User?
    
    init?(json: [String: Any]) {
        
        if let text = json["text"] as? String, let id = json["id_str"] as? String, let userDict = json["user"] as? [String: Any] {
            
            self.text = text
            self.id = id
            self.user = User(json: userDict)
            
        } else {
            return nil
        }
    }
    
}
