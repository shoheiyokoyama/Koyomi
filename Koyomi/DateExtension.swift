//
//  DateExtension.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2016/10/14.
//
//

import UIKit

extension Date {
    func formated(withFormat format: String = "yyyy/MM/dd") -> Date? {
        let formatter: DateFormatter = .init()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        let dateString = formatter.string(from: self)
        return formatter.date(from: dateString)
    }
    
    func daysSince(_ anotherDate: Date) -> Int? {
        if let fromDate = dateFromComponents(self), let toDate = dateFromComponents(anotherDate) {
            let components = Calendar.current.dateComponents([.day], from: fromDate, to: toDate)
            return components.day
        }
        return nil
    }
    
    func monthDifference(fromDate date: Date) -> Int {
        
        let currentCalendar = Calendar.current
        
        guard let startMonth = currentCalendar.ordinality(of: .month, in: .era, for: date) else { return 0 }
        guard let endMonth = currentCalendar.ordinality(of: .month, in: .era, for: self) else { return 0 }
        
        return endMonth - startMonth
    }
    
    private func dateFromComponents(_ date: Date) -> Date? {
        let calender   = Calendar.current
        let components = calender.dateComponents([.year, .month, .day], from: date)
        return calender.date(from: components)
    }
}
