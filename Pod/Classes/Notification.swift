//
//  Notification.swift
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

public typealias AccessoryViewAlignment = CRToastAccessoryViewAlignment

public protocol NotificationType {

    var text: String { get }

    var textAlignment: NSTextAlignment { get }

    var textFont: UIFont { get }

    var textColor: UIColor { get }

    var textMaxNumberOfLines: Int { get }

    var textShadowColor: UIColor { get }

    var textShadowOffset: CGSize { get }

    var subtext: String? { get }

    var subtextAlignment: NSTextAlignment { get }

    var subtextFont: UIFont { get }

    var subtextColor: UIColor { get }

    var subtextMaxNumberOfLines: Int { get }

    var subtextShadowColor: UIColor { get }

    var subtextShadowOffset: CGSize { get }

    var heightType: HeightType { get }

    var underStatusBar: Bool { get }

    var statusBarStyle: UIStatusBarStyle { get }

    var preferredPadding: CGFloat { get }

    var image: UIImage? { get }

    var imageTintColor: UIColor? { get }

    var imageAlignment: CRToastAccessoryViewAlignment { get }

    var imageContentMode: UIViewContentMode { get }

    var backgroundColor: UIColor { get }

    var backgroundView: UIView? { get }

    var activityIndicatorVisible: Bool { get }

    var activityIndicatorViewStyle: UIActivityIndicatorViewStyle { get }

    var activityIndicatorAlignment: AccessoryViewAlignment { get }

    var keepsNavigationBarBorder: Bool { get }

    var rotatesAutomatically: Bool { get }

    var capturesDefaultWindow: Bool { get }

}

public class Notification: NotificationType {
    
    public init(text: String = "", subtext: String? = nil) {
        self.text       = text
        self.subtext    = subtext
    }
    
    public var text: String = ""
    
    public var textAlignment: NSTextAlignment = .Left
    
    public var textFont = UIFont.boldSystemFontOfSize(18.0)
    
    public var textColor = UIColor.whiteColor()
    
    public var textMaxNumberOfLines: Int = 0
    
    public var textShadowColor: UIColor = UIColor.clearColor()
    
    public var textShadowOffset: CGSize = CGSize(width: 0.0, height: 0.0)
    
    public var subtext: String?
    
    public var subtextAlignment: NSTextAlignment = .Left
    
    public var subtextFont = UIFont.systemFontOfSize(14.0)
    
    public var subtextColor = UIColor.whiteColor()
    
    public var subtextMaxNumberOfLines: Int = 0
    
    public var subtextShadowColor: UIColor = UIColor.clearColor()
    
    public var subtextShadowOffset: CGSize = CGSize(width: 0.0, height: 0.0)
    
    public var heightType: HeightType = .NavigationBar
    
    public var underStatusBar = false
    
    public var statusBarStyle: UIStatusBarStyle = .Default
    
    public var preferredPadding: CGFloat = 0
    
    public var image: UIImage?
    
    public var imageTintColor: UIColor?
    
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

public extension NotificationType {
    
