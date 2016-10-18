//
//  ViewController.swift
//  Koyomi
//
//  Created by shoheiyokoyama on 10/09/2016.
//  Copyright (c) 2016 shoheiyokoyama. All rights reserved.
//

import UIKit
import Koyomi

class ViewController: UIViewController {

    @IBOutlet private weak var koyomi: Koyomi! {
        didSet {
            koyomi.calenderDelegate = self
            koyomi.inset = UIEdgeInsets(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5)
            koyomi.weeks = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            koyomi.style = .standard
            koyomi
                .setDayFont(size: 14)
                .setWeekFont(size: 10)
                .select(date: NSDate(), to: date(NSDate(), later: 7))
        }
    }
    @IBOutlet private weak var currentDateLabel: UILabel!
    
    @IBOutlet private weak var segmentedControl: UISegmentedControl! {
        didSet {
            segmentedControl.setTitle("Previous", forSegmentAtIndex: 0)
            segmentedControl.setTitle("Current", forSegmentAtIndex: 1)
            segmentedControl.setTitle("Next", forSegmentAtIndex: 2)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentDateLabel.text = koyomi.currentDateString()
    }
    
    @IBAction func tappedControl(sender: UISegmentedControl) {
        let month: MonthType = {
            switch sender.selectedSegmentIndex {
            case 0:  return .previous
            case 1:  return .current
            default: return .next
            }
        }()
        koyomi.display(in: month)
    }
    
    // MARK: - Utility -
    
    private func date(date: NSDate, later: Int) -> NSDate {
        let components = NSDateComponents()
        components.day = later
        return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: date, options: NSCalendarOptions(rawValue: 0)) ?? date
    }
}

// MARK: - KoyomiDelegate -

extension ViewController: KoyomiDelegate {
    func koyomi(koyomi: Koyomi, didSelect date: NSDate, forItemAt indexPath: NSIndexPath) {
        print(date)
    }
    
    func koyomi(koyomi: Koyomi, currentDateString dateString: String) {
        currentDateLabel.text = dateString
    }
}

