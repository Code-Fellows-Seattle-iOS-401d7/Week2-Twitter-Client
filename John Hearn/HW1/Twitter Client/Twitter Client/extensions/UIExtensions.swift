//
//  UIExtensions.swift
//  Twitter Client
//
//  Created by John D Hearn on 10/20/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

import UIKit

extension UIResponder {
    class func identifier() -> String {
        return String(describing: self)
    }
}

