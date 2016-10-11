# Koyomi

![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)

## Demo

<p align="center">
<img src="./DemoSource/calender_demo.gif" width="300">
</p>

## Features

- Easily usable
- Simple Calender View
- [x] Support `@IBDesignable` and `@IBInspectable`.
- [x] Support Swift 2.3
- [ ] Support Swift 3.0

## Demo App

Open `Example/Koyomi.xcworkspace` and run `Koyomi-Example` to see a simple demonstration.

## QuickExample

```swift
    let koyomi = Koyomi(frame: CGRect(x: 100, y: 100, width: 250, height: 250))
    koyomi.inset = UIEdgeInsets(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5)
    view.addSubview(koyomi)
    
    // set Day and Week Label Font
    koyomi
        .setDayFont(size: 12) // or .setDayFont(fontName: ".SFUIText-Medium", size: 12)
        .setWeekFont(size: 8)
```

## Requirements

- iOS 9.0+
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
