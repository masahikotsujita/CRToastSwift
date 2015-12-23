//
//  ViewController.swift
//  CRToastSwift
//
//  Created by Masahiko Tsujita on 11/15/2015.
//  Copyright (c) 2015 Masahiko Tsujita. All rights reserved.
//

import UIKit
import CRToastSwift

enum Template {
    case Info, Success, Warning, Error
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var templateSegmentedControl: UISegmentedControl!
    
    var template: Template {
        get {
            switch templateSegmentedControl.selectedSegmentIndex {
            case 0:
                return .Info
            case 1:
                return .Success
            case 2:
                return .Warning
            default:
                return .Error
            }
        }
    }
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var subtitleTextField: UITextField!
    
    @IBOutlet weak var animationTypeSegmentedControl: UISegmentedControl!
    
    var animationType: CRToastSwift.AnimationType {
        get {
            return CRToastSwift.AnimationType(rawValue: self.animationTypeSegmentedControl.selectedSegmentIndex)!
        }
    }
    
    @IBOutlet weak var statusBarVisibleSwitch: UISwitch!
    
    @IBAction func showNotification(sender: UIButton) {
        notify(Notification(text: "Hello, world!"), animation: .Gravity) {
            print("Presentation")
        } .onTapOnce { _ in
            print("TapOnce")
        } .onTapTwice { _ in
            print("TapTwice")
        } .onSwipeUp { _ in
            print("SwipeUp")
        } .onSwipeRight { _ in
            print("SwipeRight")
        } .onSwipeDown { _ in
            print("SwipeDown")
        } .onSwipeLeft { _ in
            print("SwipeLeft")
        } .onAnyTap { _ in
            print("AnyTap")
        } .onAnySwipe { _ in
            print("AnySwipe")
        } .onDismissal { _ in
            print("Dismissed")
        }
    }

}

