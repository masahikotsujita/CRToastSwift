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

public typealias AnimationType      = CRToastAnimationType
public typealias AnimationDirection = CRToastAnimationDirection
public typealias PresentationType   = CRToastPresentationType

public struct Animation {
    
    public init(inAnimation: AnimationType = .Linear, inDirection: AnimationDirection = .Top, inDuration: NSTimeInterval = 0.4, outAnimation: AnimationType = .Linear , outDirection: AnimationDirection = .Top, outDuration: NSTimeInterval = 0.4, springDamping: CGFloat = 0.6, springInitialVelocity: CGFloat = 1.0, gravityMagnitude: CGFloat = 1.0, presentationType: PresentationType = .Cover) {
        self.inType                 = inAnimation
        self.inDirection            = inDirection
        self.inDuration             = inDuration
        self.outType                = outAnimation
        self.outDirection           = outDirection
        self.outDuration            = outDuration
        self.springDamping          = springDamping
        self.springInitialVelocity  = springInitialVelocity
        self.gravityMagnitude       = gravityMagnitude
        self.presentationType       = presentationType
    }
    
    public let inType: AnimationType
    
    public let inDirection: AnimationDirection
    
    public let inDuration: NSTimeInterval
    
    public let outType: AnimationType
    
    public let outDirection: AnimationDirection
    
    public let outDuration: NSTimeInterval
    
    public let springDamping: CGFloat
    
    public let springInitialVelocity: CGFloat
    
    public let gravityMagnitude: CGFloat
    
    public let presentationType: PresentationType
    
    public static let None = Animation(inDuration: 0, outDuration: 0)
    
    public static let Linear: Animation = .Linear()
    
    public static let Spring: Animation = .Spring()
    
    public static let Gravity: Animation = .Gravity()
    
    public static func Linear(inDirection inDirection: AnimationDirection = .Top, inDuration: NSTimeInterval = 0.4, outDirection: AnimationDirection = .Top, outDuration: NSTimeInterval = 0.4, presentationType: PresentationType = .Cover) -> Animation {
        return Animation(inAnimation: .Linear, inDirection: inDirection, inDuration: inDuration, outAnimation: .Linear, outDirection: outDirection, outDuration: outDuration, presentationType: presentationType)
    }
    
    public static func Spring(inDirection inDirection: AnimationDirection = .Top, inDuration: NSTimeInterval = 0.4, outDirection: AnimationDirection = .Top, outDuration: NSTimeInterval = 0.4, damping: CGFloat = 0.6, initialVelocity: CGFloat = 1.0, presentationType: PresentationType = .Cover) -> Animation {
        return Animation(inAnimation: .Spring, inDirection: inDirection, inDuration: inDuration, outAnimation: .Spring, outDirection: outDirection, outDuration: outDuration, springDamping: damping, springInitialVelocity: initialVelocity, presentationType: presentationType)
    }
    
    public static func Gravity(inDirection inDirection: AnimationDirection = .Top, inDuration: NSTimeInterval = 0.4, outDirection: AnimationDirection = .Top, outDuration: NSTimeInterval = 0.4, magnitude: CGFloat = 1.0, presentationType: PresentationType = .Cover) -> Animation {
        return Animation(inAnimation: .Gravity, inDirection: inDirection, inDuration: inDuration, outAnimation: .Gravity, outDirection: outDirection, outDuration: outDuration, gravityMagnitude: magnitude, presentationType: presentationType)
    }
    
}
