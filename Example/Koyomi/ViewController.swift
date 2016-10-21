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
            koyomi.calendarDelegate = self
            koyomi.inset = UIEdgeInsets(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5)
            koyomi.weeks = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            koyomi.style = .standard
            koyomi.selectionMode  = .multiple
            koyomi.selectionStyle = .background
            koyomi.selectedBackgroundColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
            koyomi
                .setDayFont(size: 14)
                .setWeekFont(size: 10)
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
    
    @IBOutlet weak var monotoneButton: MyButton! {
        didSet {
            monotoneButton.color = UIColor.Color.lightGray
        }
    }
    @IBOutlet weak var standardButton: MyButton! {
        didSet {
            standardButton.color = UIColor.Color.darkGray
        }
    }
    @IBOutlet weak var redButton: MyButton! {
        didSet {
            redButton.color = UIColor.Color.red
        }
    }
    @IBOutlet weak var orangeButton: MyButton! {
        didSet {
            orangeButton.color = UIColor.Color.orange
        }
    }
    @IBOutlet weak var yellowButton: MyButton! {
        didSet {
            yellowButton.color = UIColor.Color.yellow
        }
    }
    @IBOutlet weak var tealBlueButton: MyButton! {
        didSet {
            tealBlueButton.color = UIColor.Color.tealBlue
        }
    }
    @IBOutlet weak var blueButton: MyButton! {
        didSet {
            blueButton.color = UIColor.Color.blue
        }
    }
    @IBOutlet weak var purpleButton: MyButton! {
        didSet {
            purpleButton.color = UIColor.Color.purple
        }
    }
    @IBOutlet weak var greenButton: MyButton! {
        didSet {
            greenButton.color = UIColor.Color.green
        }
    }
    @IBOutlet weak var pinkButton: MyButton! {
        didSet {
            pinkButton.color = UIColor.Color.pink
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentDateLabel.text = koyomi.currentDateString()
    }
    
    // MARK: - Utility -
    
    private func date(date: NSDate, later: Int) -> NSDate {
        let components = NSDateComponents()
        components.day = later
        return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: date, options: NSCalendarOptions(rawValue: 0)) ?? date
    }
}


// MARK: - Tap Action

extension ViewController {
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
    
    // change koyomi style
    @IBAction func tappedMonotone(sender: AnyObject) {
        koyomi.style = .monotone
        koyomi.reloadData()
    }
    @IBAction func tappedStandard(sender: AnyObject) {
        koyomi.style = .standard
        koyomi.reloadData()
    }
    @IBAction func tappedRedButton(sender: AnyObject) {
        koyomi.style = .red
        koyomi.reloadData()
    }
    @IBAction func tappedOrange(sender: AnyObject) {
        koyomi.style = .orange
        koyomi.reloadData()
    }
    @IBAction func tappedYellow(sender: AnyObject) {
        koyomi.style = .yellow
        koyomi.reloadData()
    }
    @IBAction func tappedTealBlue(sender: AnyObject) {
        koyomi.style = .tealBlue
        koyomi.reloadData()
    }
    @IBAction func tappedBlue(sender: AnyObject) {
        koyomi.style = .blue
        koyomi.reloadData()
    }
    @IBAction func purpleButton(sender: AnyObject) {
        koyomi.style = .purple
        koyomi.reloadData()
    }
    @IBAction func tappedGreen(sender: AnyObject) {
        koyomi.style = .green
        koyomi.reloadData()
    }
    @IBAction func tappedPink(sender: AnyObject) {
        koyomi.style = .pink
        koyomi.reloadData()
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

