//
//  Koyomi.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2016/10/09.
//
//

import UIKit

final public class Koyomi: UICollectionView {
    var sectionSpace: CGFloat = 1
    var cellSpace: CGFloat    = 0.5
    var inset = UIEdgeInsetsZero
    
    private static let cellIdentifier = "KoyomiCell"
    
    private lazy var model = DateModel()
    
    // MARK: - Initialization -

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
}

// MARK: - Private Methods -

private extension Koyomi {
    func configure() {
        delegate      = self
        dataSource    = self
        scrollEnabled = false
        
        backgroundColor = UIColor.grayColor()
        
        registerClass(KoyomiCell.self, forCellWithReuseIdentifier: Koyomi.cellIdentifier)
        collectionViewLayout = KoyomiLayout(inset: inset, cellSpace: cellSpace, sectionSpace: sectionSpace)
    }
    
    func configure(cell: KoyomiCell, at indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.whiteColor()
        if indexPath.section == 0 {
            cell.content = DateModel.weeks[indexPath.row]
        } else {
            cell.content = model.dayString(at: indexPath)
        }
    }
}

// MARK: - UICollectionViewDelegate -


extension Koyomi: UICollectionViewDelegate {
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // TODO: -
    }
}

// MARK: - UICollectionViewDataSource -

extension Koyomi: UICollectionViewDataSource {
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? DateModel.weeks.count : model.cellCount(in: .current)
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Koyomi.cellIdentifier, forIndexPath: indexPath) as! KoyomiCell
        configure(cell, at: indexPath)
        return cell
    }
}

