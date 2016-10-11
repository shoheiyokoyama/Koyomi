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

    @IBOutlet private weak var koyomi: Koyomi!
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
        setup()
    }
}

// MARK: - Private Methods

private extension ViewController {
    func setup() {
        currentDateLabel.text = koyomi.currentDateString
        
        koyomi.inset = UIEdgeInsets(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5)
        
        koyomi
            .setDayFont(size: 12)
            .setWeekFont(size: 8)
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
        currentDateLabel.text = koyomi.currentDateString// TODO: - Delegate
    }
}

