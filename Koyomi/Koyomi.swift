//
//  Koyomi.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2016/10/09.
//
//

import UIKit

// MARK: - KoyomiDelegate -

@objc public protocol KoyomiDelegate: class {
    // Tells the delegate that the date at the specified index path was selected.
    optional func koyomi(koyomi: Koyomi, didSelect date: NSDate, forItemAt indexPath: NSIndexPath)
    // Tells the delegate that the displayed month is changed.
    optional func koyomi(koyomi: Koyomi, currentDateString dateString: String)
    // The koyomi calls this method before select days as period only when selectionMode is sequence.
    // return value: true if the item should be selected or false if it should not.
    optional func koyomi(koyomi: Koyomi, willSelectPeriod period: Int, forItemAt indexPath: NSIndexPath) -> Bool
}

// MARK: - KoyomiStyle -

public enum KoyomiStyle {
    case monotone, standard, red, orange, yellow, tealBlue, blue, purple, green, pink
    case deepBlack, deepRed, deepOrange, deepYellow, deepTealBlue, deepBlue, deepPurple, deepGreen, deepPink
    
    var colors: Koyomi.Colors {
        switch self {
            
        // Basic color style
        case monotone: return .init(dayBackgrond: .whiteColor(), weekBackgrond: .whiteColor(), holiday: (UIColor.KoyomiColor.darkGray, UIColor.KoyomiColor.darkGray))
        case standard: return .init(dayBackgrond: .whiteColor(), weekBackgrond: .whiteColor(), holiday: (UIColor.KoyomiColor.blue, UIColor.KoyomiColor.red))
        case red:      return .init(dayBackgrond: .whiteColor(), weekBackgrond: UIColor.KoyomiColor.red, week: .whiteColor(), holiday: (UIColor.KoyomiColor.darkGray, UIColor.KoyomiColor.darkGray), separator: UIColor.KoyomiColor.red)
        case orange:   return .init(dayBackgrond: .whiteColor(), weekBackgrond: UIColor.KoyomiColor.orange, week: .whiteColor(), holiday: (UIColor.KoyomiColor.darkGray, UIColor.KoyomiColor.darkGray), separator: UIColor.KoyomiColor.orange)
        case yellow:   return .init(dayBackgrond: .whiteColor(), weekBackgrond: UIColor.KoyomiColor.yellow, week: .whiteColor(), holiday: (UIColor.KoyomiColor.darkGray, UIColor.KoyomiColor.darkGray), separator: UIColor.KoyomiColor.yellow)
        case tealBlue: return .init(dayBackgrond: .whiteColor(), weekBackgrond: UIColor.KoyomiColor.tealBlue, week: .whiteColor(), holiday: (UIColor.KoyomiColor.darkGray, UIColor.KoyomiColor.darkGray), separator: UIColor.KoyomiColor.tealBlue)
        case blue:     return .init(dayBackgrond: .whiteColor(), weekBackgrond: UIColor.KoyomiColor.blue, week: .whiteColor(), holiday: (UIColor.KoyomiColor.darkGray, UIColor.KoyomiColor.darkGray), separator: UIColor.KoyomiColor.blue)
        case purple:   return .init(dayBackgrond: .whiteColor(), weekBackgrond: UIColor.KoyomiColor.purple, week: .whiteColor(), holiday: (UIColor.KoyomiColor.darkGray, UIColor.KoyomiColor.darkGray), separator: UIColor.KoyomiColor.purple)
        case green:    return .init(dayBackgrond: .whiteColor(), weekBackgrond: UIColor.KoyomiColor.green, week: .whiteColor(), holiday: (UIColor.KoyomiColor.darkGray, UIColor.KoyomiColor.darkGray), separator: UIColor.KoyomiColor.green)
        case pink:     return .init(dayBackgrond: .whiteColor(), weekBackgrond: UIColor.KoyomiColor.pink, week: .whiteColor(), holiday: (UIColor.KoyomiColor.darkGray, UIColor.KoyomiColor.darkGray), separator: UIColor.KoyomiColor.pink)
            
        // Deep color style
        case deepBlack:    return .init(dayBackgrond: UIColor.KoyomiColor.black, weekBackgrond: UIColor.KoyomiColor.black, week: .whiteColor(), weekday: .whiteColor(), holiday: (.whiteColor(), .whiteColor()), otherMonth: UIColor.KoyomiColor.lightGray, separator: UIColor.KoyomiColor.darkBlack)
        case deepRed:      return .init(dayBackgrond: UIColor.KoyomiColor.red, weekBackgrond: UIColor.KoyomiColor.red, week: .whiteColor(), weekday: .whiteColor(), holiday: (.whiteColor(), .whiteColor()), otherMonth: UIColor.KoyomiColor.lightGray, separator: UIColor.KoyomiColor.orange)
        case deepOrange:   return .init(dayBackgrond: UIColor.KoyomiColor.orange, weekBackgrond: UIColor.KoyomiColor.orange, week: .whiteColor(), weekday: .whiteColor(), holiday: (.whiteColor(), .whiteColor()), otherMonth: UIColor.KoyomiColor.lightGray, separator: UIColor.KoyomiColor.yellow)
        case deepYellow:   return .init(dayBackgrond: UIColor.KoyomiColor.yellow, weekBackgrond: UIColor.KoyomiColor.yellow, week: .whiteColor(), weekday: .whiteColor(), holiday: (.whiteColor(), .whiteColor()), otherMonth: UIColor.KoyomiColor.lightGray, separator: UIColor.KoyomiColor.lightYellow)
        case deepTealBlue: return .init(dayBackgrond: UIColor.KoyomiColor.tealBlue, weekBackgrond: UIColor.KoyomiColor.tealBlue, week: .whiteColor(), weekday: .whiteColor(), holiday: (.whiteColor(), .whiteColor()), otherMonth: UIColor.KoyomiColor.lightGray, separator: UIColor.KoyomiColor.blue)
        case deepBlue:     return .init(dayBackgrond: UIColor.KoyomiColor.blue, weekBackgrond: UIColor.KoyomiColor.blue, week: .whiteColor(), weekday: .whiteColor(), holiday: (.whiteColor(), .whiteColor()), otherMonth: UIColor.KoyomiColor.lightGray, separator: UIColor.KoyomiColor.tealBlue)
        case deepPurple:   return .init(dayBackgrond: UIColor.KoyomiColor.purple, weekBackgrond: UIColor.KoyomiColor.purple, week: .whiteColor(), weekday: .whiteColor(), holiday: (.whiteColor(), .whiteColor()), otherMonth: UIColor.KoyomiColor.lightGray, separator: UIColor.KoyomiColor.lightPurple)
        case deepGreen:    return .init(dayBackgrond: UIColor.KoyomiColor.green, weekBackgrond: UIColor.KoyomiColor.green, week: .whiteColor(), weekday: .whiteColor(), holiday: (.whiteColor(), .whiteColor()), otherMonth: UIColor.KoyomiColor.lightGray, separator: UIColor.KoyomiColor.lightGreen)
        case deepPink:     return .init(dayBackgrond: UIColor.KoyomiColor.pink, weekBackgrond: UIColor.KoyomiColor.pink, week: .whiteColor(), weekday: .whiteColor(), holiday: (.whiteColor(), .whiteColor()), otherMonth: UIColor.KoyomiColor.lightGray, separator: UIColor.KoyomiColor.lightPink)
        }
    }
}

