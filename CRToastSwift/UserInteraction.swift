//
//  UserInteraction.swift
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

import CRToast

/// Represents an user interaction
public struct UserInteraction: OptionSetType {
    
    public typealias RawValue = CRToastInteractionType.RawValue
    
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    public let rawValue: RawValue
    
    public static let Tap                   = UserInteraction(rawValue: CRToastInteractionType.TapOnce.rawValue)
    public static let DoubleTap             = UserInteraction(rawValue: CRToastInteractionType.TapTwice.rawValue)
    public static let TwoFingerTap          = UserInteraction(rawValue: CRToastInteractionType.TwoFingerTapOnce.rawValue)
    public static let TwoFingerDoubleTap    = UserInteraction(rawValue: CRToastInteractionType.TwoFingerTapTwice.rawValue)
    
    public static let SwipeUp               = UserInteraction(rawValue: CRToastInteractionType.SwipeUp.rawValue)
    public static let SwipeLeft             = UserInteraction(rawValue: CRToastInteractionType.SwipeLeft.rawValue)
    public static let SwipeDown             = UserInteraction(rawValue: CRToastInteractionType.SwipeDown.rawValue)
    public static let SwipeRight            = UserInteraction(rawValue: CRToastInteractionType.SwipeRight.rawValue)
    
    public static let AnyTap                = UserInteraction(rawValue: CRToastInteractionType.Tap.rawValue)
    public static let AnySwipe              = UserInteraction(rawValue: CRToastInteractionType.Swipe.rawValue)
    public static let Any                   = UserInteraction(rawValue: CRToastInteractionType.All.rawValue)
    
}
