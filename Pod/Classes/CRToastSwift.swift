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

/**
A NotificationController object displays a notification to the user.
*/
public class NotificationController {
    
    // MARK: - Type Definitions
    
    /**
    Predefined styles of notifications.
    
    - Info:    Blue background, ℹ️ image on the left side.
    - Success: Green background, ✅ image on the left side.
    - Warning: Yellow background, ⚠️ image on the left side.
    - Error:   Red background, ❌ image on the left side.
    */
    public enum Template {
        case Info
        case Success
        case Warning
        case Error
        private var backgroundColor: UIColor {
            get {
                switch self {
                case .Info:
                    return UIColor(red:0.176, green:0.522, blue:0.976, alpha:1.0)
                case .Success:
                    return UIColor(red:0.126, green:0.835, blue:0.163, alpha:1.0)
                case .Warning:
                    return UIColor(red:0.988, green:0.753, blue:0.170, alpha:1.0)
                case .Error:
                    return UIColor(red:0.886, green:0.211, blue:0.150, alpha:1.0)
                }
            }
        }
        private var image: UIImage? {
            get {
                let frameworkBundle = NSBundle(forClass: NotificationController.self)
                guard let resourcesBundlePath = frameworkBundle.pathForResource("CRToastSwift", ofType: "bundle") else {
                    return nil
                }
                guard let resourcesBundle = NSBundle(path: resourcesBundlePath) else {
                    return nil
                }
                switch self {
                case .Info:
                    return UIImage(named: "InfoImage", inBundle: resourcesBundle, compatibleWithTraitCollection: nil)
                case .Success:
                    return UIImage(named: "SuccessImage", inBundle: resourcesBundle, compatibleWithTraitCollection: nil)
                case .Warning:
                    return UIImage(named: "WarningImage", inBundle: resourcesBundle, compatibleWithTraitCollection: nil)
                case .Error:
                    return UIImage(named: "ErrorImage", inBundle: resourcesBundle, compatibleWithTraitCollection: nil)
                }
            }
        }
    }
    
    public typealias NotificationType       = CRToastType
    public typealias PresentationType       = CRToastPresentationType
    public typealias AnimationType          = CRToastAnimationType
    public typealias AnimationDirection     = CRToastAnimationDirection
    public typealias InteractionResponder   = CRToastInteractionResponder
    public typealias AccessoryViewAlignment = CRToastAccessoryViewAlignment
    
    // MARK: - Creating NotificationController Objects

    /**
    Initialize a notification with default values.
    Title and subtitle are set to empty values.

    - returns: Initialized notification.
    */
    public init() {
        
    }

    /**
    Initialize a notification with specified title, subtitles, and template.

    - parameter title:      Main text to be shown in the notification.
    - parameter subtitle:   Subtitle text to be shown in the notification.
    - parameter template:   A template of notification.

    - returns: Initialized notification.
    */
    public init(title: String, subtitle: String = "", template: Template? = nil) {
        self.title = title
        self.subtitle = subtitle
        if let template = template {
            self.image = template.image
            self.backgroundColor = template.backgroundColor
        }
    }

    // MARK: - Configuring Notification Title

    /// The main text to be shown in the notification.
    public var title: String = ""

    /// The text alignment for the main text.
    public var titleTextAlignment: NSTextAlignment = .Left

    /// The font for the main text.
    public var titleTextFont = UIFont.boldSystemFontOfSize(18.0)

    /// The text color for the main text. The default value is white color.
    public var titleTextColor = UIColor.whiteColor()

    /// The max number of lines of the main text.
    public var titleTextMaxNumberOfLines: Int = 0

    /// The shadow color for the main text.
    public var titleTextShadowColor: UIColor = UIColor.clearColor()

    /// The shadow offset value for the main text.
    public var titleTextShadowOffset: CGSize = CGSize(width: 0.0, height: 0.0)

    // MARK: - Configuring Notification Subtitle

    /// Subtitle text to be shown in the notification.
    public var subtitle: String = ""

    /// The text alignment for the subtitle text.
    public var subtitleTextAlignment: NSTextAlignment = .Left

    /// The font for the subtitle text.
    public var subtitleTextFont = UIFont.systemFontOfSize(14.0)

    /// The text color for the subtitle text. The default value is white color.
    public var subtitleTextColor = UIColor.whiteColor()

    /// The max number of lines of the subtitle text.
    public var subtitleTextMaxNumberOfLines: Int = 0

    /// The shadow color for the subtitle text.
    public var subtitleTextShadowColor: UIColor = UIColor.clearColor()

    /// The shadow offset value for the subtitle text.
    public var subtitleTextShadowOffset: CGSize = CGSize(width: 0.0, height: 0.0)
    
