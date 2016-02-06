//
//  NotificationTraits.swift
//  Pods
//
//  Created by 辻田晶彦 on 2016/02/05.
//
//

import Foundation
import CRToast

public struct NotificationTraits {
    
    public typealias AccessoryViewAlignment = CRToastAccessoryViewAlignment
    
    public init() {
        
    }
    
    public var textAlignment: NSTextAlignment = .Left
    
    public var textFont = UIFont.boldSystemFontOfSize(18.0)
    
    public var textColor: UIColor = .whiteColor()
    
    public var textMaxNumberOfLines: Int = 0
    
    public var textShadowColor: UIColor = UIColor.clearColor()
    
    public var textShadowOffset: CGSize = CGSize(width: 0.0, height: 0.0)
    
    public var subtextAlignment: NSTextAlignment = .Left
    
    public var subtextFont = UIFont.systemFontOfSize(14.0)
    
    public var subtextColor: UIColor = .whiteColor()
    
    public var subtextMaxNumberOfLines: Int = 0
    
    public var subtextShadowColor: UIColor = UIColor.clearColor()
    
    public var subtextShadowOffset: CGSize = CGSize(width: 0.0, height: 0.0)
    
    public enum Size {
        
        case Compact
        case Regular
        case Custom(preferredHeight: CGFloat)
        
        var crToastType: CRToastType {
            switch self {
            case .Compact:
                return .StatusBar
            case .Regular:
                return .NavigationBar
            case .Custom(_):
                return .Custom
            }
        }
        
    }
    
    public var size: Size = .Regular
    
    public var showsStatusBar = false
    
    public var statusBarStyle: UIStatusBarStyle = .Default
    
    public var preferredPadding: CGFloat = 0
    
    public var image: UIImage?
    
    public var imageTintColor: UIColor?
    
    public var imageAlignment: CRToastAccessoryViewAlignment = .Left
    
    public var imageContentMode: UIViewContentMode = .Center
    
    public var backgroundColor = UIColor.darkGrayColor()
    
    public var backgroundView: (() -> UIView?)?
    
    public var showsActivityIndicatorView = false
    
    public var activityIndicatorViewStyle: UIActivityIndicatorViewStyle = .Gray
    
    public var activityIndicatorAlignment: AccessoryViewAlignment = .Left
    
    public var keepsNavigationBarBorder = true
    
    public var rotatesAutomatically = true
    
    public var capturesDefaultWindow = true
    
}