// MARK: - SelectionMode -

public enum SelectionMode {
    case single(style: Style), multiple(style: Style), sequence(style: SequenceStyle), none
    
    public enum SequenceStyle { case background, circle, semicircleEdge }
    public enum Style { case background, circle }
}

// MARK: - Koyomi -

@IBDesignable
final public class Koyomi: UICollectionView {
    struct Colors {
        let dayBackgrond: UIColor
        let weekBackgrond: UIColor
        
        let week: UIColor
        let weekday: UIColor
        let holiday: (saturday: UIColor, sunday: UIColor)
        let otherMonth: UIColor
        
        let separator: UIColor
        
        init(dayBackgrond: UIColor, weekBackgrond: UIColor, week: UIColor = UIColor.KoyomiColor.black, weekday: UIColor = UIColor.KoyomiColor.black, holiday: (saturday: UIColor, sunday: UIColor) = (UIColor.KoyomiColor.blue, UIColor.KoyomiColor.red), otherMonth: UIColor = UIColor.KoyomiColor.lightGray, separator: UIColor = UIColor.KoyomiColor.lightGray) {
            self.dayBackgrond  = dayBackgrond
            self.weekBackgrond = weekBackgrond
            
            self.week = week
            self.weekday = weekday
            self.holiday.saturday = holiday.saturday
            self.holiday.sunday   = holiday.sunday
            self.otherMonth = otherMonth
            self.separator  = separator
        }
    }
    
