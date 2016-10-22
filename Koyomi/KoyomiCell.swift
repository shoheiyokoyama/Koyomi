//
//  KoyomiCell.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2016/10/09.
//
//

import UIKit

final class KoyomiCell: UICollectionViewCell {
    private let contentLabel: UILabel = .init()
    private let circularView: UIView  = .init()
    
    private let leftSemicircleView: UIView  = .init()
    private let rightSemicircleView: UIView = .init()
    
    enum CellStyle {
        case standard, circle, sequence(position: SequencePosition)
        
        enum SequencePosition { case left, middle, right }
    }
    
    var content = "" {
        didSet {
            contentLabel.text = content
            adjustSubViewsFrame()
        }
    }
    var textColor: UIColor = .blackColor() {
        didSet {
            contentLabel.textColor = textColor
        }
    }
    var dayBackgroundColor: UIColor = .whiteColor() {
        didSet {
            backgroundColor = dayBackgroundColor
        }
    }
    
    // MARK: - Initializer -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        adjustSubViewsFrame()
    }
    
    func setContentFont(fontName name: String, size: CGFloat) {
        contentLabel.font = UIFont(name: name, size: size)
        adjustSubViewsFrame()
    }
    
    func configureAppearanse(of style: CellStyle, withColor color: UIColor, backgroundColor: UIColor, isSelected: Bool) {
        switch style {
        case .standard:
            self.backgroundColor = isSelected ? color : backgroundColor
            circularView.hidden  = true
            
            rightSemicircleView.hidden = true
            leftSemicircleView.hidden  = true
            
        // isSelected is always true
        case .circle:
            circularView.backgroundColor = color
            self.backgroundColor = backgroundColor
            circularView.hidden  = false
            
            rightSemicircleView.hidden = true
            leftSemicircleView.hidden  = true
            
        // isSelected is always true
        case .sequence(let position):
            
            circularView.hidden = true
            
            if case .left = position {
                rightSemicircleView.hidden = false
                leftSemicircleView.hidden  = false
                self.backgroundColor = backgroundColor
                
                leftSemicircleView.backgroundColor  = color
                rightSemicircleView.backgroundColor = color
                
                // for bug: unnecessary line
                leftSemicircleView.frame.size.width = bounds.width / 2 + 1
                
                leftSemicircleView.mask(with: .left)
                rightSemicircleView.mask(with: .none)
            } else if case .middle = position {
                rightSemicircleView.hidden = true
                leftSemicircleView.hidden  = true
                self.backgroundColor = color
                
                leftSemicircleView.frame.size.width = bounds.width / 2
                
            } else if case .right = position {
                rightSemicircleView.hidden = false
                leftSemicircleView.hidden  = false
                self.backgroundColor = backgroundColor
                
                leftSemicircleView.backgroundColor  = color
                rightSemicircleView.backgroundColor = color
                
                leftSemicircleView.mask(with: .none)
                rightSemicircleView.mask(with: .right)
            }
        }
    }
}

// MARK: - Private Methods

private extension KoyomiCell {
    func setup() {
        let diameter = bounds.width * 0.75
        circularView.frame = CGRect(x: (bounds.width - diameter) / 2, y: (bounds.width - diameter) / 2, width: diameter, height: diameter)
        circularView.layer.cornerRadius = diameter / 2
        circularView.hidden = true
        addSubview(circularView)
        
        leftSemicircleView.frame = CGRect(x: 0, y: 0, width: bounds.width / 2, height: bounds.height)
        leftSemicircleView.hidden = true
        addSubview(leftSemicircleView)
        
        rightSemicircleView.frame = CGRect(x: bounds.width / 2, y: 0, width: bounds.width / 2, height: bounds.height)
        rightSemicircleView.hidden = true
        addSubview(rightSemicircleView)
        
        addSubview(contentLabel)
    }
    
    func adjustSubViewsFrame() {
        contentLabel.sizeToFit()
        contentLabel.frame.origin = CGPoint(x: (frame.width - contentLabel.frame.width) / 2, y: (frame.height - contentLabel.frame.height) / 2)
        
        rightSemicircleView.frame = CGRect(x: bounds.width / 2, y: 0, width: bounds.width / 2, height: bounds.height)
        leftSemicircleView.frame  = CGRect(x: 0, y: 0, width: bounds.width / 2, height: bounds.height)

        let diameter = bounds.width * 0.75
        circularView.frame = CGRect(x: (bounds.width - diameter) / 2, y: (bounds.width - diameter) / 2, width: diameter, height: diameter)
        circularView.layer.cornerRadius = diameter / 2
    }
}
