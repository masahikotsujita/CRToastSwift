//  
//  CRToastSwift.swift
//  CRToastSwift
//  
//  Copyright (c) 2015 Masahiko Tsujita <tsujitamasahiko.dev@icloud.com>
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//  

import UIKit
import CRToast

public enum HeightType {
    
    case StatusBar
    case NavigationBar
    case Custom(preferredHeight: CGFloat)
    
    var crToastType: CRToastType {
        switch self {
        case .StatusBar:
            return .StatusBar
        case .NavigationBar:
            return .NavigationBar
        case .Custom(_):
            return .Custom
        }
    }
    
}

public  typealias PresentationType       = CRToastPresentationType
public  typealias AccessoryViewAlignment = CRToastAccessoryViewAlignment
public  typealias InteractionType        = CRToastInteractionType

public class Notification {
    
    public init(text: String = "", subtext: String = "") {
        self.text = text
        self.subtext = subtext
    }
    
    public var text: String = ""
    
    public var textAlignment: NSTextAlignment = .Left
    
    public var textFont = UIFont.boldSystemFontOfSize(18.0)
    
    public var textColor = UIColor.whiteColor()
    
    public var textMaxNumberOfLines: Int = 0
    
    public var textShadowColor: UIColor = UIColor.clearColor()
    
    public var textShadowOffset: CGSize = CGSize(width: 0.0, height: 0.0)
    
    public var subtext: String = ""
    
    public var subtextAlignment: NSTextAlignment = .Left
    
    public var subtextFont = UIFont.systemFontOfSize(14.0)
    
    public var subtextColor = UIColor.whiteColor()
    
    public var subtextMaxNumberOfLines: Int = 0
    
    public var subtextShadowColor: UIColor = UIColor.clearColor()
    
    public var subtextShadowOffset: CGSize = CGSize(width: 0.0, height: 0.0)
    
    public var heightType: HeightType = .NavigationBar
    
    public var presentationType: PresentationType = .Cover
    
    public var underStatusBar = false
    
    public var statusBarStyle: UIStatusBarStyle = .Default
    
    public var preferredPadding: CGFloat = 0
    
    public var image: UIImage?
    
    public var imageTintColor: UIColor? = nil
    
    public var imageAlignment: CRToastAccessoryViewAlignment = .Left
    
    public var imageContentMode: UIViewContentMode = .Center
    
    public var backgroundColor = UIColor.darkGrayColor()
    
    public var backgroundView: UIView?
    
    public var activityIndicatorVisible = false
    
    public var activityIndicatorViewStyle: UIActivityIndicatorViewStyle = .White
    
    public var activityIndicatorAlignment: AccessoryViewAlignment = .Left
    
    public var keepsNavigationBarBorder = true
    
    public var rotatesAutomatically = true
    
    public var capturesDefaultWindow = true
    
}

public struct Animation {
    
    public  typealias AnimationType = CRToastAnimationType
    public  typealias Direction = CRToastAnimationDirection
    
    public init(inAnimation: AnimationType = .Linear, inDirection: Direction = .Top, inDuration: NSTimeInterval = 0.4, outAnimation: AnimationType = .Linear , outDirection: Direction = .Top, outDuration: NSTimeInterval = 0.4, springDamping: CGFloat = 0.6, springInitialVelocity: CGFloat = 1.0, gravityMagnitude: CGFloat = 1.0) {
        self.inType = inAnimation
        self.inDirection = inDirection
        self.inDuration = inDuration
        self.outType = outAnimation
        self.outDirection = outDirection
        self.outDuration = outDuration
        self.springDamping          = springDamping
        self.springInitialVelocity  = springInitialVelocity
        self.gravityMagnitude       = gravityMagnitude
    }
    
    public let inType: AnimationType
    
    public let inDirection: Direction
    
    public let inDuration: NSTimeInterval
    
    public let outType: AnimationType
    
    public let outDirection: Direction
    
    public let outDuration: NSTimeInterval
    
    public let springDamping: CGFloat
    
    public let springInitialVelocity: CGFloat
    
    public let gravityMagnitude: CGFloat
    
    public static let None = Animation(inDuration: 0, outDuration: 0)
    
    public static let Linear: Animation = .Linear()
    
    public static let Spring: Animation = .Spring()
    
    public static let Gravity: Animation = .Gravity()
    
    public static func Linear(inDirection inDirection: Direction = .Top, inDuration: NSTimeInterval = 0.4, outDirection: Direction = .Top, outDuration: NSTimeInterval = 0.4) -> Animation {
        return Animation(inAnimation: .Linear, inDirection: inDirection, inDuration: inDuration, outAnimation: .Linear, outDirection: outDirection, outDuration: outDuration)
    }
    
