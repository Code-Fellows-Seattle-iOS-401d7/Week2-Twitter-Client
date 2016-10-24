//
//  API.swift
//  TwitterClient
//
//  Created by Corey Malek on 10/18/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

import Foundation
import Accounts
import Social
import UIKit

typealias accountCompletion = (ACAccount?) -> ()
typealias userCompletion = (User?) -> ()
typealias tweetsCompletion = ([Tweet]?) -> ()
typealias imageCompletion = (UIImage?) -> ()


class API {
    static let shared = API() //singleton
    
    var account : ACAccount?
    
    private func login(completion: @escaping accountCompletion) {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccounts(with: accountType, options: nil) { (success, error) in
            if error != nil {
                print("Error: requesting access to Twitter account")
                completion(nil)
            }
            
            if success {
                if let account = accountStore.accounts(with: accountType).first as?
                    ACAccount {
                    completion(account)
                }
                
            } else {
                print("unsuccessful: No Twitter Accounts Found On Device.")
                completion(nil)
            }
        }
    
    }
        private func getOAuthUser(completion: @escaping userCompletion) {
            
            let url = URL(string: "https://api.twitter.com/1.1/account/verify_credentials.json")
            
            if let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: url, parameters: nil) {
                
                request.account = self.account
                
                request.perform(handler: { (data, response, error) in
                    if error != nil {
                        print("Error accessing Twitter to verify credentials.")
                    }
                    
                    guard response != nil else { completion(nil); return }
                    guard data != nil else { completion(nil); return }
                    
                    
                    switch response!.statusCode {
                    case 200...299:
                        do {
                            if let userJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any] {
                                completion(User(json: userJSON))
                            }
                        } catch {
                            print("Error: cannot serialize data")
                        }
                        
                    case 400...499:
                        print("\(response!.statusCode): Client-side error")
                    case 500...599:
                        print("\(response!.statusCode): Server-side error")
                    default:
                        print("Unrecognized Status Code")
                        
                    }
                    
                    completion(nil)
                    
                    
                })
                
                
            }
            
        }

    
    private func updateTimeline(url: String ,completion: @escaping tweetsCompletion) {
//                let url = URL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
        
                if let request = SLRequest(
                    forServiceType: SLServiceTypeTwitter,
                    requestMethod: .GET,
                    url: URL(string: url),
                    parameters: nil) {
                    
                    request.account = self.account
                    
                    request.perform(handler: { (data, response, error) in
                        if error != nil {
                            print("Fetching Home Timeline Failed")
                            completion(nil)
                        }
                        
                        guard response != nil else { completion(nil); return }
                        guard data != nil else { completion(nil); return }
                        
                        switch response!.statusCode {
                        case 200...299:
                            JSONParser.tweetsFrom(data: data!, completion: { (success, tweets) in
                                if success {
                                    completion(tweets)
                                }
                                completion(nil)
                            })
                            
                        case 400...499:
                            print("\(response!.statusCode): Client-side error")
                        case 500...599:
                            print("\(response!.statusCode): Server-side error")
                        default:
                            print("Response came back with unrecognized status code")
                        }
                        completion(nil)
                        
                    })
                    
                }
                
                
            }

    func getUserAccount(completion: @escaping userCompletion) {
        if self.account != nil {
           self.getOAuthUser(completion: completion)
        }
        completion(nil)
        // add something here in case there is no user account
    }
    
    func getUserTweetsFor(username: String, completion: @escaping tweetsCompletion) {
        
        self.updateTimeline(url: "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=\(username)", completion: completion)
        
    }
    
    func getImageFor(urlString: String, completion: @escaping imageCompletion) {
        
        OperationQueue().addOperation {
            guard let url = URL(string: urlString) else { return }
            
            print(url)
            
            
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else { return }
                
                OperationQueue.main.addOperation {
                    completion(image)
                }
            } catch {
                print("There was an error getting the data from the url for the UIImage.")
                OperationQueue.main.addOperation {
                    completion(nil)
                }
            }
            
        }
        
    }

}

























