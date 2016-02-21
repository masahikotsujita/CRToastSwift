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

import Foundation
import CRToast

public func presentNotification<Notification: NotificationType, Context: NotificationPresentationContextType where Notification == Context.Notification>(notification: Notification, context: Context, animation: Animation = .Linear, presentationDuration: NSTimeInterval? = nil, presentationHandler: ((Notification, NotificationDismisser<Notification>) -> Void)? = nil) -> NotificationPresentation<Notification> {
    
    let traits = context.traitsForNotification(notification)
    
    // Initializing Presentation Objects and Configurings

    let identifier = NSUUID().UUIDString
    let presentation = NotificationPresentation<Notification>(identifier: identifier)
    let dismisser = NotificationDismisser(presentation: presentation)

    var options = [String : AnyObject]()
    options[kCRToastIdentifierKey]                      = identifier

    // Configuring Texts

    options[kCRToastTextKey]                            = notification.text
    options[kCRToastTextAlignmentKey]                   = traits.textAlignment.rawValue
    options[kCRToastFontKey]                            = traits.textFont
    options[kCRToastTextColorKey]                       = traits.textColor
    options[kCRToastTextMaxNumberOfLinesKey]            = traits.textMaxNumberOfLines
    options[kCRToastTextShadowColorKey]                 = traits.textShadowColor
    options[kCRToastTextShadowOffsetKey]                = NSValue(CGSize: traits.textShadowOffset)

    if notification.subtext != nil {
        options[kCRToastSubtitleTextKey]                = notification.subtext
    }
    options[kCRToastSubtitleTextAlignmentKey]           = traits.subtextAlignment.rawValue
    options[kCRToastSubtitleFontKey]                    = traits.subtextFont
    options[kCRToastSubtitleTextColorKey]               = traits.subtextColor
    options[kCRToastSubtitleTextMaxNumberOfLinesKey]    = traits.subtextMaxNumberOfLines
    options[kCRToastSubtitleTextShadowColorKey]         = traits.subtextShadowColor
    options[kCRToastSubtitleTextShadowOffsetKey]        = NSValue(CGSize: traits.subtextShadowOffset)

    // Configuring Appearances

    options[kCRToastNotificationTypeKey]                = CRToastType(notificationSize: traits.size).rawValue
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
    options[kCRToastStatusBarStyleKey]                  = traits.statusBarStyle.rawValue

    options[kCRToastImageKey]                           = traits.image
    options[kCRToastImageTintKey]                       = traits.imageTintColor

    options[kCRToastImageAlignmentKey]                  = traits.imageAlignment.rawValue
    options[kCRToastImageContentModeKey]                = traits.imageContentMode.rawValue

    options[kCRToastShowActivityIndicatorKey]           = traits.showsActivityIndicatorView
    options[kCRToastActivityIndicatorAlignmentKey]      = traits.activityIndicatorAlignment.rawValue
    options[kCRToastActivityIndicatorViewStyleKey]      = traits.activityIndicatorViewStyle.rawValue

    options[kCRToastKeepNavigationBarBorderKey]         = traits.keepsNavigationBarBorder

    // Configuring Other Properties

    options[kCRToastAutorotateKey]                      = traits.rotatesAutomatically
    options[kCRToastCaptureDefaultWindowKey]            = traits.capturesDefaultWindow

    // Configuring Animations

    options[kCRToastAnimationInTypeKey]                 = animation.inCurve.rawValue
    options[kCRToastAnimationInDirectionKey]            = animation.inDirection.rawValue
    options[kCRToastAnimationInTimeIntervalKey]         = animation.inDuration

    options[kCRToastAnimationOutTypeKey]                = animation.outCurve.rawValue
    options[kCRToastAnimationOutDirectionKey]           = animation.outDirection.rawValue
    options[kCRToastAnimationOutTimeIntervalKey]        = animation.outDuration

    options[kCRToastAnimationSpringDampingKey]          = animation.springDamping
    options[kCRToastAnimationSpringInitialVelocityKey]  = animation.springInitialVelocity
    options[kCRToastAnimationGravityMagnitudeKey]       = animation.gravityMagnitude

    options[kCRToastNotificationPresentationTypeKey]    = animation.backgroundHidingStyle.rawValue

    // Configuring User Interactions

    if let presentationDuration = presentationDuration {
        options[kCRToastForceUserInteractionKey]        = false
        options[kCRToastTimeIntervalKey]                = presentationDuration
    } else {
        options[kCRToastForceUserInteractionKey]        = true
    }

    options[kCRToastInteractionRespondersKey]           = [CRToastInteractionResponder(interactionType: .All, automaticallyDismiss: false, block: { userInteraction in
        presentation.userInteractionSignal.send((notification, UserInteraction(rawValue: userInteraction.rawValue), dismisser))
    })]

    // Presenting Notification

    dispatch_async(dispatch_get_main_queue()) {
        CRToastManager.showNotificationWithOptions(options, apperanceBlock: {
            presentationHandler?(notification, dismisser)
        }, completionBlock: {
            presentation.dismissalSignal.send(notification)
        })
    }

    return presentation
}
