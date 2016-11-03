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
            koyomi.inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            koyomi.weeks = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            koyomi.style = .standard
            koyomi.selectionMode  = .sequence(style: .semicircleEdge)
            koyomi.selectedBackgroundColor = UIColor(red: 203/255, green: 119/255, blue: 223/255, alpha: 1)
            koyomi
                .setDayFont(size: 14)
                .setWeekFont(size: 10)
        }
    }
    @IBOutlet private weak var currentDateLabel: UILabel!
    
    private let invalidPeriod = 90
    
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
    @IBOutlet weak var deepBlackButton: MyButton! {
        didSet {
            deepBlackButton.deepColor = UIColor.Color.darkBlack
        }
    }
    @IBOutlet weak var deepRedButton: MyButton! {
        didSet {
            deepRedButton.deepColor = UIColor.Color.red
        }
    }
    @IBOutlet weak var deepOrangeButton: MyButton! {
        didSet {
            deepOrangeButton.deepColor = UIColor.Color.orange
        }
    }
    @IBOutlet weak var deepYellowButton: MyButton! {
        didSet {
            deepYellowButton.deepColor = UIColor.Color.yellow
        }
    }
    @IBOutlet weak var deepTealBlueButton: MyButton! {
        didSet {
            deepTealBlueButton.deepColor = UIColor.Color.tealBlue
        }
    }
    @IBOutlet weak var deepBlueButton: MyButton! {
        didSet {
            deepBlueButton.deepColor = UIColor.Color.blue
        }
    }
    @IBOutlet weak var deepPurpleButton: MyButton! {
        didSet {
            deepPurpleButton.deepColor = UIColor.Color.purple
        }
    }
    @IBOutlet weak var deepGreenButton: MyButton! {
        didSet {
            deepGreenButton.deepColor = UIColor.Color.green
        }
    }
    @IBOutlet weak var deepPinkButton: MyButton! {
        didSet {
            deepPinkButton.deepColor = UIColor.Color.pink
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
        configureStyle(.monotone)
    }
    @IBAction func tappedStandard(sender: AnyObject) {
        configureStyle(.standard)
    }
    @IBAction func tappedRedButton(sender: AnyObject) {
        configureStyle(.red)
    }
    @IBAction func tappedOrange(sender: AnyObject) {
        configureStyle(.orange)
    }
    @IBAction func tappedYellow(sender: AnyObject) {
        configureStyle(.yellow)
    }
    @IBAction func tappedTealBlue(sender: AnyObject) {
        configureStyle(.tealBlue)
    }
    @IBAction func tappedBlue(sender: AnyObject) {
        configureStyle(.blue)
    }
    @IBAction func purpleButton(sender: AnyObject) {
        configureStyle(.purple)
    }
    @IBAction func tappedGreen(sender: AnyObject) {
        configureStyle(.green)
    }
    @IBAction func tappedPink(sender: AnyObject) {
        configureStyle(.pink)
    }
    @IBAction func tappedDeepBlack(sender: AnyObject) {
        configureStyle(.deepBlack)
    }
    @IBAction func tappedDeepRed(sender: AnyObject) {
        configureStyle(.deepRed)
    }
    @IBAction func tappedDeepOrange(sender: AnyObject) {
        configureStyle(.deepOrange)
    }
    @IBAction func tappedDeepYellow(sender: AnyObject) {
        configureStyle(.deepYellow)
    }
    @IBAction func tappedDeepTealBlueButton(sender: AnyObject) {
        configureStyle(.deepTealBlue)
    }
    @IBAction func tappedDeepBlue(sender: AnyObject) {
        configureStyle(.deepBlue)
    }
    @IBAction func tappedDeepPurple(sender: AnyObject) {
        configureStyle(.deepPurple)
    }
    @IBAction func tappedDeepGreen(sender: AnyObject) {
        configureStyle(.deepGreen)
    }
    @IBAction func tappedDeepPink(sender: AnyObject) {
        configureStyle(.deepPink)
    }
    
    func configureStyle(style: KoyomiStyle) {
        koyomi.style = style
        koyomi.reloadData()
    }
}

// MARK: - KoyomiDelegate -

extension ViewController: KoyomiDelegate {
    func koyomi(koyomi: Koyomi, didSelect date: NSDate?, forItemAt indexPath: NSIndexPath) {
        print(date)
    }
    
    func koyomi(koyomi: Koyomi, currentDateString dateString: String) {
        currentDateLabel.text = dateString
    }
    
    func koyomi(koyomi: Koyomi, shouldSelectDates date: NSDate?, to: NSDate?, withPeriodLength lenght: Int) -> Bool {
        if lenght > invalidPeriod {
            print("More than \(invalidPeriod) days are invalid period.")
            return false
        }
        return true
    }
}

