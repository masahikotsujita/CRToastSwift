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

public func notify<Notification: NotificationConvertible>(notificationConvertible: Notification, animation: Animation = .Linear, presentationTimeInterval: NSTimeInterval? = 2.0, handler: () -> Void) -> Presentation<Notification> {
    
    let notification = notificationConvertible.notification
    
    // Initializing Presentation Objects and Configurings
    
    let identifier = NSUUID().UUIDString
    let presentation = Presentation<Notification>()
    let dismisser = Dismisser(identifier: identifier)
    
    var options = [String : AnyObject]()
    options[kCRToastIdentifierKey]                      = identifier
    
    // Configuring Texts
    
    options[kCRToastTextKey]                            = notification.text
    options[kCRToastTextAlignmentKey]                   = notification.textAlignment.rawValue
    options[kCRToastFontKey]                            = notification.textFont
    options[kCRToastTextColorKey]                       = colorByUnwrappingAdaptableValue(notification.textColor, forBackgroundColor: notification.backgroundColor)
    options[kCRToastTextMaxNumberOfLinesKey]            = notification.textMaxNumberOfLines
    options[kCRToastTextShadowColorKey]                 = notification.textShadowColor
    options[kCRToastTextShadowOffsetKey]                = NSValue(CGSize: notification.textShadowOffset)
    
    if notification.subtext != nil {
        options[kCRToastSubtitleTextKey]                = notification.subtext
    }
    options[kCRToastSubtitleTextAlignmentKey]           = notification.subtextAlignment.rawValue
    options[kCRToastSubtitleFontKey]                    = notification.subtextFont
    options[kCRToastSubtitleTextColorKey]               = colorByUnwrappingAdaptableValue(notification.subtextColor, forBackgroundColor: notification.backgroundColor)
    options[kCRToastSubtitleTextMaxNumberOfLinesKey]    = notification.subtextMaxNumberOfLines
    options[kCRToastSubtitleTextShadowColorKey]         = notification.subtextShadowColor
    options[kCRToastSubtitleTextShadowOffsetKey]        = NSValue(CGSize: notification.subtextShadowOffset)
    
    // Configuring Appearances
    
    options[kCRToastNotificationTypeKey]                = notification.size.crToastType.rawValue
    switch notification.size {
    case .Custom(let preferredHeight):
        options[kCRToastNotificationPreferredHeightKey] = preferredHeight
    default:
        break
    }
    
    options[kCRToastBackgroundColorKey]                 = notification.backgroundColor
    options[kCRToastBackgroundViewKey]                  = notification.backgroundView?()
    
    options[kCRToastNotificationPreferredPaddingKey]    = notification.preferredPadding
    
    options[kCRToastUnderStatusBarKey]                  = notification.showsStatusBar
    options[kCRToastStatusBarStyleKey]                  = statusBarStyleByUnwrappingAdaptableValue(notification.statusBarStyle, forBackgroundColor: notification.backgroundColor).rawValue
    
    options[kCRToastImageKey]                           = notification.image
    options[kCRToastImageTintKey]                       = notification.imageTintColor.flatMap {
        return colorByUnwrappingAdaptableValue($0, forBackgroundColor: notification.backgroundColor)
    }
    options[kCRToastImageAlignmentKey]                  = notification.imageAlignment.rawValue
    options[kCRToastImageContentModeKey]                = notification.imageContentMode.rawValue
    
    options[kCRToastShowActivityIndicatorKey]           = notification.showsActivityIndicatorView
    options[kCRToastActivityIndicatorAlignmentKey]      = notification.activityIndicatorAlignment.rawValue
    options[kCRToastActivityIndicatorViewStyleKey]      = activityIndicatorViewStyleByUnrappingAdaptableValue(notification.activityIndicatorViewStyle, forBackgroundColor: notification.backgroundColor).rawValue
    
    options[kCRToastKeepNavigationBarBorderKey]         = notification.keepsNavigationBarBorder
    
    // Configuring Other Properties
    
    options[kCRToastAutorotateKey]                      = notification.rotatesAutomatically
    options[kCRToastCaptureDefaultWindowKey]            = notification.capturesDefaultWindow
    
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
    
    if let presentationTimeInterval = presentationTimeInterval {
        options[kCRToastForceUserInteractionKey]        = false
        options[kCRToastTimeIntervalKey]                = presentationTimeInterval
    } else {
        options[kCRToastForceUserInteractionKey]        = true
    }
    
    options[kCRToastInteractionRespondersKey]           = [CRToastInteractionResponder(interactionType: .All, automaticallyDismiss: false, block: { type in
        presentation.interactionEvent.invoke((type, notificationConvertible, dismisser))
    })]
    
    // Presenting Notification
    
    dispatch_async(dispatch_get_main_queue()) {
        CRToastManager.showNotificationWithOptions(options, apperanceBlock: handler, completionBlock: {
            presentation.dismissalEvent.invoke(notificationConvertible)
        })
    }
    
    return presentation
}
