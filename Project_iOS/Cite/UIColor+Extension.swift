//
//  UIColor+Extension.swift
//  Cite
//
//  Created by David Everlöf on 11/08/16.
//
//

import Foundation

extension UIColor {
    
    class func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // Extracted with http://lokeshdhakar.com/projects/color-thief/
    
    class func citeColor1() -> UIColor {
        return UIColor.UIColorFromRGB(0xD3D5B6)
    }
    
    class func citeColor2() -> UIColor {
        return UIColor.UIColorFromRGB(0x1E84A8)
    }
    
    class func citeColor3() -> UIColor {
        return UIColor.UIColorFromRGB(0x81BEBD)
    }
    
    class func citeColor4() -> UIColor {
        return UIColor.UIColorFromRGB(0x0D4F71)
    }
    
    class func citeColor5() -> UIColor {
        return UIColor.UIColorFromRGB(0xA4C4BB)
    }
    
    class func backgroundColor() -> UIColor {
        return UIColor.UIColorFromRGB(0xFEFFFA)
    }
}