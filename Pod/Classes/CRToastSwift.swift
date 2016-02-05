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

public func notify<Notification: NotificationType>(notification: Notification, traits: NotificationTraits = NotificationTraits(), animation: Animation = .Linear, presentationTimeInterval: NSTimeInterval? = 2.0, handler: () -> Void) -> Presentation<Notification> {
    
    // Initializing Presentation Objects and Configurings
    
    let identifier = NSUUID().UUIDString
    let presentation = Presentation<Notification>()
    let dismisser = Dismisser(identifier: identifier)
    
    var options = [String : AnyObject]()
    options[kCRToastIdentifierKey]                      = identifier
    
    // Configuring Texts
    
    options[kCRToastTextKey]                            = notification.text
    options[kCRToastTextAlignmentKey]                   = traits.textAlignment.rawValue
    options[kCRToastFontKey]                            = traits.textFont
    options[kCRToastTextColorKey]                       = colorByUnwrappingAdaptableValue(traits.textColor, forBackgroundColor: traits.backgroundColor)
    options[kCRToastTextMaxNumberOfLinesKey]            = traits.textMaxNumberOfLines
    options[kCRToastTextShadowColorKey]                 = traits.textShadowColor
    options[kCRToastTextShadowOffsetKey]                = NSValue(CGSize: traits.textShadowOffset)
    
    if notification.subtext != nil {
        options[kCRToastSubtitleTextKey]                = notification.subtext
    }
    options[kCRToastSubtitleTextAlignmentKey]           = traits.subtextAlignment.rawValue
    options[kCRToastSubtitleFontKey]                    = traits.subtextFont
    options[kCRToastSubtitleTextColorKey]               = colorByUnwrappingAdaptableValue(traits.subtextColor, forBackgroundColor: traits.backgroundColor)
    options[kCRToastSubtitleTextMaxNumberOfLinesKey]    = traits.subtextMaxNumberOfLines
    options[kCRToastSubtitleTextShadowColorKey]         = traits.subtextShadowColor
    options[kCRToastSubtitleTextShadowOffsetKey]        = NSValue(CGSize: traits.subtextShadowOffset)
    
    // Configuring Appearances
    
    options[kCRToastNotificationTypeKey]                = traits.size.crToastType.rawValue
    switch traits.size {
    case .Custom(let preferredHeight):
        options[kCRToastNotificationPreferredHeightKey] = preferredHeight
    default:
        break
    }
    
    options[kCRToastBackgroundColorKey]                 = traits.backgroundColor
    options[kCRToastBackgroundViewKey]                  = traits.backgroundView?()
    
    options[kCRToastNotificationPreferredPaddingKey]    = traits.preferredPadding
    
    options[kCRToastUnderStatusBarKey]                  = traits.showsStatusBar
    options[kCRToastStatusBarStyleKey]                  = statusBarStyleByUnwrappingAdaptableValue(traits.statusBarStyle, forBackgroundColor: traits.backgroundColor).rawValue
    
    options[kCRToastImageKey]                           = traits.image
    options[kCRToastImageTintKey]                       = traits.imageTintColor.flatMap {
        return colorByUnwrappingAdaptableValue($0, forBackgroundColor: traits.backgroundColor)
    }
    options[kCRToastImageAlignmentKey]                  = traits.imageAlignment.rawValue
    options[kCRToastImageContentModeKey]                = traits.imageContentMode.rawValue
    
    options[kCRToastShowActivityIndicatorKey]           = traits.showsActivityIndicatorView
    options[kCRToastActivityIndicatorAlignmentKey]      = traits.activityIndicatorAlignment.rawValue
    options[kCRToastActivityIndicatorViewStyleKey]      = activityIndicatorViewStyleByUnrappingAdaptableValue(traits.activityIndicatorViewStyle, forBackgroundColor: traits.backgroundColor).rawValue
    
    options[kCRToastKeepNavigationBarBorderKey]         = traits.keepsNavigationBarBorder
    
    // Configuring Other Properties
    
    options[kCRToastAutorotateKey]                      = traits.rotatesAutomatically
    options[kCRToastCaptureDefaultWindowKey]            = traits.capturesDefaultWindow
    
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
        presentation.interactionEvent.invoke((Interaction(rawValue: type.rawValue), notification, dismisser))
    })]
    
    // Presenting Notification
    
    dispatch_async(dispatch_get_main_queue()) {
        CRToastManager.showNotificationWithOptions(options, apperanceBlock: handler, completionBlock: {
            presentation.dismissalEvent.invoke(notification)
        })
    }
    
    return presentation
}