    public static func Spring(inDirection inDirection: Direction = .Top, inDuration: NSTimeInterval = 0.4, outDirection: Direction = .Top, outDuration: NSTimeInterval = 0.4, damping: CGFloat = 0.6, initialVelocity: CGFloat = 1.0) -> Animation {
        return Animation(inAnimation: .Spring, inDirection: inDirection, inDuration: inDuration, outAnimation: .Spring, outDirection: outDirection, outDuration: outDuration, springDamping: damping, springInitialVelocity: initialVelocity)
    }
    
    public static func Gravity(inDirection inDirection: Direction = .Top, inDuration: NSTimeInterval = 0.4, outDirection: Direction = .Top, outDuration: NSTimeInterval = 0.4, magnitude: CGFloat = 1.0) -> Animation {
        return Animation(inAnimation: .Gravity, inDirection: inDirection, inDuration: inDuration, outAnimation: .Gravity, outDirection: outDirection, outDuration: outDuration, gravityMagnitude: magnitude)
    }
    
}

func synchronized(lock: NSLocking, @noescape handler: () -> Void) {
    lock.lock()
    handler()
    lock.unlock()
}

class Event<T> {
    
    typealias EventHandler = (T) -> Void
    
    private var handlers = [EventHandler]()
    
    private let lock = NSLock()
    
    func addHandler(handler: EventHandler) {
        synchronized(self.lock) {
            self.handlers.append(handler)
        }
    }
    
    func invoke(value: T) {
        synchronized(self.lock) {
            self.handlers.forEach { $0(value) }
        }
    }
    
}

public final class Presentation {
    
    init() {
        
    }
    
    let dismissalEvent = Event<Notification>()
    
    public func onDismissal(handler: (Notification) -> Void) -> Self {
        self.dismissalEvent.addHandler(handler)
        return self
    }
    
    let interactionEvent = Event<(InteractionType, Notification, NotificationDismisser)>()
    
    public func onInteraction(handler: (InteractionType, Notification, NotificationDismisser) -> Void) -> Self {
        self.interactionEvent.addHandler(handler)
        return self
    }
    
    private func onInteractionOfType(type: InteractionType, handler: (Notification, NotificationDismisser) -> Void) -> Self {
        return self.onInteraction {
            if !$0.intersect(type).isEmpty {
                handler($1, $2)
            }
        }
    }
    
    public func onTapOnce(handler: (Notification, NotificationDismisser) -> Void) -> Self {
        return self.onInteractionOfType(.TapOnce, handler: handler)
    }
    
    public func onTapTwice(handler: (Notification, NotificationDismisser) -> Void) -> Self {
        return self.onInteractionOfType(.TapTwice, handler: handler)
    }
    
    public func onTwoFingerTapOnce(handler: (Notification, NotificationDismisser) -> Void) -> Self {
        return self.onInteractionOfType(.TwoFingerTapOnce, handler: handler)
    }
    
    public func onTwoFinderTapTwice(handler: (Notification, NotificationDismisser) -> Void) -> Self {
        return self.onInteractionOfType(.TwoFingerTapTwice, handler: handler)
    }
    
    public func onSwipeUp(handler: (Notification, NotificationDismisser) -> Void) -> Self {
        return self.onInteractionOfType(.SwipeUp, handler: handler)
    }
    
    public func onSwipeLeft(handler: (Notification, NotificationDismisser) -> Void) -> Self {
        return self.onInteractionOfType(.SwipeLeft, handler: handler)
    }
    
    public func onSwipeDown(handler: (Notification, NotificationDismisser) -> Void) -> Self {
        return self.onInteractionOfType(.SwipeDown, handler: handler)
    }
    
    public func onSwipeRight(handler: (Notification, NotificationDismisser) -> Void) -> Self {
        return self.onInteractionOfType(.SwipeRight, handler: handler)
    }
    
    public func onAnyTap(handler: (Notification, NotificationDismisser) -> Void) -> Self {
        return self.onInteractionOfType(.Tap, handler: handler)
    }
    
    public func onAnySwipe(handler: (Notification, NotificationDismisser) -> Void) -> Self {
        return self.onInteractionOfType(.Swipe, handler: handler)
    }
    
}

public struct NotificationDismisser {
    
    init(identifier: String) {
        self.identifier = identifier
    }
    
    let identifier: String
    
    public func dismiss(animated animated: Bool = true) {
        CRToastManager.dismissAllNotificationsWithIdentifier(identifier, animated: animated)
    }
    
}

public enum TimeInterval {
    case Finite(_: NSTimeInterval)
    case Infinite
}

