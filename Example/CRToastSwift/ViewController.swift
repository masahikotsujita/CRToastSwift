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

class ViewController: UIViewController, NotificationPresentationContextType {
    
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
    
    func traitsForNotification(_: Notification) -> NotificationTraits {
        var traits = NotificationTraits()
        traits.image = self.selectedTheme.image
        traits.backgroundColor = self.selectedTheme.backgroundColor
        traits.showsStatusBar = self.statusBarVisibleSwitch.on
        return traits
    }
    
    @IBAction func showNotification(sender: UIButton) {
        CRToast.presentNotification(Notification(text: self.textField.text!, subtext: self.subtextField.text), context: self, animation: self.selectedAnimation) { _ in
            print("Presented")
        } .on(.Tap) { (_, dismisser) in
            print("OnTapOnce")
            dismisser.dismiss { _ in
                print("Dismissed by Tap")
            }
        } .on(.DoubleTap) { (_, dismisser) in
            print("OnTapTwice")
            dismisser.dismiss { _ in
                print("Dismissed by Tap Twice")
            }
        } .on(.SwipeUp) { (_, dismisser) in
            print("OnSwipeUp")
            dismisser.dismiss { _ in
                print("Dismissed by Swipe Up")
            }
        } .on(.SwipeRight) { (_, dismisser) in
            print("OnSwipeRight")
            dismisser.dismiss { _ in
                print("Dismissed by Swipe Right")
            }
        } .on(.SwipeDown) { (_, dismisser) in
            print("OnSwipeDown")
            dismisser.dismiss { _ in
                print("Dismissed by Swipe Down")
            }
        } .on(.SwipeLeft) { (_, dismisser) in
            print("OnSwipeLeft")
            dismisser.dismiss { _ in
                print("Dismissed by Swipe Left")
            }
        } .on(.AnyTap) { _ in
            print("OnAnyTap")
        } .on(.AnySwipe) { _ in
            print("OnAnySwipe")
        } .onDismissal { _ in
            print("Dismissed")
        }
    }

}

