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
    @objc optional func koyomi(_ koyomi: Koyomi, didSelect date: Date?, forItemAt indexPath: IndexPath)
    
    // Tells the delegate that the displayed month is changed.
    @objc optional func koyomi(_ koyomi: Koyomi, currentDateString dateString: String)

    // The koyomi calls this method before select days
    // return value: true if the item should be selected or false if it should not.
    @objc optional func koyomi(_ koyomi: Koyomi, shouldSelectDates date: Date?, to: Date?, WithPeriodLength lenght: Int) -> Bool
}

// MARK: - KoyomiStyle -

public enum KoyomiStyle {
    case monotone, standard, red, orange, yellow, tealBlue, blue, purple, green, pink
    case deepBlack, deepRed, deepOrange, deepYellow, deepTealBlue, deepBlue, deepPurple, deepGreen, deepPink
    
    var colors: Koyomi.Colors {
        switch self {
            
        // Basic color style
        case .monotone: return .init(dayBackgrond: .white, weekBackgrond: .white, holiday: (UIColor.KoyomiColor.darkGray, UIColor.KoyomiColor.darkGray))
        case .standard: return .init(dayBackgrond: .white, weekBackgrond: .white, holiday: (UIColor.KoyomiColor.blue, UIColor.KoyomiColor.red))
        case .red:      return .init(dayBackgrond: .white, weekBackgrond: UIColor.KoyomiColor.red, week: .white, holiday: (UIColor.KoyomiColor.darkGray, UIColor.KoyomiColor.darkGray), separator: UIColor.KoyomiColor.red)
        case .orange:   return .init(dayBackgrond: .white, weekBackgrond: UIColor.KoyomiColor.orange, week: .white, holiday: (UIColor.KoyomiColor.darkGray, UIColor.KoyomiColor.darkGray), separator: UIColor.KoyomiColor.orange)
        case .yellow:   return .init(dayBackgrond: .white, weekBackgrond: UIColor.KoyomiColor.yellow, week: .white, holiday: (UIColor.KoyomiColor.darkGray, UIColor.KoyomiColor.darkGray), separator: UIColor.KoyomiColor.yellow)
        case .tealBlue: return .init(dayBackgrond: .white, weekBackgrond: UIColor.KoyomiColor.tealBlue, week: .white, holiday: (UIColor.KoyomiColor.darkGray, UIColor.KoyomiColor.darkGray), separator: UIColor.KoyomiColor.tealBlue)
        case .blue:     return .init(dayBackgrond: .white, weekBackgrond: UIColor.KoyomiColor.blue, week: .white, holiday: (UIColor.KoyomiColor.darkGray, UIColor.KoyomiColor.darkGray), separator: UIColor.KoyomiColor.blue)
        case .purple:   return .init(dayBackgrond: .white, weekBackgrond: UIColor.KoyomiColor.purple, week: .white, holiday: (UIColor.KoyomiColor.darkGray, UIColor.KoyomiColor.darkGray), separator: UIColor.KoyomiColor.purple)
        case .green:    return .init(dayBackgrond: .white, weekBackgrond: UIColor.KoyomiColor.green, week: .white, holiday: (UIColor.KoyomiColor.darkGray, UIColor.KoyomiColor.darkGray), separator: UIColor.KoyomiColor.green)
        case .pink:     return .init(dayBackgrond: .white, weekBackgrond: UIColor.KoyomiColor.pink, week: .white, holiday: (UIColor.KoyomiColor.darkGray, UIColor.KoyomiColor.darkGray), separator: UIColor.KoyomiColor.pink)
            
        // Deep color style
        case .deepBlack:    return .init(dayBackgrond: UIColor.KoyomiColor.black, weekBackgrond: UIColor.KoyomiColor.black, week: .white, weekday: .white, holiday: (.white, .white), otherMonth: UIColor.KoyomiColor.lightGray, separator: UIColor.KoyomiColor.darkBlack)
        case .deepRed:      return .init(dayBackgrond: UIColor.KoyomiColor.red, weekBackgrond: UIColor.KoyomiColor.red, week: .white, weekday: .white, holiday: (.white, .white), otherMonth: UIColor.KoyomiColor.lightGray, separator: UIColor.KoyomiColor.orange)
        case .deepOrange:   return .init(dayBackgrond: UIColor.KoyomiColor.orange, weekBackgrond: UIColor.KoyomiColor.orange, week: .white, weekday: .white, holiday: (.white, .white), otherMonth: UIColor.KoyomiColor.lightGray, separator: UIColor.KoyomiColor.yellow)
        case .deepYellow:   return .init(dayBackgrond: UIColor.KoyomiColor.yellow, weekBackgrond: UIColor.KoyomiColor.yellow, week: .white, weekday: .white, holiday: (.white, .white), otherMonth: UIColor.KoyomiColor.lightGray, separator: UIColor.KoyomiColor.lightYellow)
        case .deepTealBlue: return .init(dayBackgrond: UIColor.KoyomiColor.tealBlue, weekBackgrond: UIColor.KoyomiColor.tealBlue, week: .white, weekday: .white, holiday: (.white, .white), otherMonth: UIColor.KoyomiColor.lightGray, separator: UIColor.KoyomiColor.blue)
        case .deepBlue:     return .init(dayBackgrond: UIColor.KoyomiColor.blue, weekBackgrond: UIColor.KoyomiColor.blue, week: .white, weekday: .white, holiday: (.white, .white), otherMonth: UIColor.KoyomiColor.lightGray, separator: UIColor.KoyomiColor.tealBlue)
        case .deepPurple:   return .init(dayBackgrond: UIColor.KoyomiColor.purple, weekBackgrond: UIColor.KoyomiColor.purple, week: .white, weekday: .white, holiday: (.white, .white), otherMonth: UIColor.KoyomiColor.lightGray, separator: UIColor.KoyomiColor.lightPurple)
        case .deepGreen:    return .init(dayBackgrond: UIColor.KoyomiColor.green, weekBackgrond: UIColor.KoyomiColor.green, week: .white, weekday: .white, holiday: (.white, .white), otherMonth: UIColor.KoyomiColor.lightGray, separator: UIColor.KoyomiColor.lightGreen)
        case .deepPink:     return .init(dayBackgrond: UIColor.KoyomiColor.pink, weekBackgrond: UIColor.KoyomiColor.pink, week: .white, weekday: .white, holiday: (.white, .white), otherMonth: UIColor.KoyomiColor.lightGray, separator: UIColor.KoyomiColor.lightPink)
        }
    }
}

