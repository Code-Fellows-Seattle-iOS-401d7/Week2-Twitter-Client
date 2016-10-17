//
//  JSONParser.swift
//  Twitter Client
//
//  Created by John D Hearn on 10/17/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

import Foundation

typealias JSONParserCompletion = ( _ success: Bool, _ results: [Tweet]?) -> ()

class JSONParser {

    static var sampleJSONData: Data?

    class func tweetsFrom(data: Data, completion: JSONParserCompletion){
        do {
            if let rootObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            as? [ [String: Any] ] {

                var tweets = [Tweet]()

                for object in rootObject {
                    if let tweet = Tweet(json: object) {
                        tweets.append(tweet)
                    }
                }
                completion(true, tweets)
            }
        } catch {
            print("Error Serializing JSON")
            completion(false, nil)
        }
    }

}
