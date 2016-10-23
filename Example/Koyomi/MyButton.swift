//
//  MyButton.swift
//  Koyomi
//
//  Created by Shohei Yokoyama on 2016/10/21.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

class MyButton: UIButton {
    var color: UIColor = .blue {
        didSet {
            layer.borderColor = color.cgColor
            setTitleColor(color, for: UIControlState())
        }
    }
    var deepColor: UIColor = .white {
        didSet {
            layer.borderColor = deepColor.cgColor
            backgroundColor = deepColor
            setTitleColor(.white, for: UIControlState())
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        backgroundColor = .clear
        layer.borderColor  = color.cgColor
        layer.borderWidth  = 0.5
        layer.cornerRadius = 14
        contentEdgeInsets  = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
    }
}


