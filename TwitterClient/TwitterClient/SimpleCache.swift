//
//  SimpleCache.swift
//  TwitterClient
//
//  Created by Erica Winberry on 10/20/16.
//  Copyright © 2016 Erica Winberry. All rights reserved.
//

import UIKit


class SimpleCache {
    
    static let shared = SimpleCache()
    
    private var cache = [String: UIImage]()

    private let capacity = 20
    
    // accessor method
    func image(key: String) -> UIImage? {
        return self.cache[key]
    }
    
    // allows us to put images into dict.
    func setImage(_ image: UIImage, with key: String) {
        if self.cache.count >= capacity {
            guard let lastKey = Array(self.cache.keys).last else { return }
            self.cache.removeValue(forKey: lastKey)
        }
        
        self.cache[key] = image
    }
}

