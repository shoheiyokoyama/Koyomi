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
    
    // Type methods
    static let dayCountPerRow = 7
    static let maxCellCount   = 42
    
    var weeks: [String] = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    
    enum SelectionMode { case single, multiple, sequence, none }
    var selectionMode: SelectionMode = .single
    
    struct SequenceDates { var start: NSDate?, end: NSDate? }
    lazy var sequenceDates: SequenceDates = .init(start: nil, end: nil)
    
    // Private methods
    private var currentDates: [NSDate] = []
    private var selectedDates: [NSDate: Bool] = [:]
    private var currentDate: NSDate = .init()
    
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
    
    func select(with indexPath: NSIndexPath) {
        let selectedDate = date(at: indexPath)
        
        switch selectionMode {
        case .single:
            selectedDates.forEach { [weak self] date, isSelected in
                guard let me = self else { return }
                if selectedDate == date {
                    me.selectedDates[date] = me.selectedDates[date] == true ? false : true
                } else if isSelected {
                    me.selectedDates[date] = false
                }
            }
            
        case .multiple:
            selectedDates[date(at: indexPath)] = selectedDates[date(at: indexPath)] == true ? false : true
            
        case .sequence:
            
            // user has selected nothing
            if sequenceDates.start == nil && sequenceDates.end == nil {
                sequenceDates.start = selectedDate
                selectedDates[selectedDate] = true
                
            // user has selected sequence date
            } else if let _ = sequenceDates.start, let _ = sequenceDates.end {
                sequenceDates.start = selectedDate
                sequenceDates.end   = nil
                selectedDates.forEach { selectedDates[$0.0] = selectedDate == $0.0 ? true : false }
                
            // user select selected date
            } else if let start = sequenceDates.start where sequenceDates.end == nil && start == selectedDate {
                sequenceDates.start = nil
                selectedDates[selectedDate] = false
                
            // user has selected a date
            } else if let start = sequenceDates.start where sequenceDates.end == nil && start != selectedDate {
                
                let isSelectedBeforeDay = selectedDate < start
                
                let comparisonResult: NSComparisonResult
                let componentDay: Int
                
                if isSelectedBeforeDay {
                    comparisonResult = .OrderedAscending
                    componentDay = -1
                } else {
                    comparisonResult = .OrderedDescending
                    componentDay = 1
                }
                
                var date = start
                let components = NSDateComponents()
                while selectedDate.compare(date) == comparisonResult {
                    components.day = componentDay
                    guard let nextDay = calendar.dateByAddingComponents(components, toDate: date, options: NSCalendarOptions(rawValue: 0)) else {
                        break
                    }
                    selectedDates[nextDay] = true
                    date = nextDay
                }
                
                sequenceDates.start = isSelectedBeforeDay ? selectedDate : start
                sequenceDates.end   = isSelectedBeforeDay ? start : selectedDate
            }
        default: break
        }
    }
    
    // use selectionMode is sequence only.
    func selectedPeriod(with indexPath: NSIndexPath) -> Int {
        let selectedDate = date(at: indexPath)
        
        if let start = sequenceDates.start where sequenceDates.end == nil && start != selectedDate {
            return abs(start.daysSince(selectedDate)) + 1
        } else if let start = sequenceDates.start where sequenceDates.end == nil && start == selectedDate {
            return 0
        } else {
            return 1
        }
    }
    
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
            if fromDate <= date && toDate >= date {
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
