//
//  KoyomiLayout.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2016/10/10.
//
//

import UIKit

final class KoyomiLayout: UICollectionViewLayout {
    let inset: UIEdgeInsets
    let cellSpace: CGFloat
    let sectionSpace: CGFloat
    private var layoutAttributes: [NSIndexPath: UICollectionViewLayoutAttributes] = [:]
    
    let weekCellHeight: CGFloat
    
    // MARK: - Initializer -
    
    init(inset: UIEdgeInsets, cellSpace: CGFloat, sectionSpace: CGFloat, weekCellHeight: CGFloat) {
        self.inset = inset
        self.cellSpace      = cellSpace
        self.sectionSpace   = sectionSpace
        self.weekCellHeight = weekCellHeight
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
        static let maxLineSpaceCount = 5
        static let maxRowCount = 6
        static var columnCount: CGFloat {
            return CGFloat(DateModel.dayCountPerRow)
        }
    }
    
    private var width: CGFloat {
        return (collectionView?.frame.width ?? 0)
    }
    private var height: CGFloat {
        return (collectionView?.frame.height ?? 0)
    }
    
    func frame(at indexPath: NSIndexPath) -> CGRect {
        let isWeekCell = indexPath.section == 0
        
        let availableWidth: CGFloat  = width - (cellSpace * CGFloat(Constant.columnCount - 1) + inset.right + inset.left)
        let availableHeight: CGFloat = height - (cellSpace * CGFloat(Constant.maxLineSpaceCount) + inset.bottom + inset.top + sectionSpace + weekCellHeight)
        let size = CGSize(width: availableWidth / Constant.columnCount, height: isWeekCell ? weekCellHeight : availableHeight / CGFloat(Constant.maxRowCount))
        
        let row    = floor(CGFloat(indexPath.row) / Constant.columnCount)
        let column = CGFloat(indexPath.row) - row * Constant.columnCount
        
        let lineSpace = row == 0 ? 0 : cellSpace
        let y = isWeekCell ? inset.top : row * (size.height + lineSpace) + weekCellHeight + sectionSpace + inset.top
        let x = (size.width + cellSpace) * column + inset.left
        
        return CGRect(origin: CGPoint(x: x, y: y), size: size)
    }
}
