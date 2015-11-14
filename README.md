# CRToastSwift

[![CI Status](http://img.shields.io/travis/Masahiko Tsujita/CRToastSwift.svg?style=flat)](https://travis-ci.org/Masahiko Tsujita/CRToastSwift)
[![Version](https://img.shields.io/cocoapods/v/CRToastSwift.svg?style=flat)](http://cocoapods.org/pods/CRToastSwift)
[![License](https://img.shields.io/cocoapods/l/CRToastSwift.svg?style=flat)](http://cocoapods.org/pods/CRToastSwift)
[![Platform](https://img.shields.io/cocoapods/p/CRToastSwift.svg?style=flat)](http://cocoapods.org/pods/CRToastSwift)

This is a wrapper library of CRToast.
Interfaces are redesigned to be used easily with Swift.  
Attributes gets type-safe and more simply writable.
And you no londer need to use Singleton.  
Create `NotificationController` instance, configure attirubutes and then call `present()` to show a notification.


## Usage

```swift
// Instantiate a notification controller
let notification = CRToastSwift.NotificationController(
    title: "Hello!",
    subtitle: "This is a subtitle text."
    template: .Info)
    
// Configure notification attributes
notification.titleTextAlignment = .Center
notification.inAnimationType = .Gravity
notification.outAnimationType = .Gravity
notification.duration = 3.0

// Show a notification
notification.present()
```

## Installation

CRToastSwift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CRToastSwift"
```

## License

CRToastSwift is available under the MIT license. See the LICENSE file for more info.
