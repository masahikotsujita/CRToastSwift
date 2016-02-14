//
//  NotificationPresentation.swift
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

public final class NotificationPresentation<Notification: NotificationType> {
    
    init(identifier: String) {
        self.identifier = identifier
    }
    
    let identifier: String
    
    let userInteractionSignal = Signal<(Notification, UserInteraction, NotificationDismisser<Notification>)>()
    
    public func on(userInteraction: UserInteraction, handler: (Notification, NotificationDismisser<Notification>) -> Void) -> NotificationPresentation {
        self.userInteractionSignal.observe({ (notification, performedUserInteraction, dismisser) in
            if !(performedUserInteraction.intersect(userInteraction).isEmpty) {
                handler(notification, dismisser)
            }
        })
        return self
    }
    
    let dismissalSignal = Signal<Notification>()
    
    public func onDismissal(handler: (Notification) -> Void) -> NotificationPresentation {
        self.dismissalSignal.observe(handler)
        return self
    }
    
}

public struct NotificationDismisser<Notification: NotificationType> {
    
    init(presentation: NotificationPresentation<Notification>) {
        self.presentation = presentation
    }
    
    weak var presentation: NotificationPresentation<Notification>?
    
    public func dismiss(animated animated: Bool = true, handler: ((Notification) -> Void)? = nil) {
        guard let presentation = self.presentation else {
            debugPrint("CRToastSwift: Dismisser.dismiss() was called after presentation object had been deallocated.\nDismissal by this call will not be performed and given handler will not be invoked.")
            return
        }
        if let handler = handler {
            presentation.onDismissal(handler)
        }
        CRToastManager.dismissAllNotificationsWithIdentifier(presentation.identifier, animated: animated)
    }
    
}
