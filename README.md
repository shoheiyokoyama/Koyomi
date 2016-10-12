# Koyomi

![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)

**Koyomi** is a simple calender view framework for iOS, written in Swift :calendar:

## Demo

<p align="center">
<img src="./DemoSource/calender_demo.gif" width="300">
</p>

## Features

- Easily usable :sunglasses:
- Simple Calender View :calendar:
- Customizable in any properties for appearance
- [x] Support `@IBDesignable` and `@IBInspectable`
- [x] Support Swift 2.3
- [ ] Support Swift 3.0

## Demo App

Open `Example/Koyomi.xcworkspace` and run `Koyomi-Example` to see a simple demonstration.

## Quick Example

Koyomi is designed to be easy to use

```swift
    let koyomi = Koyomi(frame: CGRect(x: 100, y: 100, width: 250, height: 250))
    // padding for Calender
    koyomi.inset = UIEdgeInsets(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5)
    
    // set weeks text
    koyomi.weeks = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    // set Day and Week Label Font
    koyomi
        .setDayFont(size: 12) 
        .setWeekFont(size: 8)
      
    // if want to change font name, use: 
    // setDayFont(fontName: ".SFUIText-Medium", size: 12)
        
    view.addSubview(koyomi)
    
    // change month
    koyomi.display(in: .next)
    
    // get current month string
    let currentDateString = koyomi.currentDateString
```

## KoyomiDelegate

```swift
    // Called when tapped cell
    optional func koyomi(_ koyomi: Koyomi, didSelect date: NSDate, forItemAt indexPath: NSIndexPath)
```

## Customize properties

```swift
    // Customize layout
    @IBInspectable var sectionSpace: CGFloa
    @IBInspectable var cellSpace: CGFloat
    @IBInspectable var weekCellHeight: CGFloat
    public var inset: UIEdgeInsets
    
    // Customize color
    @IBInspectable public var sectionSeparatorColor: UIColor
    @IBInspectable public var separatorColor: UIColor
    @IBInspectable public var weekColor: UIColor
    @IBInspectable public var weekdayColor: UIColor
    @IBInspectable public var holidayColor: UIColor
    @IBInspectable public var otherMonthColor: UIColor
    @IBInspectable public var dayBackgrondColor: UIColor
    @IBInspectable public var weekBackgrondColor: UIColor
```

## Requirements

- iOS 8.0+
- Xcode 8.0+

## Installation
Koyomi is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "Koyomi"
```

## Author

shoheiyokoyama, shohei.yok0602@gmail.com

## License

***Koyomi*** is available under the MIT license. See the [LICENSE file](https://github.com/shoheiyokoyama/Koyomi/blob/master/LICENSE) for more info.
