//
//  ViewController.swift
//  CRToastSwift
//
//  Created by Masahiko Tsujita on 11/15/2015.
//  Copyright (c) 2015 Masahiko Tsujita. All rights reserved.
//

import UIKit
import CRToastSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var templateSegmentedControl: UISegmentedControl!
    
    var template: NotificationController.Template {
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
    
    var animationType: NotificationController.AnimationType {
        get {
            return NotificationController.AnimationType(rawValue: self.animationTypeSegmentedControl.selectedSegmentIndex)!
        }
    }
    
    @IBOutlet weak var statusBarVisibleSwitch: UISwitch!
    
    @IBAction func showNotification(sender: UIButton) {
        let notification = CRToastSwift.NotificationController(
            title: self.titleTextField.text!,
            subtitle: self.subtitleTextField.text!,
            template: self.template)
        notification.inAnimationType = self.animationType
        notification.outAnimationType = self.animationType
        notification.underStatusBar = self.statusBarVisibleSwitch.on
        notification.statusBarStyle = .LightContent
        notification.present()
    }

}

