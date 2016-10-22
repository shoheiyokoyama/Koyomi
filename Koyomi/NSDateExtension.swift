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
    
    func daysSince(anotherDate: NSDate) -> Int {
        let fromDate = dateFromComponents(self)
        let toDate   = dateFromComponents(anotherDate)
        let components = NSCalendar.currentCalendar().components([.Day], fromDate: fromDate, toDate: toDate, options: NSCalendarOptions(rawValue: 0))
        return components.day
    }
    
    private func dateFromComponents(date: NSDate) -> NSDate {
        let calender   = NSCalendar.currentCalendar()
        let components = calender.components([.Year, .Month, .Day], fromDate: date)
        return calender.dateFromComponents(components)!
    }
}