public func notify(notification: Notification, animation: Animation = .Linear(), lifetime: TimeInterval = .Finite(2.0), handler: () -> Void) -> Presentation {
    
    let presentation = Presentation()
    
    let identifier = NSUUID().UUIDString
    
    let dismisser = NotificationDismisser(identifier: identifier)
    
    var options = [String : AnyObject]()
    
    // configure appearance
    
    options[kCRToastTextKey]                            = notification.text
    options[kCRToastTextAlignmentKey]                   = notification.textAlignment.rawValue
    options[kCRToastFontKey]                            = notification.textFont
    options[kCRToastTextColorKey]                       = notification.textColor
    options[kCRToastTextMaxNumberOfLinesKey]            = notification.textMaxNumberOfLines
    options[kCRToastTextShadowColorKey]                 = notification.textShadowColor
    options[kCRToastTextShadowOffsetKey]                = NSValue(CGSize: notification.textShadowOffset)
    
    options[kCRToastSubtitleTextKey]                    = notification.subtext
    options[kCRToastSubtitleTextAlignmentKey]           = notification.subtextAlignment.rawValue
    options[kCRToastSubtitleFontKey]                    = notification.subtextFont
    options[kCRToastSubtitleTextColorKey]               = notification.subtextColor
    options[kCRToastSubtitleTextMaxNumberOfLinesKey]    = notification.subtextMaxNumberOfLines
    options[kCRToastSubtitleTextShadowColorKey]         = notification.subtextShadowColor
    options[kCRToastSubtitleTextShadowOffsetKey]        = NSValue(CGSize: notification.subtextShadowOffset)
    
    options[kCRToastNotificationTypeKey]                = notification.heightType.crToastType.rawValue
    switch notification.heightType {
    case .Custom(let preferredHeight):
        options[kCRToastNotificationPreferredHeightKey] = preferredHeight
    default:
        break
    }
    
    options[kCRToastNotificationPreferredPaddingKey]    = notification.preferredPadding
    
    options[kCRToastNotificationPresentationTypeKey]    = notification.presentationType.rawValue
    
    options[kCRToastUnderStatusBarKey]                  = notification.underStatusBar
    
    options[kCRToastKeepNavigationBarBorderKey]         = notification.keepsNavigationBarBorder
    
    options[kCRToastStatusBarStyleKey]                  = notification.statusBarStyle.rawValue
    
    options[kCRToastBackgroundColorKey]                 = notification.backgroundColor
    
    options[kCRToastBackgroundViewKey]                  = notification.backgroundView
    
    options[kCRToastImageKey]                           = notification.image
    options[kCRToastImageTintKey]                       = notification.imageTintColor
    options[kCRToastImageAlignmentKey]                  = notification.imageAlignment.rawValue
    options[kCRToastImageContentModeKey]                = notification.imageContentMode.rawValue
    
    options[kCRToastShowActivityIndicatorKey]           = notification.activityIndicatorVisible
    options[kCRToastActivityIndicatorAlignmentKey]      = notification.activityIndicatorAlignment.rawValue
    options[kCRToastActivityIndicatorViewStyleKey]      = notification.activityIndicatorViewStyle.rawValue
    
    options[kCRToastAutorotateKey]                      = notification.rotatesAutomatically
    
    options[kCRToastIdentifierKey]                      = identifier
    
    options[kCRToastCaptureDefaultWindowKey]            = notification.capturesDefaultWindow
    
    // configure animations
    
    options[kCRToastAnimationInTypeKey]                 = animation.inType.rawValue
    options[kCRToastAnimationInDirectionKey]            = animation.inDirection.rawValue
    options[kCRToastAnimationInTimeIntervalKey]         = animation.inDuration
    
    options[kCRToastAnimationOutTypeKey]                = animation.outType.rawValue
    options[kCRToastAnimationOutDirectionKey]           = animation.outDirection.rawValue
    options[kCRToastAnimationOutTimeIntervalKey]        = animation.outDuration
    
    options[kCRToastAnimationSpringDampingKey]          = animation.springDamping
    options[kCRToastAnimationSpringInitialVelocityKey]  = animation.springInitialVelocity
    options[kCRToastAnimationGravityMagnitudeKey]       = animation.gravityMagnitude
    
    // configure interactions
    
    switch lifetime {
    case .Finite(let timeInterval):
        options[kCRToastForceUserInteractionKey]        = false
        options[kCRToastTimeIntervalKey]                = timeInterval
    case .Infinite:
        options[kCRToastForceUserInteractionKey]        = true
    }
    
    options[kCRToastInteractionRespondersKey]           = [CRToastInteractionResponder(interactionType: .All, automaticallyDismiss: false, block: { type in
        presentation.interactionEvent.invoke((type, notification, dismisser))
    })]
    
    // show notification
    
    dispatch_async(dispatch_get_main_queue()) {
        CRToastManager.showNotificationWithOptions(options, apperanceBlock: handler, completionBlock: {
            presentation.dismissalEvent.invoke(notification)
        })
    }
    
    return presentation
}
