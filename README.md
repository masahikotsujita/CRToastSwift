# CRToastSwift

[![CI Status](http://img.shields.io/travis/Masahiko Tsujita/CRToastSwift.svg?style=flat)](https://travis-ci.org/masahiko24/CRToastSwift)
[![Version](https://img.shields.io/cocoapods/v/CRToastSwift.svg?style=flat)](http://cocoapods.org/pods/CRToastSwift)
[![License](https://img.shields.io/cocoapods/l/CRToastSwift.svg?style=flat)](http://cocoapods.org/pods/CRToastSwift)
[![Platform](https://img.shields.io/cocoapods/p/CRToastSwift.svg?style=flat)](http://cocoapods.org/pods/CRToastSwift)

A wrapper library of [CRToast](https://github.com/cruffenach/CRToast) totally redesigned for Swift 2.

## Features
- Awesome UX based on CRToast
- Carefully considered, highly structured and Swiftish API
- Strongly typed properties
- Flowable event handlings by method chaining and trailing closures
- Easy customization for your applications

## Requirements
- Xcode 7 and later
- CRToast 0.0.9 and later

## Installation

CRToastSwift is available through [Carthage](https://github.com/Carthage/Carthage).
To install, 

```
github "masahiko24/CRToastSwift"
```

CRToastSwift also is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CRToastSwift"
```

## Usage

### 1. Define custom notification type (Optional)
First, define your notification type conforming `NotificationType` protocol.  
It requires two text properties:

```swift
public protocol NotificationType {
    
    var text: String { get }
    
    var subtext: String? { get }
    
}
```

There are two predefined types conforming to `NotificationType` - `Notification` and `String`.  
`Notification` is a simple notification with two required text properties with given parameters on initialization.  
`String` also conforms to the protocol. It provides itself for `text` and always `nil` for `subtext`.
If these types are enough for you, you do not have to define custom notification types.

### 2. Conform to `PresentationContextType` protocol

`PresentationContextType` is a context which notifications are presented.  
You can customize apparances and behaviors of notifications as follows:

```swift
class MyContext :PresentationContextType {
    
	func attributesForNotification(notification: Notification) -> NotificationAttributeCollection {
		var attributes = NotificationAttributeCollection()
		attributes.image = UIImage(named: "Error")
		attributes.backgroundColor = .redColor()
		attributes.showsStatusBar = true
		return attributes
	}
    
}
```

### 3. Present notifications and handle events

You can present notifications by calling `Presenter.present()` and handle events using method chaining:

```swift
Presenter.present("Hello, world", context: context) { (notification, _) in
	// Handling presentation
	print("\(notification) was presented.")
} .on(.Tap) { (notification, _, dismisser) in
	// Handling users tap
	print("\(notification) was tapped.")
	
	// You can dismiss the notification on user interaction using dismisser
	dismisser.dismiss { notification in
		// Handling dismissal by specific user interaction
		print("\(notification) was dismissed by tap.")
	}
} .onDismissal { notification in
	// Handling dismissal
	print("\(notification) was dismissed.")
}
```

#### Configuring animations

You can specify animations on presentation as follows:

```swift
Presenter.present(..., animation: .Gravity) ...
```

`animation` can take an instance of `Animation`.
There are three predefined animation values: `Linear`, `Spring`, and `Gravity`.  

```swift
public struct Animation {
	public static let Linear: Animation
	public static let Spring: Animation
	public static let Gravity: Animation
}
```

#### Configuring presentation durations

You can also specify how long the notification will be presented:

```swift
Presenter.present(..., duration: 5.0) ...
```

You can specify `nil` for `duration`. Then the notification will not be dismissed automatically, so you have to dismiss the notification manually using `dismisser` given as a parameter of handlers of presentation or user interactions.

## License

CRToastSwift is available under the MIT license. See the LICENSE file for more info.
