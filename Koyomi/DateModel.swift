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
    
    static let dayCountPerRow = 7
    var weeks: [String] = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    static let maxCellCount = 42
    
    override init() {
        super.init()
        setup()
    }
    
    func cellCount(in month: MonthType) -> Int {
        let weeksRange = calendar.rangeOfUnit(.WeekOfMonth, inUnit: .Month, forDate: atBeginning(of: month))
        return weeksRange.length * DateModel.dayCountPerRow
    }
    
    func indexAtBeginning(in month: MonthType) -> Int {
        return calendar.ordinalityOfUnit(.Day, inUnit: .WeekOfMonth, forDate: atBeginning(of: month)) - 1
    }
    
    func indexAtEnd(in month: MonthType) -> Int {
        let rangeDays = calendar.rangeOfUnit(.Day, inUnit: .Month, forDate: atBeginning(of: month))
        return rangeDays.length + indexAtBeginning(in: month) - 1
    }
    
    func dayString(at indexPath: NSIndexPath) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = DateFormat.day
        return formatter.stringFromDate(currentDates[indexPath.row])
    }
    
    func display(in month: MonthType) {
        currentDates = []
        currentDate = month == .current ? NSDate() : date(of: month)
        setup()
    }
    
    func dateString(in month: MonthType, withFormat format: String) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.stringFromDate(date(of: month))
    }
    
    func date(at indexPath: NSIndexPath) -> NSDate {
        return currentDates[indexPath.row]
    }
}

// MARK: - Private Methods -

private extension DateModel {
    struct DateFormat {
        static let day = "d"
    }
    
    var calendar: NSCalendar {
        return NSCalendar.currentCalendar()
    }
    
    func setup() {
        currentDates = (0..<DateModel.maxCellCount).map { index in
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
