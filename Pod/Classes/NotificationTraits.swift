//
//  NotificationTraits.swift
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

/// A structure containing miscellaneous properties for a notification.
public struct NotificationTraits {
    
    public typealias AccessoryViewAlignment = CRToastAccessoryViewAlignment
    
    public init() {
        
    }
    
    /// The alignment of text.
    public var textAlignment: NSTextAlignment = .Left
    
    /// The font of text.
    public var textFont = UIFont.boldSystemFontOfSize(18.0)
    
    /// The color of text.
    public var textColor: UIColor = .whiteColor()
    
    /// The maximum number of lines of text.
    public var textMaxNumberOfLines: Int = 0
    
    /// The shadow color of text.
    public var textShadowColor: UIColor = UIColor.clearColor()
    
    /// The shadow offset of text.
    public var textShadowOffset: CGSize = CGSize(width: 0.0, height: 0.0)
    
    /// The alignment of subtext.
    public var subtextAlignment: NSTextAlignment = .Left
    
    /// The font of subtext.
    public var subtextFont = UIFont.systemFontOfSize(14.0)
    
    /// The color of subtext.
    public var subtextColor: UIColor = .whiteColor()
    
    /// The maximum number of lines of subtext.
    public var subtextMaxNumberOfLines: Int = 0
    
    /// The shadow color of subtext.
    public var subtextShadowColor: UIColor = UIColor.clearColor()
    
    /// The shadow offset of subtext.
    public var subtextShadowOffset: CGSize = CGSize(width: 0.0, height: 0.0)
    
    /// Determines size of notification view.
    public enum Size {
        case Compact
        case Regular
        case Custom(preferredHeight: CGFloat)
    }
    
    /// The value that determines size of notification view.
    public var size: Size = .Regular
    
    /// The boolean value that determines the status bar is visible or not.
    public var showsStatusBar = false
    
    /// The style of status bar.
    public var statusBarStyle: UIStatusBarStyle = .Default
    
    /// The preferred padding of notification view.
    public var preferredPadding: CGFloat = 0
    
    /// The image displayed on notification view.
    public var image: UIImage?
    
    /// The tint color of the image.
    public var imageTintColor: UIColor?
    
    /// The alignment of the image.
    public var imageAlignment: AccessoryViewAlignment = .Left
    
    /// The content mode of the image.
    public var imageContentMode: UIViewContentMode = .Center
    
    /// The background color of notification view.
    public var backgroundColor = UIColor.darkGrayColor()
    
    /// The view to be placed on background of notification view.
    public var backgroundView: (() -> UIView?)?
    
    /// The boolean value that determines the activity indicator is displayed or not.
    public var showsActivityIndicatorView = false
    
    /// The style of the activity indicator.
    public var activityIndicatorViewStyle: UIActivityIndicatorViewStyle = .Gray
    
    /// the alignment of the activity indicator.
    public var activityIndicatorAlignment: AccessoryViewAlignment = .Left
    
    /**
    The boolean value that determines navigation bar border is kept or not while presentation.
    The standard navigation bar has a thin border on the bottom. Animations are
    improved when the toast is within the border. Customized bars without the border should have this set to false.
    */
    public var keepsNavigationBarBorder = true
    
    /// The boolean value that determines the notification should rotate automatically or not.
    public var rotatesAutomatically = true
    
    /// The boolean value that determines the notification should capture the screen behind the default window.
    public var capturesDefaultWindow = true
    
}
