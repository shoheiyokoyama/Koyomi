//
//  DictionaryExtension.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2016/10/18.
//
//

import UIKit

extension Dictionary where Key: NSDate, Value: BooleanType {
    func keys(of element: Bool) -> [Key] {
        return self.filter{
            if $0.1.boolValue == element {
                return true
            }
            return false
        }.map { $0.0 }
    }
}
