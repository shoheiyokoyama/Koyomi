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
        return filter{ $0.1.boolValue == element }.map{ $0.0 }
    }
}
