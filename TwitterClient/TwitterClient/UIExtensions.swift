//
//  UIExtensions.swift
//  TwitterClient
//
//  Created by Erica Winberry on 10/20/16.
//  Copyright © 2016 Erica Winberry. All rights reserved.
//

import Foundation
import UIKit

extension UIResponder {
    class func identifier() -> String {
        return String(describing: self)
    }
}
