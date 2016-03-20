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

/// Represents a notification presentation.
public final class Presentation<Notification: NotificationType> {
    
    /// Initializes a presentation with a specified identifier.
    init(identifier: String) {
        self.identifier = identifier
    }
    
    /// The string to identify the presentation. Must be equal to the string set to the presentation for kCRToastIdentifier key.
    let identifier: String
    
    /// The signal of presentation. Calls handlers when the notification is presented.
    let presentationSignal = Signal<(Notification, Dismisser<Notification>)>()
    
    /**
     Adds a handler for the presentation.
     
     - parameter handler: A handler to be called when the notification is presented.
     
     - returns: The presentation itself.
     */
    public func onPresented(handler: (Notification, Dismisser<Notification>) -> Void) -> Presentation {
        self.presentationSignal.observe(handler)
        return self
    }
    
    /// The signal of user interaction. Calls handlers when user interactions are performed.
    let userInteractionSignal = Signal<(Notification, UserInteraction, Dismisser<Notification>)>()
    
    /**
     Adds a handler for specified user interaction.
     
     - parameter userInteraction: The user interaction.
     - parameter handler:         A handler called when the user interaction is performed.
     
     - returns: The presentation itself.
     */
    public func on(userInteraction: UserInteraction, handler: (Notification, Dismisser<Notification>) -> Void) -> Presentation {
        self.userInteractionSignal.observe({ (notification, performedUserInteraction, dismisser) in
            if !(performedUserInteraction.intersect(userInteraction).isEmpty) {
                handler(notification, dismisser)
            }
        })
        return self
    }
    
    /// The signal of dismissal. Calles handlers when the notification is dismissed.
    let dismissalSignal = Signal<Notification>()
    
    /**
     Adds a handler for the dismissal.
     
     - parameter handler: A handler to be called when the notification is dismissed.
     
     - returns: The presentation itself.
     */
    public func onDismissal(handler: (Notification) -> Void) -> Presentation {
        self.dismissalSignal.observe(handler)
        return self
    }
    
}

/// Related to a notification presentation, and had ability to dismiss the notification.
public struct Dismisser<Notification: NotificationType> {
    
    /// Initializes a dismisser with a presentation.
    init(presentation: Presentation<Notification>) {
        self.presentation = presentation
    }
    
    /// The related notification presentation.
    weak var presentation: Presentation<Notification>?
    
    /**
     Dismisses the related notification.
     
     - parameter animated: The boolean value that determines whether animate the dismissal or not. Default is true.
     - parameter handler:  A handler called when the notification is dismissed.
     */
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
