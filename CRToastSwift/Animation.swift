//
//  Animation.swift
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

/// Represents an animation used for notification presentation.
public struct Animation {
    
    public typealias Curve = CRToastAnimationType
    public typealias Direction = CRToastAnimationDirection
    public typealias BackgroundHidingStyle = CRToastPresentationType
    
    //  MARK: Getting Predefined Animations
    
    /// A predefined "None" animation that represents that any animation will not be performed.
    public static let None = Animation(inDuration: 0, outDuration: 0)
    
    /// A predefined linear animation.
    public static let Linear: Animation = .Linear()
    
    /// A predefined spring animation.
    public static let Spring: Animation = .Spring()
    
    /// A predefined gravity animation.
    public static let Gravity: Animation = .Gravity()
    
    // MARK: Instantiating Custom Animations
    
    /// Initializes a custom animation with specified parameters.
    public init(inCurve: Curve = .Linear, inDirection: Direction = .Top, inDuration: NSTimeInterval = 0.4, outCurve: Curve = .Linear , outDirection: Direction = .Top, outDuration: NSTimeInterval = 0.4, springDamping: CGFloat = 0.6, springInitialVelocity: CGFloat = 1.0, gravityMagnitude: CGFloat = 1.0, backgroundHidingStyle: BackgroundHidingStyle = .Cover) {
        self.inCurve                = inCurve
        self.inDirection            = inDirection
        self.inDuration             = inDuration
        self.outCurve               = outCurve
        self.outDirection           = outDirection
        self.outDuration            = outDuration
        self.springDamping          = springDamping
        self.springInitialVelocity  = springInitialVelocity
        self.gravityMagnitude       = gravityMagnitude
        self.backgroundHidingStyle  = backgroundHidingStyle
    }
    
    /// Instantiates a custom linear animation with specified parameters.
    public static func Linear(inDirection inDirection: Direction = .Top, inDuration: NSTimeInterval = 0.4, outDirection: Direction = .Top, outDuration: NSTimeInterval = 0.4, backgroundHidingStyle: BackgroundHidingStyle = .Cover) -> Animation {
        return Animation(inCurve: .Linear, inDirection: inDirection, inDuration: inDuration, outCurve: .Linear, outDirection: outDirection, outDuration: outDuration, backgroundHidingStyle: backgroundHidingStyle)
    }
    
    /// Instantiates a custom spring animation with specified parameters.
    public static func Spring(inDirection inDirection: Direction = .Top, inDuration: NSTimeInterval = 0.4, outDirection: Direction = .Top, outDuration: NSTimeInterval = 0.4, damping: CGFloat = 0.6, initialVelocity: CGFloat = 1.0, backgroundHidingStyle: BackgroundHidingStyle = .Cover) -> Animation {
        return Animation(inCurve: .Spring, inDirection: inDirection, inDuration: inDuration, outCurve: .Spring, outDirection: outDirection, outDuration: outDuration, springDamping: damping, springInitialVelocity: initialVelocity, backgroundHidingStyle: backgroundHidingStyle)
    }
    
    /// Instantiates a custom gravity animation with specified parameters.
    public static func Gravity(inDirection inDirection: Direction = .Top, inDuration: NSTimeInterval = 0.4, outDirection: Direction = .Top, outDuration: NSTimeInterval = 0.4, magnitude: CGFloat = 1.0, backgroundHidingStyle: BackgroundHidingStyle = .Cover) -> Animation {
        return Animation(inCurve: .Gravity, inDirection: inDirection, inDuration: inDuration, outCurve: .Gravity, outDirection: outDirection, outDuration: outDuration, gravityMagnitude: magnitude, backgroundHidingStyle: backgroundHidingStyle)
    }
    
    //  MARK: Animation Attributes
    
    /// In animation curve.
    public let inCurve: Curve
    
    /// In animation direction.
    public let inDirection: Direction
    
    /// In animation duration.
    public let inDuration: NSTimeInterval
    
    /// Out animation curve.
    public let outCurve: Curve
    
    /// Out animation direction.
    public let outDirection: Direction
    
    /// Out animation duration.
    public let outDuration: NSTimeInterval
    
    /// Damping coefficient for spring animation.
    public let springDamping: CGFloat
    
    /// Initial velocity coefficient for spring animation.
    public let springInitialVelocity: CGFloat
    
    /// Magnitude used for gravity animation.
    public let gravityMagnitude: CGFloat
    
    /// Determines how background will be hidden.
    public let backgroundHidingStyle: BackgroundHidingStyle
    
}
