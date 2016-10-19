//
//  API.swift
//  TwitterClient
//
//  Created by Filiz Kurban on 10/18/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import Foundation
import Accounts
import Social

typealias accountCompletion = (ACAccount?, String?) -> ()
typealias userCompletion = (User?, String?) -> ()
typealias tweetsCompletion = ([Tweet]?, String?) -> ()

class API {
    static let shared = API()

    var account: ACAccount?

    private func login(completion: @escaping accountCompletion) {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)


        //where the async call starts here???
        accountStore.requestAccessToAccounts(with: accountType, options: nil, completion: ({ (success, error) in
            if error != nil {
                print("ERROR: Requesting access to Twitter account")
                completion(nil, error?.localizedDescription)
            }

            if success {
                if let account = accountStore.accounts(with: accountType).first as? ACAccount {
                    completion(account, error?.localizedDescription)
                }
            } else {
                print ("UNSUCCESSFUL: No Twitter Acoounts found on device")
                completion(nil, error?.localizedDescription)
            }

        }))
    }

    private func getOAuthUser(completion: @escaping userCompletion) {
        let url = URL(string: "https://api.twitter.com/1.1/account/verify_credentials.json")

        if let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: url, parameters: nil) {
            request.account = self.account
            request.perform(handler: { (data, response, error) in
                if error != nil {
                    print("Error accessing Twitter to verify credentials.")
                }

                guard response != nil else { completion(nil, error?.localizedDescription); return }
                guard data != nil else { completion(nil, error?.localizedDescription); return }

                switch response!.statusCode {
                case 200...299:
                    print("Success")
                    do {
                        if let userJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:Any] {
                            let user = User(json: userJSON)
                            completion(user, error?.localizedDescription)
                        }
                    } catch {
                        print ("Error can not serialize data")
                    }
                case 400...499:
                    print("/(response?.statusCode): Client-side error")
                case 500...599:
                    print("/(response?.statusCode): Server-side error")
                default:
                    print("Unrecognized Status Code")
                }

                completion(nil, error?.localizedDescription)

            })
        }
    }

    private func updateTimeline(completion: @escaping tweetsCompletion) {

        let url = URL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")

        if let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: url, parameters: nil) {
            request.account = self.account
            request.perform(handler: { (data, response, error) in
                if error != nil {
                    print("Error: Fetching Home Timeline")
                    completion(nil, error?.localizedDescription)
                }

                guard response != nil else { completion(nil, error?.localizedDescription); return }
                guard data != nil else { completion(nil, error?.localizedDescription); return }

                switch response!.statusCode {
                case 200...299:
                    print("Success")
                    JSONParser.tweetsFrom(data: data!) { (success, tweets) in
//                      if success {
//                          completion(tweets)
//                       } else {
//                           completion(nil)
//                       }
                        completion(tweets, error?.localizedDescription) //tweets is an optional, so it's ok to send nil or tweets object here.
                    }
                case 400...499:
                    print("/(response?.statusCode): Client-side error")
                case 500...599:
                    print("/(response?.statusCode): Server-side error")
                default:
                    print("Unrecognized Status Code")
                }
                completion(nil, error?.localizedDescription)
            })
        }
    }

    func getTweets(completion: @escaping tweetsCompletion) {
        //OperationQueue().addOperation {
        if self.account != nil {
            self.updateTimeline(completion: completion)
        }

        self.login { (account, error ) in
            if account != nil {
                API.shared.account = account!
                self.updateTimeline(completion: completion)
            }
            completion(nil, error)
        }
    }
}














