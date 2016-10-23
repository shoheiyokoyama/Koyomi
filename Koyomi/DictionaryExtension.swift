//
//  DictionaryExtension.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2016/10/18.
//
//

import UIKit

protocol DateConvertible {}
extension Date: DateConvertible {}

extension Dictionary where Key: DateConvertible {
    func keys(of element: Bool) -> [Key] {
        return filter{ $0.1 as? Bool == element }.map { $0.0 }
    }
}