    // MARK: - Configuring Basic Appearances
    
    /// The type of the notification. Default value is `NavigationBar`.
    public var notificationType: NotificationType = .NavigationBar
    
    /// The type of presentation of the notification. Default vallue is `Cover`.
    public var presentationType: PresentationType = .Cover
    
    /// Indicates whether the notification should slide under the staus bar, leaving it visible or not. Default value is `false`.
    public var underStatusBar = false
    
    /// The status bar style for the navigation bar.
    public var statusBarStyle: UIStatusBarStyle = .Default
    
    /**
    The preferred height for the
    this will only be used when notification type is set to `Custom`.
    */
    public var preferredHeight: CGFloat = 0
    
    /**
    The general preferred padding for the notification.
    */
    public var preferredPadding: CGFloat = 0

    // MARK: - Configuring Notification Image

    /// The image to be shown on the left side of the notification(Optional).
    public var image: UIImage?
    
    /// The color to tint the image provided. If supplied, `imageWithRenderingMode:` is used with `AlwaysTemplate`.
    public var imageTintColor: UIColor? = nil
    
    // MARK: - Configuring Notification Background
    
    /// The background color of the notification.
    public var backgroundColor = UIColor.darkGrayColor()
    
    /// Custom view used as the background of the notification.
    public var backgroundView: UIView?
    
    // MARK: - Configuring Animations

    /// The animation in type for the notification. Default value is `Linear`.
    public var inAnimationType: AnimationType = .Linear

    /// The animation in direction for the notification. Default value is `Top`.
    public var inAnimationDirection: AnimationDirection = .Top

    /// The animation in time interval for the notification. Default value is 0.4.
    public var inAnimationDuration: NSTimeInterval = 0.4

    /// The animation out type for the notification. Default value is `Linear`.
    public var outAnimationType: AnimationType = .Linear

    /// The animation out direction for the notification. Default value is `Top`.
    public var outAnimationDirection: AnimationDirection = .Top
    
    /// The animation out time interval for the notification. Default value is 0.4.
    public var outAnimationDuration: NSTimeInterval = 0.4
    
    /**
    The notification presentation timeinterval of type for the notification. This is how long the notification
    will be on screen after its presentation but before its dismissal.
    */
    public var duration: NSTimeInterval = 2.0
    
    /**
    The spring damping coefficient to be used when `inAnimationType` or `outAnimationType` is set to `.Spring`. Currently you can't define separate damping for in and out.
    */
    public var animationSpringDamping: CGFloat = 0.6
    
    /**
    The initial velocity coefficient to be used when `inAnimationType` or `outAnimationType` is set to
    `.Spring`. Currently you can't define initial velocity for in and out.
    */
    public var animationSpringInitialVelocity: CGFloat = 1.0
    
    /**
    The gravity magnitude coefficient to be used when `inAnimationType` or `outAnimationType` is set to
    `.Gravity`. Currently you can't define gravity magnitude for in and out.
    */
    public var animationGravityMagnitude: CGFloat = 1.0

    // MARK: - Configuring User Interactions
    
    /**
    An array of interaction responders.
    */
    public var interactionResponders = [InteractionResponder]()
    
    /**
    An Boolean value indicating whether the notification should not be dismissed automatically and displayed until user interaction is performed.
    If `true`, `duration` will be ignored.
    */
    public var forcesUserInteraction = false
    
    // MARK: - Configuring Activity Indicator
    
    /// A Boolean value indicating whether the activity indicator is visible or not.
    public var activityIndicatorVisible = false
    
    /// An UIActivityIndicatorViewStyle value of the activity indicator.
    public var activityIndicatorViewStyle: UIActivityIndicatorViewStyle = .White
    
    /// The alignment of the activity indicator.
    public var activityIndicatorAlignment: AccessoryViewAlignment = .Left
    
    // MARK: - Identifying Notifications
    
    /// A string to identify the notification. This value is set to unique value automatically and you cannot modify it.
    public let identifier = NSUUID().UUIDString
    
    // MARK: - Other Properties
    
    /// A Boolean value indicating whether the notification should rotate automatically. Default value is `true`.
    public var rotatesAutomatically = true
    
    /// A Boolean value whether the notification captures the screen behind the default window. Default value is `true`
    public var capturesDefaultWindow = true
    
    // MARK: - Presenting And Dismissing The Notification
    