    public var style: KoyomiStyle = .standard {
        didSet {
            dayBackgrondColor  = style.colors.dayBackgrond
            weekBackgrondColor = style.colors.weekBackgrond
            weekColor = style.colors.week
            weekdayColor = style.colors.weekday
            holidayColor = style.colors.holiday
            otherMonthColor = style.colors.otherMonth
            backgroundColor = style.colors.separator
            sectionSeparator.backgroundColor = style.colors.separator
        }
    }
    
    public var selectionMode: SelectionMode = .single(style: .circle) {
        didSet {
            model.selectionMode = {
                switch selectionMode {
                case .single(_):   return .single
                case .multiple(_): return .multiple
                case .sequence(_): return .sequence
                case .none:        return .none
                }
            }()
        }
    }
    
    // Layout properties
    @IBInspectable var sectionSpace: CGFloat = 1.5 {
        didSet {
            sectionSeparator.frame.size.height = sectionSpace
        }
    }
    @IBInspectable var cellSpace: CGFloat = 0.5 {
        didSet {
            if let layout = collectionViewLayout as? KoyomiLayout where layout.cellSpace != cellSpace {
                setCollectionViewLayout(self.layout, animated: false)
            }
        }
    }
    @IBInspectable var weekCellHeight: CGFloat = 25 {
        didSet {
            sectionSeparator.frame.origin.y = inset.top + weekCellHeight
            if let layout = collectionViewLayout as? KoyomiLayout where layout.weekCellHeight != weekCellHeight {
                setCollectionViewLayout(self.layout, animated: false)
            }
        }
    }
    public var inset = UIEdgeInsetsZero {
        didSet {
            if let layout = collectionViewLayout as? KoyomiLayout where layout.inset != inset {
                setCollectionViewLayout(self.layout, animated: false)
            }
        }
    }
    
    // Week cell text
    public var weeks: [String] = [] {
        didSet {
            model.weeks = weeks
            reloadData()
        }
    }
    @IBInspectable public var currentDateFormat: String = "M/yyyy"
    
    // Color properties of the appearance
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
    @IBInspectable public var weekColor    = UIColor.KoyomiColor.black
    @IBInspectable public var weekdayColor = UIColor.KoyomiColor.black
    @IBInspectable public var otherMonthColor = UIColor.KoyomiColor.lightGray
    @IBInspectable public var dayBackgrondColor: UIColor  = .whiteColor()
    @IBInspectable public var weekBackgrondColor: UIColor = .whiteColor()
    public var holidayColor: (saturday: UIColor, sunday: UIColor) = (UIColor.KoyomiColor.blue, UIColor.KoyomiColor.red)
    
    @IBInspectable public var selectedBackgroundColor = UIColor.KoyomiColor.red
    @IBInspectable public var selectedTextColor: UIColor = .whiteColor()
    
    // KoyomiDelegate
    public weak var calendarDelegate: KoyomiDelegate?

    // Private properties
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
    
    // MARK: - Public Methods -
    
    public func display(in month: MonthType) {
        model.display(in: month)
        reloadData()
        calendarDelegate?.koyomi?(self, currentDateString: model.dateString(in: .current, withFormat: currentDateFormat))
    }
    
    public func setDayFont(fontName name: String = ".SFUIText-Medium", size: CGFloat) -> Self {
        dayLabelFont = UIFont(name: name, size: size)
        return self
    }
    