// MARK: - SelectionMode -

public enum SelectionMode {
    case single(style: Style), multiple(style: Style), sequence(style: SequenceStyle), none
    
    public enum SequenceStyle { case background, circle, semicircleEdge }
    public enum Style { case background, circle }
}

// MARK: - ContentPosition -

public enum ContentPosition {
    case topLeft, topCenter, topRight
    case left, center, right
    case bottomLeft, bottomCenter, bottomRight
    case custom(x: CGFloat, y: CGFloat)
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
            if let layout = collectionViewLayout as? KoyomiLayout , layout.cellSpace != cellSpace {
                setCollectionViewLayout(self.layout, animated: false)
            }
        }
    }
    @IBInspectable var weekCellHeight: CGFloat = 25 {
        didSet {
            sectionSeparator.frame.origin.y = inset.top + weekCellHeight
            if let layout = collectionViewLayout as? KoyomiLayout , layout.weekCellHeight != weekCellHeight {
                setCollectionViewLayout(self.layout, animated: false)
            }
        }
    }
    public var inset: UIEdgeInsets = .zero {
        didSet {
            if let layout = collectionViewLayout as? KoyomiLayout , layout.inset != inset {
                setCollectionViewLayout(self.layout, animated: false)
            }
        }
    }
    public var dayPosition: ContentPosition  = .center
    public var weekPosition: ContentPosition = .center
    
    // Week cell text
    public var weeks: [String] = [] {
        didSet {
            model.weeks = weeks
            reloadData()
        }
    }
    @IBInspectable public var currentDateFormat: String = "M/yyyy"
    
    // Color properties of the appearance
    @IBInspectable public var sectionSeparatorColor = UIColor.KoyomiColor.lightGray {
        didSet {
            sectionSeparator.backgroundColor = sectionSeparatorColor
        }
    }
    @IBInspectable public var separatorColor = UIColor.KoyomiColor.lightGray {
        didSet {
            backgroundColor = separatorColor
        }
    }
    @IBInspectable public var weekColor    = UIColor.KoyomiColor.black
    @IBInspectable public var weekdayColor = UIColor.KoyomiColor.black
    @IBInspectable public var otherMonthColor = UIColor.KoyomiColor.lightGray
    @IBInspectable public var dayBackgrondColor: UIColor  = .white
    @IBInspectable public var weekBackgrondColor: UIColor = .white
    public var holidayColor: (saturday: UIColor, sunday: UIColor) = (UIColor.KoyomiColor.blue, UIColor.KoyomiColor.red)
    
    @IBInspectable public var selectedBackgroundColor = UIColor.KoyomiColor.red
    @IBInspectable public var selectedTextColor: UIColor = .white
    
    @IBInspectable public var inactiveBackgroundColor: UIColor = .white
    @IBInspectable public var inactiveTextColor: UIColor = .lightGray
    
    // KoyomiDelegate
    public weak var calendarDelegate: KoyomiDelegate?

    // Fileprivate properties
    fileprivate static let cellIdentifier = "KoyomiCell"
    
    fileprivate lazy var model: DateModel    = .init()
    fileprivate let sectionSeparator: UIView = .init()
    
    fileprivate var layout: UICollectionViewLayout {
        return KoyomiLayout(inset: inset, cellSpace: cellSpace, sectionSpace: sectionSpace, weekCellHeight: weekCellHeight)
    }
    
    fileprivate var dayLabelFont: UIFont?
    fileprivate var weekLabelFont: UIFont?

    // MARK: - Initialization -

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
        collectionViewLayout = layout
    }
    
    public init(frame: CGRect, sectionSpace: CGFloat = 1.5, cellSpace: CGFloat = 0.5, inset: UIEdgeInsets = .zero, weekCellHeight: CGFloat = 25) {
        super.init(frame: frame, collectionViewLayout: KoyomiLayout(inset: inset, cellSpace: cellSpace, sectionSpace: sectionSpace, weekCellHeight: weekCellHeight))
        self.sectionSpace = sectionSpace
        self.cellSpace = cellSpace
        self.inset = inset
        self.weekCellHeight = weekCellHeight
        configure()
    }
    
    // MARK: - Public Methods -
    public func setFirstSelectable(date: Date) {
        model.firstSelectableDate = date
    }
    
    public func setLastSelectableDate(date: Date) {
        model.lastSelectableDate = date
    }

    public func display(in month: MonthType) {
        model.display(in: month)
        reloadData()
        calendarDelegate?.koyomi?(self, currentDateString: model.dateString(in: .current, withFormat: currentDateFormat))
    }
    
    @discardableResult
    public func setDayFont(fontName name: String = ".SFUIText-Medium", size: CGFloat) -> Self {
        dayLabelFont = UIFont(name: name, size: size)
        return self
    }
    
    @discardableResult
    public func setWeekFont(fontName name: String = ".SFUIText-Medium", size: CGFloat) -> Self {
        weekLabelFont = UIFont(name: name, size: size)
        return self
    }
    
    public func currentDateString(withFormat format: String = "M/yyyy") -> String {
        return model.dateString(in: .current, withFormat: format)
    }
    
    @discardableResult
    public func select(date: Date, to toDate: Date? = nil) -> Self {
        model.select(from: date, to: toDate)
        return self
    }
    
    @discardableResult
    public func unselect(date: Date, to toDate: Date? = nil) -> Self {
        model.unselect(from: date, to: toDate)
        return self
    }
    
    @discardableResult
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
        isScrollEnabled = false
        
        backgroundColor = separatorColor
        
        register(KoyomiCell.self, forCellWithReuseIdentifier: Koyomi.cellIdentifier)
        
        sectionSeparator.backgroundColor = sectionSeparatorColor
        sectionSeparator.frame = CGRect(x: inset.left, y: inset.top + weekCellHeight, width: frame.width - (inset.top + inset.left), height: sectionSpace)
        addSubview(sectionSeparator)
    }
    
    func configure(_ cell: KoyomiCell, at indexPath: IndexPath) {
        
        // Appearance properties
        let style: KoyomiCell.CellStyle
        let textColor: UIColor
        let isSelected: Bool
        let backgroundColor: UIColor
        let font: UIFont?
        let content: String
        let postion: ContentPosition
        
        if indexPath.section == 0 {
            
            // Configure appearance properties for week cell
            style = .standard
            textColor  = weekColor
            isSelected = false
            backgroundColor = weekBackgrondColor
            font = weekLabelFont
            content = model.weeks[indexPath.row]
            postion = weekPosition
            
        } else {

            // Configure appearance properties for day cell
            (textColor, isSelected) = {
                if !model.isSelectable(with: indexPath) {
                    return (inactiveTextColor, false)
                } else if model.isSelect(with: indexPath) {
                    return (selectedTextColor, true)
                } else if let beginning = model.indexAtBeginning(in: .current), indexPath.row < beginning {
                    return (otherMonthColor, false)
                } else if let end = model.indexAtEnd(in: .current), indexPath.row > end {
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
                    if let start = model.sequenceDates.start, let _ = model.sequenceDates.end , date == start {
                        return .sequence(position: .left)
                    } else if let _ = model.sequenceDates.start, let end = model.sequenceDates.end , date == end {
                        return .sequence(position: .right)
                    } else {
                        return .sequence(position: .middle)
                    }
                    
                default: return .standard
                }
            }()
            
            backgroundColor = model.isSelectable(with: indexPath) ? dayBackgrondColor : inactiveBackgroundColor
            font    = dayLabelFont
            content = model.dayString(at: indexPath)
            postion = dayPosition
        }
        
        // Set cell to appearance properties
        cell.content   = content
        cell.textColor = textColor
        cell.contentPosition = postion
        cell.configureAppearanse(of: style, withColor: selectedBackgroundColor, backgroundColor: backgroundColor, isSelected: isSelected)
        if let font = font {
            cell.setContentFont(fontName: font.fontName, size: font.pointSize)
        }
    }
}

// MARK: - UICollectionViewDelegate -

extension Koyomi: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section != 0 else { return }
        
        // KoyomiDelegate properties
        let date: Date?
        let toDate: Date?
        let length: Int
        
        switch selectionMode {
        case .single(_), .multiple(_):
            date   = model.date(at: indexPath)
            toDate = nil
            length = 1
        
        case .sequence(_):
            let willSelectDates = model.willSelectDates(with: indexPath)
            date   = willSelectDates.from
            toDate = willSelectDates.to
            length = model.selectedPeriod(with: indexPath)
            
        case .none: return
        }
        
        if calendarDelegate?.koyomi?(self, shouldSelectDates: date, to: toDate, WithPeriodLength: length) == false {
            return
        }
        
        model.select(with: indexPath)
        reloadData()
        
        calendarDelegate?.koyomi?(self, didSelect: date, forItemAt: indexPath)
    }
}

// MARK: - UICollectionViewDataSource -

extension Koyomi: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? DateModel.dayCountPerRow : DateModel.maxCellCount
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Koyomi.cellIdentifier, for: indexPath) as? KoyomiCell else {
            return .init()
        }
        configure(cell, at: indexPath)
        return cell
    }
}

