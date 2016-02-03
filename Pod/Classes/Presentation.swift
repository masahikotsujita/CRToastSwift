//
//  Presentation.swift
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

public struct InteractionType: OptionSetType {
    
    public typealias RawValue = CRToastInteractionType.RawValue
    
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    public let rawValue: RawValue
    
    public static let Tap                   = InteractionType(rawValue: CRToastInteractionType.TapOnce.rawValue)
    public static let DoubleTap             = InteractionType(rawValue: CRToastInteractionType.TapTwice.rawValue)
    public static let TwoFingerTap          = InteractionType(rawValue: CRToastInteractionType.TwoFingerTapOnce.rawValue)
    public static let TwoFingerDoubleTap    = InteractionType(rawValue: CRToastInteractionType.TwoFingerTapTwice.rawValue)
    
    public static let SwipeUp               = InteractionType(rawValue: CRToastInteractionType.SwipeUp.rawValue)
    public static let SwipeLeft             = InteractionType(rawValue: CRToastInteractionType.SwipeLeft.rawValue)
    public static let SwipeDown             = InteractionType(rawValue: CRToastInteractionType.SwipeDown.rawValue)
    public static let SwipeRight            = InteractionType(rawValue: CRToastInteractionType.SwipeRight.rawValue)
    
    public static let AnyTap                = InteractionType(rawValue: CRToastInteractionType.Tap.rawValue)
    public static let AnySwipe              = InteractionType(rawValue: CRToastInteractionType.Swipe.rawValue)
    public static let Any                   = InteractionType(rawValue: CRToastInteractionType.All.rawValue)
    
    var crToastInteractionType: CRToastInteractionType {
        return CRToastInteractionType(rawValue: self.rawValue)
    }
    
}

public final class Presentation<Notification: NotificationConvertible> {
    
    let interactionEvent = Event<(InteractionType, Notification, Dismisser)>()
    
    public func on(interaction: InteractionType, handler: (Notification, Dismisser) -> Void) -> Self {
        self.interactionEvent.addHandler({ (occurredInteraction, notification, dismisser) in
            if !(occurredInteraction.intersect(interaction).isEmpty) {
                handler(notification, dismisser)
            }
        })
        return self
    }
    
    let dismissalEvent = Event<Notification>()
    
    public func onDismissal(handler: (Notification) -> Void) -> Self {
        self.dismissalEvent.addHandler(handler)
        return self
    }
    
}

public struct Dismisser {
    
    init(identifier: String) {
        self.identifier = identifier
    }
    
    let identifier: String
    
    public func dismiss(animated animated: Bool = true) {
        CRToastManager.dismissAllNotificationsWithIdentifier(identifier, animated: animated)
    }
    
}
