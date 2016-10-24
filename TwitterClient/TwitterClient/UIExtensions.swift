//
//  UIExtensions.swift
//  TwitterClient
//
//  Created by Filiz Kurban on 10/20/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit

extension UIResponder {
    class func identifier() -> String {
        return String(describing: self)
    }
}
