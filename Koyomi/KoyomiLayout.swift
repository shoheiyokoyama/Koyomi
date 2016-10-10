//
//  KoyomiLayout.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2016/10/10.
//
//

import UIKit

final class KoyomiLayout: UICollectionViewLayout {
    private let inset: UIEdgeInsets
    private let cellSpace: CGFloat
    private let sectionSpace: CGFloat
    private var layoutAttributes: [NSIndexPath: UICollectionViewLayoutAttributes] = [:]
    
    // MARK: - Initializer -
    
    init(inset: UIEdgeInsets, cellSpace: CGFloat, sectionSpace: CGFloat) {
        self.inset = inset
        self.cellSpace    = cellSpace
        self.sectionSpace = sectionSpace
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Please use custom initialization")
    }
}

// MARK: - Override Methods -

extension KoyomiLayout {
    override func prepareLayout() {
        let sectionCount = collectionView?.numberOfSections() ?? 0
        (0..<sectionCount).forEach { section in
            let itemCount = collectionView?.numberOfItemsInSection(section) ?? 0
            (0..<itemCount).forEach { row in
                let indexPath = NSIndexPath(forRow: row, inSection: section)
                let attribute = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                attribute.frame = frame(at: indexPath)
                layoutAttributes[indexPath] = attribute
            }
        }
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes.filter {
            if rect.contains($0.1.frame) { return true }
            return false
        }.map { $0.1 }
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributes[indexPath]
    }
    
    override func collectionViewContentSize() -> CGSize {
        return collectionView?.frame.size ?? .zero
    }
}

// MARK: - Private Methods -

private extension KoyomiLayout {
    struct Constant {
        static let columnCount = 7
        static let maxLineSpaceCount = 5
        static let maxRowCount = 7
    }
    
    func frame(at indexPath: NSIndexPath) -> CGRect {
        let count = CGFloat(DateModel.weeks.count)
        let availableWidth: CGFloat = (collectionView?.frame.width ?? 0) - cellSpace * CGFloat(count - 1) - inset.right - inset.left
        let availableHeight: CGFloat = (collectionView?.frame.height ?? 0) - (cellSpace * CGFloat(Constant.maxLineSpaceCount) + inset.bottom + inset.top + sectionSpace)
        let size = CGSize(width: availableWidth / count, height: availableHeight / CGFloat(Constant.maxRowCount))
        
        let row = floor(CGFloat(indexPath.row) / count)
        let column = CGFloat(indexPath.row) - row * count
        
        let lineSpace = row == 0 ? 0 : cellSpace
        let y = indexPath.section == 0 ? inset.top : row * (size.height + lineSpace) + size.height + sectionSpace + inset.top
        let x = (size.width + cellSpace) * column + inset.left
        
        return CGRect(origin: CGPoint(x: x, y: y), size: size)
    }
}
