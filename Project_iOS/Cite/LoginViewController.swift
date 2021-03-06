//
//  LoginViewController.swift
//  Cite
//
//  Created by David Everlöf on 08/08/16.
//
//

import Foundation

class LoginViewController: ViewController {
  
  let backgroundImage = UIImageView()
  
  let usernameInput = LoginFieldContainer()
  
  let passwordInput = LoginFieldContainer()
  
  let loginButton = UIButton()
  
  let orLabel = UILabel()
  
  let facebookButton = UIButton()
  
  let noAccountLabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    backgroundImage.translatesAutoresizingMaskIntoConstraints = false
    backgroundImage.image = UIImage(named: "login_background")
    backgroundImage.contentMode = .ScaleAspectFill
    
    usernameInput.translatesAutoresizingMaskIntoConstraints = false
    usernameInput.setPlaceholder("Username")
    usernameInput.setIcon("ic_user")
    
    passwordInput.translatesAutoresizingMaskIntoConstraints = false
    passwordInput.setPlaceholder("Password")
    passwordInput.setIcon("ic_password")
    passwordInput.setIsPassword(true)
    passwordInput.iconOffset(3.0)
    
    loginButton.translatesAutoresizingMaskIntoConstraints = false
    loginButton.setTitle("SIGN IN", forState: .Normal)
    loginButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    loginButton.setBackgroundImage(UIImage(color: UIColor.citeColor4()), forState: .Normal)
    loginButton.titleLabel?.font = UIFont.citeFontOfSize(18.0)
    loginButton.addTarget(self, action: #selector(didPressSignIn), forControlEvents: .TouchUpInside)
    
    orLabel.translatesAutoresizingMaskIntoConstraints = false
    orLabel.font = UIFont.citeFontOfSize(18.0)
    orLabel.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
    orLabel.text = "or"
    
    facebookButton.translatesAutoresizingMaskIntoConstraints = false
    facebookButton.setTitle("Sign in with Facebook", forState: .Normal)
    facebookButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    facebookButton.setBackgroundImage(UIImage(color: UIColor.citeColor4()), forState: .Normal)
    facebookButton.titleLabel?.font = UIFont.citeFontOfSize(18.0)
    facebookButton.addTarget(self, action: #selector(didPressSignIn), forControlEvents: .TouchUpInside)
    
    let noAccAttrText = NSMutableAttributedString()
    noAccAttrText.appendAttributedString(
      NSAttributedString(
        string: "Don't have an account yet?", attributes: [
          NSForegroundColorAttributeName: UIColor.whiteColor().colorWithAlphaComponent(0.5)
        ]))
    noAccAttrText.appendAttributedString(
      NSAttributedString(
        string: " Sign up.", attributes: [
          NSForegroundColorAttributeName: UIColor.whiteColor().colorWithAlphaComponent(0.75)
        ]))
    
    noAccountLabel.font = UIFont.citeFontOfSize(18.0)
    noAccountLabel.translatesAutoresizingMaskIntoConstraints = false
    noAccountLabel.attributedText = noAccAttrText
    
    view.addSubview(backgroundImage)
    view.addSubview(usernameInput)
    view.addSubview(passwordInput)
    view.addSubview(loginButton)
    view.addSubview(orLabel)
    view.addSubview(facebookButton)
    view.addSubview(noAccountLabel)
    
    NSLayoutConstraint(item: usernameInput, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 36.0).active = true
    NSLayoutConstraint(item: usernameInput, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: -36.0).active = true
    NSLayoutConstraint(item: usernameInput, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 200.0).active = true
    
    NSLayoutConstraint(item: passwordInput, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 36.0).active = true
    NSLayoutConstraint(item: passwordInput, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: -36.0).active = true
    NSLayoutConstraint(item: passwordInput, attribute: .Top, relatedBy: .Equal, toItem: usernameInput, attribute: .Bottom, multiplier: 1.0, constant: 36.0).active = true
    
    NSLayoutConstraint(item: loginButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0.0).active = true
    NSLayoutConstraint(item: loginButton, attribute: .Top, relatedBy: .Equal, toItem: passwordInput, attribute: .Bottom, multiplier: 1.0, constant: 50.0).active = true
    NSLayoutConstraint(item: loginButton, attribute: .Height, relatedBy: .Equal, toItem: passwordInput, attribute: .Height, multiplier: 1.0, constant: 10).active = true
    NSLayoutConstraint(item: loginButton, attribute: .Width, relatedBy: .Equal, toItem: passwordInput, attribute: .Width, multiplier: 1.0, constant: 0).active = true
    
    NSLayoutConstraint(item: orLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0.0).active = true
    NSLayoutConstraint(item: orLabel, attribute: .Top, relatedBy: .Equal, toItem: loginButton, attribute: .Bottom, multiplier: 1.0, constant: 9.0).active = true
    
    NSLayoutConstraint(item: facebookButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0.0).active = true
    NSLayoutConstraint(item: facebookButton, attribute: .Top, relatedBy: .Equal, toItem: orLabel, attribute: .Bottom, multiplier: 1.0, constant: 9.0).active = true
    NSLayoutConstraint(item: facebookButton, attribute: .Height, relatedBy: .Equal, toItem: passwordInput, attribute: .Height, multiplier: 1.0, constant: 10).active = true
    NSLayoutConstraint(item: facebookButton, attribute: .Width, relatedBy: .Equal, toItem: passwordInput, attribute: .Width, multiplier: 1.0, constant: 0).active = true
    
    NSLayoutConstraint(item: noAccountLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0.0).active = true
    NSLayoutConstraint(item: noAccountLabel, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -18.0).active = true
    
    // Background
    NSLayoutConstraint(item: backgroundImage, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1.0, constant: 0.0).active = true
    
    NSLayoutConstraint(item: backgroundImage, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 1.0, constant: 0.0).active = true
    
    NSNotificationCenter.defaultCenter().addObserver(self,
                                                     selector: #selector(loginChange(_:)),
                                                     name: LoginManager.kLoginChange,
                                                     object: nil)
    
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }
  
  func didPressSignIn() {
    if let username = usernameInput.value, password = passwordInput.value {
      appDelegate().loginManager.login(username, password: password, ok: {
        print("OK")
        }, notOk: {
          print("NOT OK")
      })
    }
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