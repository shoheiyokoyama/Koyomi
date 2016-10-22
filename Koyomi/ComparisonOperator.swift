//
//  ComparisonOperator.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2016/10/22.
//
//

// MARK: - NSDate

func == (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedSame
}

func > (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedDescending
}

func < (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

func <= (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs < rhs || lhs == rhs
}

func >= (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs > rhs || lhs == rhs
}
