//
//  LoginViewController.swift
//  Cite
//
//  Created by David Everlöf on 08/08/16.
//
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.redColor()
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(loginChange(_:)),
                                                         name: LoginManager.kLoginChange,
                                                         object: nil)
        
        appDelegate().loginManager.login("tester", password: "tester", ok: nil, notOk: nil)
    }
    
    func loginChange(notification: NSNotification) {
        if let loginEventRaw = notification.userInfo?[LoginManager.kLoginChangeUserInfoEventKey] {
            let loginEvent = LoginManager.LoginEvent(rawValue: loginEventRaw as! String)
            switch loginEvent! {
            case .LogIn:
                appDelegate().window?.rootViewController = appDelegate().mainTabBar
            case .LogOut:
                appDelegate().window?.rootViewController = LoginViewController()
            }
        }
    }
    
}