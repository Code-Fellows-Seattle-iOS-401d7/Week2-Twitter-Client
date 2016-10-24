//
//  UIExtensions.swift
//  TwitterClient
//
//  Created by Corey Malek on 10/20/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//


import UIKit

extension UIResponder {
    class func identifier() -> String {
        return String(describing: self)
    }
} 
