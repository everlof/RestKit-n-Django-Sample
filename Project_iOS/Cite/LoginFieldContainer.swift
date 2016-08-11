//
//  LoginFieldContainer.swift
//  Cite
//
//  Created by David Everlöf on 11/08/16.
//
//

import Foundation
import UIKit

class LoginFieldContainer: UIView {
    private var iconOffsetConstraint: NSLayoutConstraint!
    
    private let input = UITextField()
    private let icon = UIImageView()
    
    var value: String? {
        get {
            return self.input.text
        }
        set (newVal) {
            self.input.text = newVal
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setPlaceholder(placeholder: String) {
        input.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            NSForegroundColorAttributeName: UIColor.whiteColor().colorWithAlphaComponent(0.75)
            ])
    }
    
    func setIcon(name: String) {
        icon.image = UIImage(named: name)
    }
    
    func setIsPassword(password: Bool) {
        input.secureTextEntry = password
    }
    
    func iconOffset(offset: CGFloat) {
        iconOffsetConstraint.constant = offset
    }
    
    func setup() {
        input.translatesAutoresizingMaskIntoConstraints = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        icon.tintColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        
        input.font = UIFont.citeFontOfSize(20.0)
        input.textColor = UIColor.whiteColor()
        input.tintColor = UIColor.whiteColor()
        input.keyboardType = .ASCIICapable
        input.autocorrectionType = .No
        input.autocapitalizationType = .None
        
        addSubview(icon)
        addSubview(input)
        
        // Let the label grow, instead of the icon
        icon.setContentHuggingPriority(251, forAxis: .Horizontal)
        
        iconOffsetConstraint = NSLayoutConstraint(item: icon, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1.0, constant: 0.0)
        iconOffsetConstraint.active = true
        
        NSLayoutConstraint(item: icon, attribute: .Right, relatedBy: .Equal, toItem: input, attribute: .Left, multiplier: 1.0, constant: -9.0).active = true
        
        NSLayoutConstraint(item: input, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1.0, constant: 0).active = true
        
        NSLayoutConstraint(item: icon, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0  , constant: 0.0).active = true
        
        NSLayoutConstraint(item: icon, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0  , constant: -10.0).active = true
        
        NSLayoutConstraint(item: input, attribute: .CenterY, relatedBy: .Equal, toItem: icon, attribute: .CenterY, multiplier: 1.0, constant: 0.0).active = true
        
        addBorder(edges: .Bottom, colour: UIColor.whiteColor().colorWithAlphaComponent(0.5), weight: 1.0)
    }
}