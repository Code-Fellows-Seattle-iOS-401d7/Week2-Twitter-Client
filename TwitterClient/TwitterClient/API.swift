//
//  API.swift
//  TwitterClient
//
//  Created by Erica Winberry on 10/18/16.
//  Copyright © 2016 Erica Winberry. All rights reserved.
//

import Foundation
import Accounts
import Social
import UIKit

typealias accountCompletion = (ACAccount?) -> ()
typealias userCompletion = (User?) -> ()
typealias tweetsCompletion = ([Tweet]?) -> ()

// class responsible for using accounts and social frameworks
// singleton
class API {
    
    static let shared = API()
    
    var account : ACAccount?
    
    // private so can only be accessed w/in this class
    private func login(completion: @escaping accountCompletion) {
        
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
      
        // include both error and success in different if statements because it's possible to get no error but not have success (because no twitter acct.)
        accountStore.requestAccessToAccounts(with: accountType, options: nil) { (success, error) in
            
            if error != nil {
                print("Error requesting access to Twitter account.")
                completion(nil)
            }
            
            if success {
                if let account = accountStore.accounts(with: accountType).first as? ACAccount {
                    completion(account)
                } else {
                    print("UNSUCCESSFUL: No Twitter account found on device!")
                    completion(nil)
                }
            
            }
            
        }
        
    }
    
    private func getOAuthUser(completion: @escaping userCompletion) {
        
        let url = URL(string: "https://api.twitter.com/1.1/account/verify_credentials.json")
        
        if let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: url, parameters: nil) {
            
            request.account = self.account
            
            request.perform(handler: { (data, response, error) in
                
                //if error, will see it.
                if error != nil {
                    print("Error accessing Twitter to verify credentials.")
                    completion(nil)
                }
            
                // if no error, but lacking either response or data, completion is passed as nil
                guard response != nil else { completion(nil); return }
                guard data != nil else { completion(nil); return }

                // now can assume that we have a response: Okay to use ! because if no value in response then we'd never have arrived at this point due to guard stmt above.
                switch response!.statusCode {
                case 200...299:
                    print("\(response!.statusCode): Success!")
                    do {
                        if let userJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any] {
                            let user = User(json: userJSON)
                            completion(user)
                        }
                    } catch {
                        print("Error: Cannot obtain credentials from Twitter.")
                    }
                case 400...499:
                    print("\(response!.statusCode): Client-side error")
                case 500...599:
                    print("\(response!.statusCode): Server-side error")
                default:
                    print("Response came back with unrecognized Status Code \(response!.statusCode)")
                }
                
//                completion(nil)
                
            })
        }
        
    }
    
    private func updateTimeLine(completion: @escaping tweetsCompletion) {
        
        let url = URL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
        
        if let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: url, parameters: nil) {
            
            request.account = self.account
            
            request.perform(handler: { (data, response, error) in
                
                if error != nil {
                    print("Error: Fetching Home Timeline failed.")
                    completion(nil)
                }
                
                guard response != nil else { completion(nil); return }
                guard data != nil else { completion(nil); return }
                
                switch response!.statusCode {
                case 200...299:
                    print("HTTP Status Code \(response!.statusCode): Success!")
                    JSONParser.tweetsFrom(data: data!, completion: { (success, tweets) in
                        // not necessary, really, because tweetsFrom will return nil if no tweets.
                        if success {
                            completion(tweets)
                        }
                        completion(nil)
                    })
                case 400...499:
                    print("HTTP Status Code \(response!.statusCode): Client-side error")
                case 500...599:
                    print("HTTP Status Code \(response!.statusCode): Server-side error")
                default:
                    print("Response came back with unrecognized Status Code \(response!.statusCode)")
                }
                completion(nil)
            })
            
        }
        
    }
    
    func getTweets(completion: @escaping tweetsCompletion) {
        if self.account != nil {
            self.updateTimeLine(completion: completion)
        }
//        else {
//            alertMsg(<#T##userMessage: String##String#>)
//        }
    
        self.login { (account) in
            if account != nil {
                self.account = account!
                self.updateTimeLine(completion: completion)
            }
            completion(nil)
        }
            
    }
    
    func getUserAccount(completion: @escaping userCompletion) {
        if self.account != nil {
            self.getOAuthUser(completion: completion)
        }
        completion(nil)
        // add something here in case there is no user account
    }
    
}
