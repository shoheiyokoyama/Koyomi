//
//  NSDateExtension.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2016/10/14.
//
//

import UIKit

extension NSDate {
    func formated(withFormat format: String = "yyyy/MM/dd") -> NSDate {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        let dateString = formatter.stringFromDate(self)
        return formatter.dateFromString(dateString) ?? self
    }
}
