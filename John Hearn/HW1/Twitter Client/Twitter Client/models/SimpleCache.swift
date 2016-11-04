//
//  SimpleCashe.swift
//  Twitter Client
//
//  Created by John D Hearn on 10/20/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

import UIKit

class SimpleCache{
    static let shared = SimpleCache()
    private var cache = [String: UIImage]()

    private let capacity = 20


    func image(key: String) -> UIImage? {
        return self.cache[key]
    }


    func set(key: String, image: UIImage) {
        if self.cache.count >= capacity{
            guard let lastKey = Array(self.cache.keys).last else { return }
            //TODO: we're dropping a random item from cache, which is lame
            self.cache.removeValue(forKey: lastKey)
        }

        self.cache[key] = image
    }
}
