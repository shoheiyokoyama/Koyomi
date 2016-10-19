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
    private var selectedDates: [NSDate: Bool] = [:]
    private var currentDate: NSDate = .init()
    
    static let dayCountPerRow = 7
    var weeks: [String] = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    static let maxCellCount = 42
    
    enum SelectionStyle { case single, multiple, none }
    var selectionStyle: SelectionStyle = .none
    
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
        formatter.dateFormat = "d"
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
    
    func select(from fromDate: NSDate, to toDate: NSDate?) {
        if let toDate = toDate?.formated() {
            set(true, withFrom: fromDate, to: toDate)
        } else {
            selectedDates[fromDate.formated()] = true
        }
    }
    
    func unselect(from fromDate: NSDate, to toDate: NSDate?) {
        if let toDate = toDate?.formated() {
            set(false, withFrom: fromDate, to: toDate)
        } else {
            selectedDates[fromDate.formated()] = false
        }
    }
    
    func unselectAll() {
        selectedDates.keys(of: true).forEach { selectedDates[$0] = false }
    }
    
//    func select(with indexPath: NSIndexPath) {
//        if case .single = selectionStyle {
//            let date = currentDates[indexPath.row]
//            selectedDates[date] = selectedDates[date] == true ? false : true
//        } else if case .multiple = selectionStyle {
//            
//        } else {
//            return
//        }
//    }
    
    func isSelect(with indexPath: NSIndexPath) -> Bool {
        let date = currentDates[indexPath.row]
        return selectedDates[date] ?? false
    }
}

// MARK: - Private Methods -

private extension DateModel {
    var calendar: NSCalendar { return NSCalendar.currentCalendar() }
    
    func setup() {
        let selectedDateKeys = selectedDates.keys(of: true)
        selectedDates = [:]

        currentDates = (0..<DateModel.maxCellCount).map { index in
            let components = NSDateComponents()
            components.day = index - indexAtBeginning(in: .current)
            let date = calendar.dateByAddingComponents(components, toDate: atBeginning(of: .current), options: NSCalendarOptions(rawValue: 0)) ?? NSDate()
            selectedDates[date] = false
            return date
        }
        
        selectedDateKeys.forEach { selectedDates[$0] = true }
    }
    
    func set(isSelected: Bool, withFrom fromDate: NSDate, to toDate: NSDate) {
        currentDates.forEach { date in
            if fromDate.compare(date) == .OrderedSame ||
                fromDate.compare(date) == .OrderedAscending && toDate.compare(date) == .OrderedDescending ||
                toDate.compare(date) == .OrderedSame {
                selectedDates[date] = isSelected
            }
        }
    }
    
    func atBeginning(of month: MonthType) -> NSDate {
        let components = calendar.components([.Year, .Month, .Day], fromDate: date(of: month))
        components.day = 1
        return calendar.dateFromComponents(components) ?? .init()
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
        return calendar.dateByAddingComponents(components, toDate: currentDate, options: NSCalendarOptions(rawValue: 0)) ?? .init()
    }
}
