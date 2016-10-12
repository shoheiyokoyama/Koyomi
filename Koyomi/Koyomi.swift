//
//  Koyomi.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2016/10/09.
//
//

import UIKit

@IBDesignable
final public class Koyomi: UICollectionView {
    
    @IBInspectable var sectionSpace: CGFloat = 1.5
    @IBInspectable var cellSpace: CGFloat = 0.5
    @IBInspectable var weekCellHeight: CGFloat = 25
    public var inset: UIEdgeInsets = UIEdgeInsetsZero {
        didSet {
            setCollectionViewLayout(layout, animated: false)
        }
    }
    
    public var weeks: [String] = [] {
        didSet {
            model.weeks = weeks
            reloadData()
        }
    }
    
    @IBInspectable public var sectionSeparatorColor: UIColor = UIColor.KoyomiColor.lightGray {
        didSet {
            sectionSeparator.backgroundColor = sectionSeparatorColor
        }
    }
    @IBInspectable public var separatorColor: UIColor = UIColor.KoyomiColor.lightGray {
        didSet {
            backgroundColor = separatorColor
        }
    }
    @IBInspectable public var weekColor: UIColor       = UIColor.KoyomiColor.black
    @IBInspectable public var weekdayColor: UIColor    = UIColor.KoyomiColor.black
    @IBInspectable public var holidayColor: UIColor    = UIColor.KoyomiColor.darkGray
    @IBInspectable public var otherMonthColor: UIColor = UIColor.KoyomiColor.lightGray
    
    @IBInspectable public var dayBackgrondColor: UIColor  = .whiteColor()
    @IBInspectable public var weekBackgrondColor: UIColor = .whiteColor()
    
    public var currentDateString: String {
        return model.dateString(in: .current)
    }
    
    private static let cellIdentifier = "KoyomiCell"
    
    private lazy var model: DateModel = .init()
    private let sectionSeparator: UIView = .init()
    
    private var layout: UICollectionViewLayout {
        return KoyomiLayout(inset: inset, cellSpace: cellSpace, sectionSpace: sectionSpace, weekCellHeight: weekCellHeight)
    }
    
    private var dayLabelFont: UIFont?
    private var weekLabelFont: UIFont?

    // MARK: - Initialization -

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
        collectionViewLayout = layout
    }
    
    public init(frame: CGRect, sectionSpace: CGFloat = 1.5, cellSpace: CGFloat = 0.5, inset: UIEdgeInsets = UIEdgeInsetsZero, weekCellHeight: CGFloat = 25) {
        super.init(frame: frame, collectionViewLayout: KoyomiLayout(inset: inset, cellSpace: cellSpace, sectionSpace: sectionSpace, weekCellHeight: weekCellHeight))
        self.sectionSpace = sectionSpace
        self.cellSpace = cellSpace
        self.inset = inset
        self.weekCellHeight = weekCellHeight
        configure()
    }
    
    public func display(in month: MonthType) {
        model.display(in: month)
        reloadData()
    }
    
    public func setDayFont(fontName name: String = ".SFUIText-Medium", size: CGFloat) -> Self {
        dayLabelFont = UIFont(name: name, size: size)
        return self
    }
    
    public func setWeekFont(fontName name: String = ".SFUIText-Medium", size: CGFloat) -> Self {
        weekLabelFont = UIFont(name: name, size: size)
        return self
    }
    
    // MARK: - override -
    
    override public func reloadData() {
        super.reloadData()
        setCollectionViewLayout(layout, animated: false)
    }
}

// MARK: - Private Methods -

private extension Koyomi {
    func configure() {
        delegate      = self
        dataSource    = self
        scrollEnabled = false
        
        backgroundColor = separatorColor
        
        registerClass(KoyomiCell.self, forCellWithReuseIdentifier: Koyomi.cellIdentifier)
        
        sectionSeparator.backgroundColor = sectionSeparatorColor
        sectionSeparator.frame = CGRect(x: inset.left, y: inset.top + weekCellHeight, width: frame.width - (inset.top + inset.left), height: sectionSpace)
        addSubview(sectionSeparator)
    }
    
    func configure(cell: KoyomiCell, at indexPath: NSIndexPath) {
        
        cell.content = indexPath.section == 0 ? model.weeks[indexPath.row] : model.dayString(at: indexPath)
        cell.backgroundColor = weekBackgrondColor
        if indexPath.section == 0 {
            cell.textColor = weekColor
            if let font = weekLabelFont {
                cell.setContentFont(fontName: font.fontName, size: font.pointSize)
            }
        } else {
            cell.backgroundColor = dayBackgrondColor
            cell.textColor = {
               if indexPath.row < model.indexAtBeginning(in: .current) || indexPath.row > model.indexAtEnd(in: .current) {
                    return otherMonthColor
               } else if indexPath.row % 7 == 0 || indexPath.row % 7 == 6 {
                    return holidayColor
               } else {
                    return weekdayColor
               }
            }()
            
            if let font = dayLabelFont {
                cell.setContentFont(fontName: font.fontName, size: font.pointSize)
            }
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
        return section == 0 ? DateModel.dayCountPerRow : DateModel.maxCellCount
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Koyomi.cellIdentifier, forIndexPath: indexPath) as! KoyomiCell
        configure(cell, at: indexPath)
        return cell
    }
}