    public func notify(animation: Animation = .Linear, lifetime: TimeInterval = .Finite(2.0), handler: () -> Void) -> Presentation<Self> {
        
        // Initializing Presentation Objects and Configurings
        
        let identifier = NSUUID().UUIDString
        let presentation = Presentation(notification: self)
        let dismisser = NotificationDismisser(identifier: identifier)
        
        var options = [String : AnyObject]()
        options[kCRToastIdentifierKey]                      = identifier
        
        // Configuring Texts
        
        options[kCRToastTextKey]                            = self.text
        options[kCRToastTextAlignmentKey]                   = self.textAlignment.rawValue
        options[kCRToastFontKey]                            = self.textFont
        options[kCRToastTextColorKey]                       = self.textColor
        options[kCRToastTextMaxNumberOfLinesKey]            = self.textMaxNumberOfLines
        options[kCRToastTextShadowColorKey]                 = self.textShadowColor
        options[kCRToastTextShadowOffsetKey]                = NSValue(CGSize: self.textShadowOffset)
        
        if self.subtext != nil {
            options[kCRToastSubtitleTextKey]                = self.subtext
        }
        options[kCRToastSubtitleTextAlignmentKey]           = self.subtextAlignment.rawValue
        options[kCRToastSubtitleFontKey]                    = self.subtextFont
        options[kCRToastSubtitleTextColorKey]               = self.subtextColor
        options[kCRToastSubtitleTextMaxNumberOfLinesKey]    = self.subtextMaxNumberOfLines
        options[kCRToastSubtitleTextShadowColorKey]         = self.subtextShadowColor
        options[kCRToastSubtitleTextShadowOffsetKey]        = NSValue(CGSize: self.subtextShadowOffset)
        
        // Configuring Appearances
        
        options[kCRToastNotificationTypeKey]                = self.heightType.crToastType.rawValue
        switch self.heightType {
        case .Custom(let preferredHeight):
            options[kCRToastNotificationPreferredHeightKey] = preferredHeight
        default:
            break
        }
        
        options[kCRToastBackgroundColorKey]                 = self.backgroundColor
        options[kCRToastBackgroundViewKey]                  = self.backgroundView
        
        options[kCRToastNotificationPreferredPaddingKey]    = self.preferredPadding
        
        options[kCRToastUnderStatusBarKey]                  = self.underStatusBar
        options[kCRToastStatusBarStyleKey]                  = self.statusBarStyle.rawValue
        
        options[kCRToastImageKey]                           = self.image
        options[kCRToastImageTintKey]                       = self.imageTintColor
        options[kCRToastImageAlignmentKey]                  = self.imageAlignment.rawValue
        options[kCRToastImageContentModeKey]                = self.imageContentMode.rawValue
        
        options[kCRToastShowActivityIndicatorKey]           = self.activityIndicatorVisible
        options[kCRToastActivityIndicatorAlignmentKey]      = self.activityIndicatorAlignment.rawValue
        options[kCRToastActivityIndicatorViewStyleKey]      = self.activityIndicatorViewStyle.rawValue
        
        options[kCRToastKeepNavigationBarBorderKey]         = self.keepsNavigationBarBorder
        
        // Configuring Other Properties
        
        options[kCRToastAutorotateKey]                      = self.rotatesAutomatically
        options[kCRToastCaptureDefaultWindowKey]            = self.capturesDefaultWindow
        
        // Configuring Animations
        
        options[kCRToastAnimationInTypeKey]                 = animation.inType.rawValue
        options[kCRToastAnimationInDirectionKey]            = animation.inDirection.rawValue
        options[kCRToastAnimationInTimeIntervalKey]         = animation.inDuration
        
        options[kCRToastAnimationOutTypeKey]                = animation.outType.rawValue
        options[kCRToastAnimationOutDirectionKey]           = animation.outDirection.rawValue
        options[kCRToastAnimationOutTimeIntervalKey]        = animation.outDuration
        
        options[kCRToastAnimationSpringDampingKey]          = animation.springDamping
        options[kCRToastAnimationSpringInitialVelocityKey]  = animation.springInitialVelocity
        options[kCRToastAnimationGravityMagnitudeKey]       = animation.gravityMagnitude
        
        options[kCRToastNotificationPresentationTypeKey]    = animation.presentationType.rawValue
        
        // Configuring User Interactions
        
        switch lifetime {
        case .Finite(let timeInterval):
            options[kCRToastForceUserInteractionKey]        = false
            options[kCRToastTimeIntervalKey]                = timeInterval
        case .Infinite:
            options[kCRToastForceUserInteractionKey]        = true
        }
        
        options[kCRToastInteractionRespondersKey]           = [CRToastInteractionResponder(interactionType: .All, automaticallyDismiss: false, block: { type in
            presentation.interactionEvent.invoke((type, self, dismisser))
        })]
        
        // Presenting Notification
        
        dispatch_async(dispatch_get_main_queue()) {
            CRToastManager.showNotificationWithOptions(options, apperanceBlock: handler, completionBlock: {
                presentation.dismissalEvent.invoke(self)
            })
        }
        
        return presentation
    }
    
}
