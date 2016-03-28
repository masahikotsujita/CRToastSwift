//
//  PresentationContext.swift
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

/// Represents a context for notification presentations.
public protocol PresentationContextType {
    
    associatedtype Notification: NotificationType
    
    /**
     Returns attributes for the notification to be presented.
     
     - parameter notification: The notification to be presented.
     
     - returns: The attributes for the notification.
     */
    func attributesForNotification(notification: Self.Notification) -> NotificationAttributeCollection
    
}

/// A presentation context initialized with a function for its attributesForNotification(: ).
public struct PresentationContext<Notification: NotificationType>: PresentationContextType {
    
    /**
     Initializes a presentation context with a function for attributesForNotification(: ).
     
     - parameter handler: The function for attributesForNotification(: ).
     
     - returns: Initialized presentation context.
     */
    public init(_ body: Notification -> NotificationAttributeCollection) {
        self.body = body
    }
    
    public let body: Notification -> NotificationAttributeCollection
    
    public func attributesForNotification(notification: Notification) -> NotificationAttributeCollection {
        return self.body(notification)
    }
    
}
