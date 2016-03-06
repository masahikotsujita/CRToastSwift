//
//  NotificationPresenter.swift
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

public class NotificationPresenter {
    
    public init() {
        
    }
    
    public func presentNotification<Notification: NotificationType, Context: NotificationPresentationContextType where Notification == Context.Notification>(notification: Notification, context: Context, animation: Animation = .Linear, presentationDuration: NSTimeInterval? = 2.0, presentationHandler: ((Notification, NotificationDismisser<Notification>) -> Void)? = nil) -> NotificationPresentation<Notification> {
        
        // Initializing variables and constants
        
        let attributes = context.attributesForNotification(notification)
        let identifier = NSUUID().UUIDString
        let presentation = NotificationPresentation<Notification>(identifier: identifier)
        let dismisser = NotificationDismisser(presentation: presentation)
        var options = [String : AnyObject]()
        
        // ID
        
        options[kCRToastIdentifierKey]                      = identifier
        
        // Configuring Texts
        
        options[kCRToastTextKey]                            = notification.text
        options[kCRToastTextAlignmentKey]                   = attributes.textAlignment.rawValue
        options[kCRToastFontKey]                            = attributes.textFont
        options[kCRToastTextColorKey]                       = attributes.textColor
        options[kCRToastTextMaxNumberOfLinesKey]            = attributes.textMaxNumberOfLines
        options[kCRToastTextShadowColorKey]                 = attributes.textShadowColor
        options[kCRToastTextShadowOffsetKey]                = NSValue(CGSize: attributes.textShadowOffset)
        
        if notification.subtext != nil {
            options[kCRToastSubtitleTextKey]                = notification.subtext
        }
        options[kCRToastSubtitleTextAlignmentKey]           = attributes.subtextAlignment.rawValue
        options[kCRToastSubtitleFontKey]                    = attributes.subtextFont
        options[kCRToastSubtitleTextColorKey]               = attributes.subtextColor
        options[kCRToastSubtitleTextMaxNumberOfLinesKey]    = attributes.subtextMaxNumberOfLines
        options[kCRToastSubtitleTextShadowColorKey]         = attributes.subtextShadowColor
        options[kCRToastSubtitleTextShadowOffsetKey]        = NSValue(CGSize: attributes.subtextShadowOffset)
        
        // Configuring Appearances
        
        options[kCRToastNotificationTypeKey]                = CRToastType(notificationSize: attributes.size).rawValue
        switch attributes.size {
        case .Custom(let preferredHeight):
            options[kCRToastNotificationPreferredHeightKey] = preferredHeight
        default:
            break
        }
        
        options[kCRToastBackgroundColorKey]                 = attributes.backgroundColor
        options[kCRToastBackgroundViewKey]                  = attributes.backgroundView?()
        
        options[kCRToastNotificationPreferredPaddingKey]    = attributes.preferredPadding
        
        options[kCRToastUnderStatusBarKey]                  = attributes.showsStatusBar
        options[kCRToastStatusBarStyleKey]                  = attributes.statusBarStyle.rawValue
        
        options[kCRToastImageKey]                           = attributes.image
        options[kCRToastImageTintKey]                       = attributes.imageTintColor
        
        options[kCRToastImageAlignmentKey]                  = attributes.imageAlignment.rawValue
        options[kCRToastImageContentModeKey]                = attributes.imageContentMode.rawValue
        
        options[kCRToastShowActivityIndicatorKey]           = attributes.showsActivityIndicatorView
        options[kCRToastActivityIndicatorAlignmentKey]      = attributes.activityIndicatorAlignment.rawValue
        options[kCRToastActivityIndicatorViewStyleKey]      = attributes.activityIndicatorViewStyle.rawValue
        
        options[kCRToastKeepNavigationBarBorderKey]         = attributes.keepsNavigationBarBorder
        
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
        
        // Others
        
        options[kCRToastAutorotateKey]                      = attributes.rotatesAutomatically
        options[kCRToastCaptureDefaultWindowKey]            = attributes.capturesDefaultWindow
        
        // Presenting Notification
        
        if let presentationHandler = presentationHandler {
            presentation.onPresented(presentationHandler)
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            CRToastManager.showNotificationWithOptions(options, apperanceBlock: {
                presentation.presentationSignal.send(notification, dismisser)
                }, completionBlock: {
                    presentation.dismissalSignal.send(notification)
            })
        }
        
        return presentation
    }
    
    public static let sharedPresenter = NotificationPresenter()
    
    public static func presentNotification<Notification: NotificationType, Context: NotificationPresentationContextType where Notification == Context.Notification>(notification: Notification, context: Context, animation: Animation = .Linear, presentationDuration: NSTimeInterval? = 2.0, presentationHandler: ((Notification, NotificationDismisser<Notification>) -> Void)? = nil) -> NotificationPresentation<Notification> {
        return self.sharedPresenter.presentNotification(notification, context: context, animation: animation, presentationDuration: presentationDuration, presentationHandler: presentationHandler)
    }
    
    public static func presentNotification<Notification: NotificationType>(notification: Notification, animation: Animation = .Linear, presentationDuration: NSTimeInterval? = 2.0, presentationHandler: ((Notification, NotificationDismisser<Notification>) -> Void)? = nil) -> NotificationPresentation<Notification> {
        return self.sharedPresenter.presentNotification(notification, context: NotificationPresentationContext { _ in NotificationAttributeCollection() }, animation: animation, presentationDuration: presentationDuration, presentationHandler: presentationHandler)
    }
    
}
