//
//  UIFont+Extension.swift
//  Cite
//
//  Created by David Everlöf on 08/08/16.
//
//

import Foundation

extension UIFont {
  
  class func citeFontOfSize(size: CGFloat) -> UIFont {
    return UIFont(name: "Avenir-Light", size: size)!
  }
  
  class func citeBoldFontOfSize(size: CGFloat) -> UIFont {
    return UIFont(name: "Avenir-Medium", size: size)!
  }
  
  class func citeItalicFontOfSize(size: CGFloat) -> UIFont {
    return UIFont(name: "Avenir-LightOblique", size: size)!
  }
}