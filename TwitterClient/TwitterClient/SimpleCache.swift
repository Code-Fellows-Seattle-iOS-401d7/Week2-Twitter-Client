//
//  SimpleCache.swift
//  TwitterClient
//
//  Created by Filiz Kurban on 10/20/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit

class SimpleCache {
    static let shared = SimpleCache()

    private var cache = [String: UIImage]()

    private let capacity = 20

    func image(key:String) -> UIImage? {
        return self.cache[key]
    }

    func setImage(_ image: UIImage, key: String) {
        if self.cache.count >= capacity {
            guard let lastKey = Array(self.cache.keys).last else { return }
            //self.cache[lastKey] = nil
            self.cache.removeValue(forKey: lastKey)
        }
        cache[key] = image
    }
}
