//
//  KoyomiCell.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2016/10/09.
//
//

import UIKit

final class KoyomiCell: UICollectionViewCell {
    private let contentLabel = UILabel()
    
    var content = "" {
        didSet {
            contentLabel.text = content
            adjustContentFrame()
        }
    }
    var textColor: UIColor = UIColor.blackColor() {
        didSet {
            contentLabel.textColor = textColor
        }
    }
    
    // MARK: - Initializer -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContentFontWith(fontName name: String = ".SFUIText-Medium", size: CGFloat) {
        contentLabel.font = UIFont(name: name, size: size)
    }
}

// MARK: - Private Methods

private extension KoyomiCell {
    func adjustContentFrame() {
        contentLabel.sizeToFit()
        contentLabel.frame.origin = CGPoint(x: (frame.width - contentLabel.frame.width) / 2, y: (frame.height - contentLabel.frame.height) / 2)
    }
}
