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

    @IBOutlet fileprivate weak var koyomi: Koyomi! {
        didSet {
            koyomi.calendarDelegate = self
            koyomi.inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            koyomi.weeks = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            koyomi.style = .standard
            koyomi.dayPosition = .topRight
            koyomi.selectionMode = .sequence(style: .semicircleEdge)
            koyomi.selectedBackgroundColor = UIColor(red: 203/255, green: 119/255, blue: 223/255, alpha: 1)
            koyomi
                .setDayFont(size: 14)
                .setWeekFont(size: 10)
        }
    }
    @IBOutlet fileprivate weak var currentDateLabel: UILabel!
    
    fileprivate let invalidPeriod = 90
    
    @IBOutlet fileprivate weak var segmentedControl: UISegmentedControl! {
        didSet {
            segmentedControl.setTitle("Previous", forSegmentAt: 0)
            segmentedControl.setTitle("Current", forSegmentAt: 1)
            segmentedControl.setTitle("Next", forSegmentAt: 2)
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

    fileprivate func date(_ date: Date, later: Int) -> Date {
        var components = DateComponents()
        components.day = later
        return (Calendar.current as NSCalendar).date(byAdding: components, to: date, options: NSCalendar.Options(rawValue: 0)) ?? date
    }
}

// MARK: - Tap Action

extension ViewController {
    @IBAction func tappedControl(_ sender: UISegmentedControl) {
        let month: MonthType = {
            switch sender.selectedSegmentIndex {
            case 0:  return .previous
            case 1:  return .current
            default: return .next
            }
        }()
        koyomi.display(in: month)
    }
    
    // Change koyomi style
    @IBAction func tappedMonotone(_ sender: AnyObject) {
        configureStyle(.monotone)
    }
    @IBAction func tappedStandard(_ sender: AnyObject) {
        configureStyle(.standard)
    }
    @IBAction func tappedRedButton(_ sender: AnyObject) {
        configureStyle(.red)
    }
    @IBAction func tappedOrange(_ sender: AnyObject) {
        configureStyle(.orange)
    }
    @IBAction func tappedYellow(_ sender: AnyObject) {
        configureStyle(.yellow)
    }
    @IBAction func tappedTealBlue(_ sender: AnyObject) {
        configureStyle(.tealBlue)
    }
    @IBAction func tappedBlue(_ sender: AnyObject) {
        configureStyle(.blue)
    }
    @IBAction func purpleButton(_ sender: AnyObject) {
        configureStyle(.purple)
    }
    @IBAction func tappedGreen(_ sender: AnyObject) {
        configureStyle(.green)
    }
    @IBAction func tappedPink(_ sender: AnyObject) {
        configureStyle(.pink)
    }
    @IBAction func tappedDeepBlack(_ sender: AnyObject) {
        configureStyle(.deepBlack)
    }
    @IBAction func tappedDeepRed(_ sender: AnyObject) {
        configureStyle(.deepRed)
    }
    @IBAction func tappedDeepOrange(_ sender: AnyObject) {
        configureStyle(.deepOrange)
    }
    @IBAction func tappedDeepYellow(_ sender: AnyObject) {
        configureStyle(.deepYellow)
    }
    @IBAction func tappedDeepTealBlueButton(_ sender: AnyObject) {
        configureStyle(.deepTealBlue)
    }
    @IBAction func tappedDeepBlue(_ sender: AnyObject) {
        configureStyle(.deepBlue)
    }
    @IBAction func tappedDeepPurple(_ sender: AnyObject) {
        configureStyle(.deepPurple)
    }
    @IBAction func tappedDeepGreen(_ sender: AnyObject) {
        configureStyle(.deepGreen)
    }
    @IBAction func tappedDeepPink(_ sender: AnyObject) {
        configureStyle(.deepPink)
    }
    
    // Utility
    func configureStyle(_ style: KoyomiStyle) {
        koyomi.style = style
        koyomi.reloadData()
    }
}

// MARK: - KoyomiDelegate -

extension ViewController: KoyomiDelegate {
    func koyomi(_ koyomi: Koyomi, didSelect date: Date?, forItemAt indexPath: IndexPath) {
        print(date)
    }
    
    func koyomi(_ koyomi: Koyomi, currentDateString dateString: String) {
        currentDateLabel.text = dateString
    }
    
    func koyomi(_ koyomi: Koyomi, shouldSelectPeriod from: Date?, to: Date?, WithLength lenght: Int) -> Bool {
        print(from)
        print(to)
        print(lenght)
        if lenght > invalidPeriod {
            print("More than \(invalidPeriod) days are invalid period.")
            return false
        }
        return true
    }
}

