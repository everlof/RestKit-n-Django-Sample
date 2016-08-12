//
//  ViewController.swift
//  Cite
//
//  Created by David Everlöf on 11/08/16.
//
//

import Foundation

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    view.backgroundColor = UIColor.backgroundColor()
    navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
    self.navigationController?.navigationBar.titleTextAttributes =
      [NSForegroundColorAttributeName: UIColor.citeColor4(),
       NSFontAttributeName: UIFont.citeFontOfSize(18)]
  }
  
}

class NavigationController: UINavigationController {
  
  override func viewDidLoad() {
    navigationBar.backIndicatorImage = UIImage(named: "ic_leftarrow")
  }
  
}