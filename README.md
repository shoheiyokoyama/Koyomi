# Koyomi

<p align="center"><strong>Koyomi</strong> is a simple calendar view framework for iOS, written in Swift :calendar:</p>

![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)
[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)
[![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/sindresorhus/awesome)
[![Language](http://img.shields.io/badge/language-swift 2.3-orange.svg?style=flat
)](https://developer.apple.com/swift)
[![Language](http://img.shields.io/badge/language-swift 3.0-orange.svg?style=flat
)](https://developer.apple.com/swift)


<p align="center">
<img src="./DemoSource/sample-demo.gif" width="400">
</p>

## :octocat: Features

- Simple Calendar View :calendar:
- Easily usable :sunglasses:
- Customizable in any properties for appearance
- Selectable calender
- [x] Support `@IBDesignable` and `@IBInspectable`
- [x] Compatible with ***Carthage***
- [x] Support ***Swift 2.3***.
- [x] Support ***Swift 3.0***

### Installation of ***Swift 2.3***

Please install `swift2.3` branch.

```
pod 'Koyomi', :git => 'https://github.com/shoheiyokoyama/Koyomi', :branch => 'swift2.3'
```


## Demo App

Open `Example/Koyomi.xcworkspace` and run `Koyomi-Example` to see a simple demonstration.

## Usage

***Koyomi*** is designed to be easy to use :sunglasses:

```swift
    let frame = CGRect(x: 10, y : 20, width: 250, height: 300)
    let koyomi = Koyomi(frame: frame, sectionSpace: 1.5, cellSpace: 0.5, inset: .zero, weekCellHeight: 25)
    view.addSubview(koyomi)
```

`Koyomi` is available in Interface Builder.
Set custom class of `UICollectionView ` to `Koyomi`

```swift
    @IBOutlet weak var koyomi: Koyomi!
```

### :calendar: Change displayed month

If you want to change displayed month, call `display(in: MonthType)`. `MonthType` is defined by three types.

```swift
    public enum MonthType { case previous, current, next }
    
    // change month
    koyomi.display(in: .next)
```

### Get current month string

```swift  
    let currentDateString = koyomi.currentDateString()
```

> NOTE

> If you want to change `dateFormat ` of `currentDateString`, set argument to format. `currentDateString(withFormat: "MM/yyyy")`

> default `dateFormat ` of `currentDateString` is `M/yyyy`

### The selection state of date

You can configure ***SelectionMode*** with style.

***SelectionMode*** has nested enumerations type: `SequenceStyle`, `Style`.

```swift
    public enum SelectionMode {
        case single(style: Style), multiple(style: Style), sequence(style: SequenceStyle), none
    
        
        public enum SequenceStyle { case background, circle, semicircleEdge }
        public enum Style { case background, circle }
   }
    
    // default selectionMode is single, circle style
    public var selectionMode: SelectionMode = .single(style: .circle)
    
    // call selectionStyle
    koyomi.selectionMode = .single(style: circle)
```



 **single** |<img src="./DemoSource/single-background-mode.gif" width="130"> | <img src="./DemoSource/single-circle-mode.gif" width="130">
----  |  ----  |  ----  |
 ***SelectionMode*** |  `.single(style: .background)`  |   `.single(style: .circle)` | 
 
 
  **multiple** |<img src="./DemoSource/multiple-background-mode.gif" width="130"> | <img src="./DemoSource/multiple-circle-mode.gif" width="130">
----  |  ----  |  ----  |
 ***SelectionMode*** |  `.multiple(style: .background)`  |   `.multiple(style: .circle)` | 
 
 
  **sequence** | <img src="./DemoSource/sequence-background-mode.gif" width="130"> | <img src="./DemoSource/sequence-circle-mode.gif" width="130"> | <img src="./DemoSource/sequence-semicircleEdge-mode.gif" width="130">
----  |  ----  |  ----  | ----  |
 ***SelectionMode*** |  `.sequence(style: .background)`  |   `.sequence(style: .circle)` |  `.sequence(style: .semicircleEdge)` |

> NOTE

> If you don't want to allow user to select date by user interaction, set `selectionMode` to `.none`. 


#### Select date in programmatically

You can select specific date .
 
```swift
    let today = Date()
    let components = DateComponents()
    components.day = 7
    let weekLaterDay = Calendar.current.date(byAdding: components, toDate: today)
    koyomi.select(date: today, to: weekLaterDay)
    
    // If want to select only one day. 
    call koyomi.select(date: today)
```

You can also unselect available.

```swift
    koyomi.unselect(Date(), to: weekLaterDay) 
    // If want to unselect only one day.
    koyomi.unselect(Date())
    
    // unselect all date
    koyomi.unselectAll()
```

You can configure day color in selected state.

```swift
    // Support @IBInspectable properties
    @IBInspectable public var selectedBackgroundColor: UIColor
    @IBInspectable public var selectedTextColor: UIColor
```

## KoyomiDelegate

If you want to use `KoyomiDelegate`, set `calendarDelegate` to `target`

```swift
    koyomi.calendarDelegate = self
```

### Declaration

```swift
    optional func koyomi(_ koyomi: Koyomi, didSelect date: Date, forItemAt indexPath: IndexPath) 
```

Tells the delegate that the date at the specified index path was selected.
`date`: the date user selected, when tapped cell


```swift
   optional func koyomi(_ koyomi: Koyomi, currentDateString dateString: String)
    
    // if you want to change string format, use `currentDateFormat`
    koyomi.currentDateFormat = "M/yyyy"
```
Tells the delegate that the displayed month is changed.
`currentDateString`: the current month string, when changed month.


```swift
    optional func koyomi(_ koyomi: Koyomi, willSelectPeriod period: Int, forItemAt indexPath: IndexPath) -> Bool
    
    //　control period user selected.
    func koyomi(_ koyomi: Koyomi, willSelectPeriod period: Int, forItemAt indexPath: IndexPath) -> Bool {
        if period > 90 {
            print("More than 90 days are invalid period.")
            return false
        }
        return true
    }
```
`koyomi` calls this method before select days as period only when `selectionMode` is `sequence`.
return value: true if the item should be selected or false if it should not.

## :wrench: Customize ***Koyomi***

### Customize layout properties

```swift
    // Support @IBInspectable properties
    @IBInspectable var sectionSpace: CGFloa
    @IBInspectable var cellSpace: CGFloat
    @IBInspectable var weekCellHeight: CGFloat
    // Public property
    public var inset: UIEdgeInsets
```

<p align="center">
<img src="./DemoSource/calendar-layout.png" width="450">
</p>

```swift
    koyomi.inset = UIEdgeInsets(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5)
```

Set `sectionSpace`, `cellSpace`, `weekCellHeight` in initialization or Interface Builder.


### Customize text font

```swift
    // set Day and Week Label Font
    koyomi
        .setDayFont(size: 12) 
        .setWeekFont(size: 8)
        
    // if want to change font name, 
    setDayFont(fontName: ".SFUIText-Medium", size: 12)
 ```
 
### Customize weeks text
 
 ```swift
    koyomi.weeks = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
```

## Customize color properties

```swift
    // Support @IBInspectable properties
    @IBInspectable public var sectionSeparatorColor: UIColor
    @IBInspectable public var separatorColor: UIColor
    @IBInspectable public var weekColor: UIColor
    @IBInspectable public var weekdayColor: UIColor
    @IBInspectable public var holidayColor: UIColor
    @IBInspectable public var otherMonthColor: UIColor
    @IBInspectable public var dayBackgrondColor: UIColor
    @IBInspectable public var weekBackgrondColor: UIColor
    @IBInspectable public var selectedBackgroundColor: UIColor
    @IBInspectable public var selectedTextColor: UIColor
```

You can configure the lots of color properties for appearance :weary:

Don't worry :stuck_out_tongue_closed_eyes:, you can easily configure appearance by using `KoyomiStyle`.

```swift
    koyomi.style = .tealBlue
```

<p align="center">
<img src="./DemoSource/color-style.gif" width="300">
</p>

`KoyomiStyle` is defined by 19 types.
used [iOS Human Interface Guidelines](https://developer.apple.com/ios/human-interface-guidelines/visual-design/color/) as reference


```swift
    enum KoyomiStyle {
        // basic color style
        case monotone, standard, red, orange, yellow, tealBlue, blue, purple, green, pink
        // deep color style
        case deepBlack, deepRed, deepOrange, deepYellow, deepTealBlue, deepBlue, deepPurple, deepGreen, deepPink
    }
```

## :pencil: Requirements

- iOS 8.0+
- Xcode 8.0+
- Swift 3.0+

## :computer: Installation

### CocoaPods

Koyomi is available through [CocoaPods](http://cocoapods.org). 
To install it, simply add the following line to your `Podfile`:

```ruby
pod "Koyomi"
```

### Carthage

Add the following line to your `Cartfile`:

```ruby
github "shoheiyokoyama/Koyomi"
```

## :coffee: Author

shoheiyokoyama, shohei.yok0602@gmail.com

## :unlock: License

***Koyomi*** is available under the MIT license. See the [LICENSE file](https://github.com/shoheiyokoyama/Koyomi/blob/master/LICENSE) for more info.
