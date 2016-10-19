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
    
    // MARK: - Initializer -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubview(contentLabel)
    }
    
    func setContentFont(fontName name: String, size: CGFloat) {
        contentLabel.font = UIFont(name: name, size: size)
        adjustContentFrame()
    }
}

// MARK: - Private Methods

private extension KoyomiCell {
    func adjustContentFrame() {
        contentLabel.sizeToFit()
        contentLabel.frame.origin = CGPoint(x: (frame.width - contentLabel.frame.width) / 2, y: (frame.height - contentLabel.frame.height) / 2)
    }
}
