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
    
    enum CellStyle { case background, circle }
    
    var content = "" {
        didSet {
            contentLabel.text = content
            adjustContentFrame()
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
    
    func setContentFont(fontName name: String, size: CGFloat) {
        contentLabel.font = UIFont(name: name, size: size)
        adjustContentFrame()
    }
    
    func configureAppearanse(of style: CellStyle, withColor color: UIColor, backgroundColor: UIColor, isSelected: Bool) {
        switch style {
        case .background:
            self.backgroundColor = isSelected ? color : backgroundColor
            circularView.hidden = true
        case .circle:
            circularView.backgroundColor = color
            self.backgroundColor = backgroundColor
            circularView.hidden = false
        }
    }
}

// MARK: - Private Methods

private extension KoyomiCell {
    func setup() {
        let diameter = frame.width * 0.75
        circularView.frame = CGRect(x: (frame.width - diameter) / 2, y: (frame.width - diameter) / 2, width: diameter, height: diameter)
        circularView.layer.cornerRadius = diameter / 2
        circularView.hidden = true
        addSubview(circularView)
        
        addSubview(contentLabel)
    }
    
    func adjustContentFrame() {
        contentLabel.sizeToFit()
        contentLabel.frame.origin = CGPoint(x: (frame.width - contentLabel.frame.width) / 2, y: (frame.height - contentLabel.frame.height) / 2)
    }
}
