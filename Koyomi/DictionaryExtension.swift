//
//  DictionaryExtension.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2016/10/18.
//
//

import UIKit

extension Dictionary where Value: Equatable {
    func keys(of element: Value) -> [Key] {
        return filter { $0.1 == element }.map { $0.0 }
    }
}
