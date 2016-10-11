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
            segmentedControl.setTitle("Next", forSegmentAtIndex: 1)
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
    }
    
    @IBAction func tappedControl(sender: UISegmentedControl) {
        let month: MonthType = sender.selectedSegmentIndex == 0 ? .previous : .next
        koyomi.display(in: month)
        currentDateLabel.text = koyomi.currentDateString// TODO: - Delegate
    }
}

