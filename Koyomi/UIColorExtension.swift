//
//  UIColorExtension.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2016/10/11.
//
//

import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red   = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue  = CGFloat((hex & 0xFF)) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    struct KoyomiColor {
        static let black = UIColor(hex: 0x333333)
        static let lightGray = UIColor(hex: 0xc3c3ca)
        static let darkGray = UIColor(hex: 0x878787)
    }

}
