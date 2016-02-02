//
//  ViewController.swift
//  CRToastSwift
//
//  Created by Masahiko Tsujita on 11/15/2015.
//  Copyright (c) 2015 Masahiko Tsujita. All rights reserved.
//

import UIKit
import CRToastSwift

enum Theme {
    
    case Info
    case Success
    case Warning
    case Error
    
    private var backgroundColor: UIColor {
        switch self {
        case .Info:
            return UIColor(red:0.176, green:0.522, blue:0.976, alpha:1.0)
        case .Success:
            return UIColor(red:0.126, green:0.835, blue:0.163, alpha:1.0)
        case .Warning:
            return UIColor(red:0.988, green:0.753, blue:0.170, alpha:1.0)
        case .Error:
            return UIColor(red:0.886, green:0.211, blue:0.150, alpha:1.0)
        }
    }
    
    private var image: UIImage? {
        switch self {
        case .Info:
            return UIImage(named: "InfoImage")
        case .Success:
            return UIImage(named: "SuccessImage")
        case .Warning:
            return UIImage(named: "WarningImage")
        case .Error:
            return UIImage(named: "ErrorImage")
        }
    }
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var subtextField: UITextField!
    
    @IBOutlet weak var themeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var animationSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var statusBarVisibleSwitch: UISwitch!
    
    var selectedAnimation: Animation {
        switch self.animationSegmentedControl.selectedSegmentIndex {
        case 0:
            return .Linear
        case 1:
            return .Spring
        case 2:
            return .Gravity
        default:
            fatalError()
        }
    }
    
    var selectedTheme: Theme {
        switch self.themeSegmentedControl.selectedSegmentIndex {
        case 0:
            return .Info
        case 1:
            return .Success
        case 2:
            return .Warning
        case 3:
            return .Error
        default:
            fatalError()
        }
    }
    
    @IBAction func showNotification(sender: UIButton) {
        
        var notification = Notification()
        notification.text = self.textField.text!
        notification.subtext = self.subtextField.text
        notification.image = self.selectedTheme.image
        notification.imageTintColor = .Adapting
        notification.backgroundColor = self.selectedTheme.backgroundColor
        notification.showsStatusBar = self.statusBarVisibleSwitch.on
        
        notify(notification, animation: self.selectedAnimation) {
            print("Presented")
        } .onTapOnce { _ in
            print("OnTapOnce")
        } .onTapTwice { _ in
            print("OnTapTwice")
        } .onSwipeUp { _ in
            print("OnSwipeUp")
        } .onSwipeRight { _ in
            print("OnSwipeRight")
        } .onSwipeDown { _ in
            print("OnSwipeDown")
        } .onSwipeLeft { _ in
            print("OnSwipeLeft")
        } .onAnyTap { _ in
            print("OnAnyTap")
        } .onAnySwipe { _ in
            print("OnAnySwipe")
        } .onDismissal { _ in
            print("Dismissed")
        }
    }

}

