//
//  DateModel.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2016/10/10.
//
//

import UIKit

public enum MonthType { case previous, current, next }

final class DateModel: NSObject {
    private var currentDates: [NSDate] = []
    private var currentDate = NSDate()
    
    static let weeks: [String] = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"]
    
    override init() {
        super.init()
        setup()
    }
    
    func cellCount(in month: MonthType) -> Int {
        let weeksRange = calendar.rangeOfUnit(.WeekOfMonth, inUnit: .Month, forDate: atBeginning(of: month))
//        return weeksRange.length * DateModel.weeks.count
        return 42
    }
    
    func indexAtBeginning(in month: MonthType) -> Int {
        return calendar.ordinalityOfUnit(.Day, inUnit: .WeekOfMonth, forDate: atBeginning(of: month)) - 1
    }
    
    func dayString(at indexPath: NSIndexPath) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = DateFormat.day
        return formatter.stringFromDate(currentDates[indexPath.row])
    }
    
    func display(in month: MonthType) {
        currentDates = []
        currentDate = date(of: month)
        setup()
    }
    
    func dateString(in month: MonthType) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = DateFormat.yearWithMonth
        return formatter.stringFromDate(date(of: month))
    }
}

// MARK: - Private Methods -

private extension DateModel {
    struct DateFormat {
        static let day = "d"
        static let yearWithMonth = "yyyy年M月"
    }
    
    var calendar: NSCalendar {
        return NSCalendar.currentCalendar()
    }
    
    func setup() {
        currentDates = (0..<cellCount(in: .current)).map { index in
            let components = NSDateComponents()
            components.day = index - indexAtBeginning(in: .current)
            return calendar.dateByAddingComponents(components, toDate: atBeginning(of: .current), options: NSCalendarOptions(rawValue: 0)) ?? NSDate()
        }
    }
    
    func atBeginning(of month: MonthType) -> NSDate {
        let components = calendar.components([.Year, .Month, .Day], fromDate: date(of: month))
        components.day = 1
        return calendar.dateFromComponents(components) ?? NSDate()
    }
    
    func date(of month: MonthType) -> NSDate {
        let components = NSDateComponents()
        components.month = {
            switch month {
            case .previous: return -1
            case .current:  return 0
            case .next:     return 1
            }
        }()
        return calendar.dateByAddingComponents(components, toDate: currentDate, options: NSCalendarOptions(rawValue: 0)) ?? NSDate()
    }
}