    public func setWeekFont(fontName name: String = ".SFUIText-Medium", size: CGFloat) -> Self {
        weekLabelFont = UIFont(name: name, size: size)
        return self
    }
    
    public func currentDateString(withFormat format: String = "M/yyyy") -> String {
        return model.dateString(in: .current, withFormat: format)
    }
    
    public func select(date date: NSDate, to toDate: NSDate? = nil) -> Self {
        model.select(from: date, to: toDate)
        return self
    }
    
    public func unselect(date date: NSDate, to toDate: NSDate? = nil) -> Self {
        model.unselect(from: date, to: toDate)
        return self
    }
    
    public func unselectAll() -> Self {
        model.unselectAll()
        return self
    }
    
    // MARK: - Override Method -
    
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
        
        // Appearance properties
        let style: KoyomiCell.CellStyle
        let textColor: UIColor
        let isSelected: Bool
        let backgroundColor: UIColor
        let font: UIFont?
        let content: String
        
        if indexPath.section == 0 {
            
            // Configure appearance properties for week cell
            style = .standard
            textColor = weekColor
            isSelected  = false
            backgroundColor = weekBackgrondColor
            font = weekLabelFont
            content = model.weeks[indexPath.row]
            
        } else {

            // Configure appearance properties for day cell
            (textColor, isSelected) = {
                if model.isSelect(with: indexPath) {
                    return (selectedTextColor, true)
                } else if indexPath.row < model.indexAtBeginning(in: .current) || indexPath.row > model.indexAtEnd(in: .current) {
                    return (otherMonthColor, false)
                } else if indexPath.row % 7 == 0 {
                    return (holidayColor.sunday, false)
                } else if indexPath.row % 7 == 6 {
                    return (holidayColor.saturday, false)
                } else {
                    return (weekdayColor, false)
                }
            }()
            
            style = {
                switch (selectionMode, isSelected) {
                //Not selected or background style of single, multiple, sequence mode
                case (_, false), (.single(style: .background), true), (.multiple(style: .background), true), (.sequence(style: .background), true):
                    return .standard
                    
                //Selected and circle style of single, multiple, sequence mode
                case (.single(style: .circle), true), (.multiple(style: .circle), true), (.sequence(style: .circle), true):
                    return .circle
                    
                //Selected and sequence mode, semicircleEdge style
                case (.sequence(style: .semicircleEdge), true):
                    let date = model.date(at: indexPath)
                    if let start = model.sequenceDates.start, let _ = model.sequenceDates.end where date == start {
                        return .sequence(position: .left)
                    } else if let _ = model.sequenceDates.start, let end = model.sequenceDates.end where date == end {
                        return .sequence(position: .right)
                    } else {
                        return .sequence(position: .middle)
                    }
                    
                default: return .standard
                }
            }()
            
            backgroundColor = dayBackgrondColor
            font    = dayLabelFont
            content = model.dayString(at: indexPath)
        }
        
        // Set cell to appearance properties
        cell.content   = content
        cell.textColor = textColor
        cell.configureAppearanse(of: style, withColor: selectedBackgroundColor, backgroundColor: backgroundColor, isSelected: isSelected)
        if let font = font {
            cell.setContentFont(fontName: font.fontName, size: font.pointSize)
        }
    }
}

// MARK: - UICollectionViewDelegate -

extension Koyomi: UICollectionViewDelegate {
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard indexPath.section != 0 else { return }
        
        calendarDelegate?.koyomi?(self, didSelect: model.date(at: indexPath), forItemAt: indexPath)
        
        if case .none = selectionMode { return }
        
        let period = model.selectedPeriod(with: indexPath)
        if case .sequence(_) = selectionMode where calendarDelegate?.koyomi?(self, willSelectPeriod: period, forItemAt: indexPath) == false {
            return
        }
        
        model.select(with: indexPath)
        reloadData()
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
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Koyomi.cellIdentifier, forIndexPath: indexPath) as? KoyomiCell else {
            return .init()
        }
        configure(cell, at: indexPath)
        return cell
    }
}

