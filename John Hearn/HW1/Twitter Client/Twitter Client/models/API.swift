//
//  API.swift
//  Twitter Client
//
//  Created by John D Hearn on 10/18/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

import Foundation
import Accounts
import Social
import UIKit


typealias accountCompletion = (ACAccount?)->()
typealias userCompletion = (User?)->()
typealias tweetsCompletion = ([Tweet]?)->()
typealias imageCompletion = (UIImage?)->()

class API{
    static let shared = API()

    var account: ACAccount?

    private func login(completion: @escaping accountCompletion) {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)

        accountStore.requestAccessToAccounts(with: accountType, options: nil) {(success, error) in
            if error != nil{
                print("ERROR: Requesting access to Twitter account")
                completion(nil)
            }

            if success{
                if let account = accountStore.accounts(with: accountType).first as? ACAccount{
                    completion(account)
                }
            } else {
                print("UNSUCESSFUL: No Twitter Accounts found on device.")
                completion(nil)
            }
        }
    }

    private func getOAuthUser(completion: @escaping userCompletion) {

        let url = URL(string: "https://api.twitter.com/1.1/account/verify_credentials.json")

        if let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                                   requestMethod: .GET,
                                   url: url,
                                   parameters: nil) {

            request.account = self.account

            request.perform(handler: { (data, response, error) in
                if error != nil{
                    print("Error accessing Twitter to verify credentials")
                    completion(nil)
                }

                guard response != nil else { completion(nil); return }
                guard data != nil else { completion(nil); return }

                switch response!.statusCode{
                case 200...299:
                    do{
                        if let userJSON = try JSONSerialization.jsonObject(with: data!,
                                                                           options: .mutableContainers)
                            as? [String: Any]{

                            completion( User(json: userJSON) )

                        }
                    } catch {
                        print("Error: Cannot serialize Data")
                    }
                case 400...499: print("\(response!.statusCode): Client-Side error"); completion(nil)
                case 500...599: print("\(response!.statusCode): Server-Side error"); completion(nil)
                default:        print("Response came bach with unrecognized status code"); completion(nil)

                }
            })
        }
    }

    private func updateTimeline(url: String, completion: @escaping tweetsCompletion){

        if let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                                   requestMethod: .GET,
                                   url: URL(string: url),
                                   parameters: nil) {

            request.account = self.account
            request.perform(handler: { (data, response, error) in
                if error != nil {
                    print("Error: Fetching Home Timeline")
                    completion(nil)
                }

                guard response != nil else { completion(nil); return }
                guard data != nil else { completion(nil); return }

                // Should really make this switch DRY (see above)
                switch response!.statusCode{
                case 200...299:
                    JSONParser.tweetsFrom(data: data!, completion: { (success, tweets) in
                        if success{
                            completion(tweets)
                        }
                        completion(nil)
                    })
                case 400...499: print("\(response!.statusCode): Client-Side error"); completion(nil)
                case 500...599: print("\(response!.statusCode): Server-Side error"); completion(nil)
                default:        print("Response came bach with unrecognized status code."); completion(nil)
                }
            })

        }
    }


    func getTweets(completion: @escaping tweetsCompletion){
        let homeTimelineURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"

        if self.account != nil{
            self.updateTimeline(url: homeTimelineURL, completion: completion)
        }

        self.login { (account) in
            if account != nil {
                API.shared.account = account!
                self.updateTimeline(url: homeTimelineURL, completion: completion)
                
            }
            completion(nil)
        }
    }

    func getUserTweetsFor(handle: String, completion: @escaping tweetsCompletion) {

        let userTweetsURL = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=\(handle)"
        self.updateTimeline(url: userTweetsURL, completion: completion)
    }

    func getImageFor(urlString: String, completion: @escaping imageCompletion) {

        OperationQueue().addOperation {
            guard let url = URL(string: urlString) else { return }

            print(url)

            do{
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else { return }

                OperationQueue.main.addOperation {
                    completion(image)
                }
            } catch {
                print("There was an error getting the data from Twitter API URL for UIImage.")
                OperationQueue.main.addOperation {
                    completion(nil)
                }
            }

        }
    }

    func getUserAccount(completion: @escaping userCompletion) {
        if self.account != nil {
            self.getOAuthUser(completion: completion)
        } else {
            completion(nil)
        }
    }
}






