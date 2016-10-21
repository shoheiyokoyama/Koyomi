//
//  MyButton.swift
//  Koyomi
//
//  Created by Shohei Yokoyama on 2016/10/21.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class MyButton: UIButton {
    var color: UIColor = .blueColor() {
        didSet {
            layer.borderColor = color.CGColor
            setTitleColor(color, forState: .Normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        backgroundColor = .clearColor()
        layer.borderColor  = color.CGColor
        layer.borderWidth  = 0.5
        layer.cornerRadius = 14
        contentEdgeInsets  = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
    }
}


