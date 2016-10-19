//
//  JSONParser.swift
//  TwitterClient
//
//  Created by Filiz Kurban on 10/17/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import Foundation

typealias JSONParserCompletion = (_ success: Bool, _ results: [Tweet]?) -> ()

class JSONParser {

    static var sampleJSONData: Data {
        guard let tweetJSONPath = Bundle.main.url(forResource: "Twitter", withExtension: ".json") else { fatalError("There was an error accessing Tweet.json") }
        do {
            let tweetJSONData = try Data(contentsOf: tweetJSONPath) //  this never returns nil, for error case it returns an error and we catch that in the catch block
            return tweetJSONData
        } catch {
            fatalError("Failed to convert Tweet.json to data")
        }
    }

    class func tweetsFrom(data: Data, completion: JSONParserCompletion) {
        do {
            if let rootObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:Any]] {
                //[[String:Any]] means and array of dictionaries
                var tweets = [Tweet]()

                for object in rootObject {
                    if let tweet = Tweet(json: object) {// object is one dictionary for one tweet
                        tweets.append(tweet)
                    }
                }
                completion(true, tweets)
            }
        } catch {
            print("Error Serializing JSON", error)
            completion(false, nil)
        }
    }
}
