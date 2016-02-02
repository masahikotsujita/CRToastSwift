//
//  Utils.swift
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

public enum Adaptable<Value> {

    case Fixed(_: Value)
    case Adapting

    public init(_ value: Value) {
        self = .Fixed(value)
    }
    
}

extension UIColor {

    var isLightColor: Bool {
        var white = CGFloat()
        guard self.getWhite(&white, alpha: nil) else {
            fatalError("Couldn't get whiteness from color \(self)")
        }
        return white >= 0.5
    }
    
}

public enum TimeInterval {
    case Finite(_: NSTimeInterval)
    case Infinite
}

func synchronized(lock: NSLocking, @noescape handler: () -> Void) {
    lock.lock()
    handler()
    lock.unlock()
}

func colorByUnwrappingAdaptableValue(adaptableValue: Adaptable<UIColor>, forBackgroundColor backgroundColor: UIColor) -> UIColor {
    switch adaptableValue {
    case let .Fixed(value):
        return value
    case .Adapting:
        if backgroundColor.isLightColor {
            return .blackColor()
        } else {
            return .whiteColor()
        }
    }
}

func statusBarStyleByUnwrappingAdaptableValue(adaptableValue: Adaptable<UIStatusBarStyle>, forBackgroundColor backgroundColor: UIColor) -> UIStatusBarStyle {
    switch adaptableValue {
    case let .Fixed(value):
        return value
    case .Adapting:
        if backgroundColor.isLightColor {
            return .Default
        } else {
            return .LightContent
        }
    }
}

func activityIndicatorViewStyleByUnrappingAdaptableValue(adaptableValue: Adaptable<UIActivityIndicatorViewStyle>, forBackgroundColor backgroundColor: UIColor) -> UIActivityIndicatorViewStyle {
    switch adaptableValue {
    case let .Fixed(value):
        return value
    case .Adapting:
        if backgroundColor.isLightColor {
            return .Gray
        } else {
            return .White
        }
    }
}
