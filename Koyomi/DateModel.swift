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
    
    // Type properties
    static let dayCountPerRow = 7
    static let maxCellCount   = 42
    
    // Week text
    var weeks: [String] = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    
    enum SelectionMode { case single, multiple, sequence, none }
    var selectionMode: SelectionMode = .single
    
    struct SequenceDates { var start: Date?, end: Date? }
    lazy var sequenceDates: SequenceDates = .init(start: nil, end: nil)
    
    // Fileprivate properties
    fileprivate var currentDates: [Date] = []
    fileprivate var selectedDates: [Date: Bool] = [:]
    fileprivate var currentDate: Date = .init()
    
    // MARK: - Initialization
    
    override init() {
        super.init()
        setup()
    }
    
    // MARK: - Internal Methods -
    
    func cellCount(in month: MonthType) -> Int {
        if let weeksRange = calendar.range(of: .weekOfMonth, in: .month, for: atBeginning(of: month)) {
            let count = weeksRange.upperBound - weeksRange.lowerBound
            return count * DateModel.dayCountPerRow
        }
        return 0
    }
    
    func indexAtBeginning(in month: MonthType) -> Int? {
        if let index = calendar.ordinality(of: .day, in: .weekOfMonth, for: atBeginning(of: month)) {
            return index - 1
        }
        return nil
    }
    
    func indexAtEnd(in month: MonthType) -> Int? {
        if let rangeDays = calendar.range(of: .day, in: .month, for: atBeginning(of: month)), let beginning = indexAtBeginning(in: month) {
            let count = rangeDays.upperBound - rangeDays.lowerBound
            return count + beginning - 1
        }
        return nil
    }
    
    func dayString(at indexPath: IndexPath) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: currentDates[indexPath.row])
    }
    
    func display(in month: MonthType) {
        currentDates = []
        currentDate = month == .current ? Date() : date(of: month)
        setup()
    }
    
    func dateString(in month: MonthType, withFormat format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date(of: month))
    }
    
    func date(at indexPath: IndexPath) -> Date {
        return currentDates[indexPath.row]
    }
    
    func select(from fromDate: Date, to toDate: Date?) {
        if let toDate = toDate?.formated() {
            set(true, withFrom: fromDate, to: toDate)
        } else if let fromDate = fromDate.formated() {
            selectedDates[fromDate] = true
        }
    }
    
    func unselect(from fromDate: Date, to toDate: Date?) {
        if let toDate = toDate?.formated() {
            set(false, withFrom: fromDate, to: toDate)
        } else if let fromDate = fromDate.formated() {
            selectedDates[fromDate] = false
        }
    }
    
    func unselectAll() {
        selectedDates.keys(of: true).forEach { selectedDates[$0] = false }
    }
    
    func select(with indexPath: IndexPath) {
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
            } else if let start = sequenceDates.start , sequenceDates.end == nil && start == selectedDate {
                sequenceDates.start = nil
                selectedDates[selectedDate] = false
                
            // user has selected a date
            } else if let start = sequenceDates.start , sequenceDates.end == nil && start != selectedDate {
                
                let isSelectedBeforeDay = selectedDate < start
                
                let comparisonResult: ComparisonResult
                let componentDay: Int
                
                if isSelectedBeforeDay {
                    comparisonResult = .orderedAscending
                    componentDay = -1
                } else {
                    comparisonResult = .orderedDescending
                    componentDay = 1
                }
                
                var date = start
                var components = DateComponents()
                while selectedDate.compare(date) == comparisonResult {
                    components.day = componentDay
                    
                    guard let nextDay = calendar.date(byAdding: components, to: date) else {
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
    func selectedPeriod(with indexPath: IndexPath) -> Int {
        let selectedDate = date(at: indexPath)
        
        if let start = sequenceDates.start, let period = start.daysSince(selectedDate), sequenceDates.end == nil && start != selectedDate {
            return abs(period) + 1
        } else if let start = sequenceDates.start , sequenceDates.end == nil && start == selectedDate {
            return 0
        } else {
            return 1
        }
    }
    
    func isSelect(with indexPath: IndexPath) -> Bool {
        let date = currentDates[indexPath.row]
        return selectedDates[date] ?? false
    }
}

// MARK: - Private Methods -

private extension DateModel {
    var calendar: Calendar { return Calendar.current }
    
    func setup() {
        let selectedDateKeys = selectedDates.keys(of: true)
        selectedDates = [:]
        
        guard let indexAtBeginning = indexAtBeginning(in: .current) else { return }

        var components = DateComponents()
        currentDates = CountableRange(0..<DateModel.maxCellCount).map { index in
                components.day = index - indexAtBeginning
                return calendar.date(byAdding: components, to: atBeginning(of: .current))
            }.flatMap { $0 }
            .map { (date: Date) in
                selectedDates[date] = false
                return date
            }
        
        selectedDateKeys.forEach { selectedDates[$0] = true }
    }
    
    func set(_ isSelected: Bool, withFrom fromDate: Date, to toDate: Date) {
        currentDates.forEach { date in
            if fromDate <= date && toDate >= date {
                selectedDates[date] = isSelected
            }
        }
    }
    
    func atBeginning(of month: MonthType) -> Date {
        var components = calendar.dateComponents([.year, .month, .day], from: date(of: month))
        components.day = 1
        return calendar.date(from: components) ?? .init()
    }
    
    func date(of month: MonthType) -> Date {
        var components = DateComponents()
        components.month = {
            switch month {
            case .previous: return -1
            case .current:  return 0
            case .next:     return 1
            }
        }()
        return calendar.date(byAdding: components, to: currentDate) ?? .init()
    }
}