    /**
    Present the notification.
    
    - parameter completion: A completion handler to be executed at the completion of the dismissal of the notification.
    */
    public func present(completion: (() -> Void)? = nil) {
        
        guard !self.presenting else {
            print("NotificationController: The notification has been already presented.")
            return
        }

        var options = [String : AnyObject]()
        
        options[kCRToastNotificationTypeKey] = self.notificationType.rawValue
        
        options[kCRToastNotificationPreferredHeightKey] = self.preferredHeight
        options[kCRToastNotificationPreferredPaddingKey] = self.preferredPadding
        
        options[kCRToastNotificationPresentationTypeKey] = self.presentationType.rawValue
        
        options[kCRToastUnderStatusBarKey] = self.underStatusBar
        
        options[kCRToastKeepNavigationBarBorderKey] = true
        
        options[kCRToastAnimationInTypeKey] = self.inAnimationType.rawValue
        options[kCRToastAnimationInDirectionKey] = self.inAnimationDirection.rawValue
        options[kCRToastAnimationInTimeIntervalKey] = self.inAnimationDuration
        
        options[kCRToastAnimationOutTypeKey] = self.outAnimationType.rawValue
        options[kCRToastAnimationOutDirectionKey] = self.outAnimationDirection.rawValue
        options[kCRToastAnimationOutTimeIntervalKey] = self.outAnimationDuration
        
        options[kCRToastTimeIntervalKey] = self.duration
        
        options[kCRToastAnimationSpringDampingKey] = self.animationSpringDamping
        options[kCRToastAnimationSpringInitialVelocityKey] = self.animationSpringInitialVelocity
        options[kCRToastAnimationGravityMagnitudeKey] = self.animationGravityMagnitude
        
        options[kCRToastTextKey] = self.title
        options[kCRToastTextAlignmentKey] = self.titleTextAlignment.rawValue
        options[kCRToastFontKey] = self.titleTextFont
        options[kCRToastTextColorKey] = self.titleTextColor
        options[kCRToastTextMaxNumberOfLinesKey] = self.titleTextMaxNumberOfLines
        options[kCRToastTextShadowColorKey] = self.titleTextShadowColor
        options[kCRToastTextShadowOffsetKey] = NSValue(CGSize: self.titleTextShadowOffset)

        options[kCRToastSubtitleTextKey] = self.subtitle
        options[kCRToastSubtitleTextAlignmentKey] = self.subtitleTextAlignment.rawValue
        options[kCRToastSubtitleFontKey] = self.subtitleTextFont
        options[kCRToastSubtitleTextColorKey] = self.subtitleTextColor
        options[kCRToastSubtitleTextMaxNumberOfLinesKey] = self.subtitleTextMaxNumberOfLines
        options[kCRToastSubtitleTextShadowColorKey] = self.subtitleTextShadowColor
        options[kCRToastSubtitleTextShadowOffsetKey] = NSValue(CGSize: self.subtitleTextShadowOffset)
        
        options[kCRToastStatusBarStyleKey] = self.statusBarStyle.rawValue
        
        options[kCRToastBackgroundColorKey] = self.backgroundColor
        
        options[kCRToastBackgroundViewKey] = self.backgroundView
        
        if let image = self.image {
            options[kCRToastImageKey] = image
            options[kCRToastImageTintKey] = self.imageTintColor
            options[kCRToastImageAlignmentKey] = CRToastAccessoryViewAlignment.Left.rawValue
            options[kCRToastImageContentModeKey] = UIViewContentMode.Center.rawValue
        }
        
        options[kCRToastInteractionRespondersKey] = self.interactionResponders
        
        options[kCRToastShowActivityIndicatorKey] = self.activityIndicatorVisible
        if self.activityIndicatorVisible {
            options[kCRToastActivityIndicatorAlignmentKey] = self.activityIndicatorAlignment.rawValue
            options[kCRToastActivityIndicatorViewStyleKey] = self.activityIndicatorViewStyle.rawValue
        }
        
        options[kCRToastForceUserInteractionKey] = self.forcesUserInteraction
        
        options[kCRToastAutorotateKey] = self.rotatesAutomatically
        
        options[kCRToastIdentifierKey] = self.identifier
        
        options[kCRToastCaptureDefaultWindowKey] = self.capturesDefaultWindow
        
        CRToastManager.showNotificationWithOptions(options, completionBlock: completion)
        
    }
    
    /// The boolean value indicating the notification is being to be or currently presented or not.
    public var presenting: Bool {
        get {
            let identifiers = CRToastManager.notificationIdentifiersInQueue() as! [String]
            return identifiers.contains(self.identifier)
        }
    }
    
    /**
    Dismisses the notification.
    
    - parameter animated: Whether dismissal is performed animated or not.
    */
    public func dismiss(animated: Bool = true) {
        CRToastManager.dismissAllNotificationsWithIdentifier(self.identifier, animated: animated)
    }

}
