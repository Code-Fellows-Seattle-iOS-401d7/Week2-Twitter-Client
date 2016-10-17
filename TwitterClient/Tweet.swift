//
//  Tweet.swift
//  TwitterClient
//
//  Created by Filiz Kurban on 10/17/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import Foundation

class Tweet {
    let text: String
    let id: String
    let user: User?

    init?(json: [String: Any]) {
        //optional chaining below if statement
        if let text = json["text"] as? String, let id = json["id_str"] as? String, let userDict = json["user"] as? [String: Any] {
            //self.text = String(text) // you can't downcast an Any to String, so we're extracting text to be A
            self.text = text
            self.id = id
            self.user = User(json: userDict)
        } else {
            return nil
        }
    }
}
