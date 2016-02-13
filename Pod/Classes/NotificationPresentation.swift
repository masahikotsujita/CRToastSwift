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
    
    init(notification: Notification, identifier: String) {
        self.notification = notification
        self.identifier = identifier
    }
    
    public let notification: Notification
    
    public let identifier: String
    
    var dismisser: NotificationDismisser<Notification> {
        return NotificationDismisser(presentation: self)
    }
    
    private let interactionEvent = Event<(Interaction, Notification, NotificationDismisser<Notification>)>()
    
    public func on(interaction: Interaction, handler: (Notification, NotificationDismisser<Notification>) -> Void) -> NotificationPresentation {
        self.interactionEvent.addHandler({ (occurredInteraction, notification, dismisser) in
            if !(occurredInteraction.intersect(interaction).isEmpty) {
                handler(notification, dismisser)
            }
        })
        return self
    }
    
    func invokeInteractionEvent(interaction: Interaction) {
        self.interactionEvent.invoke(argument: (interaction, self.notification, self.dismisser))
    }
    
    private let dismissalEvent = Event<Notification>()
    
    public func onDismissal(handler: (Notification) -> Void) -> NotificationPresentation {
        self.dismissalEvent.addHandler(handler)
        return self
    }
    
    func invokeDismissalEvent() {
        self.dismissalEvent.invoke(argument: self.notification)
    }
    
}

public struct NotificationDismisser<Notification: NotificationType> {
    
    private init(presentation: NotificationPresentation<Notification>) {
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
