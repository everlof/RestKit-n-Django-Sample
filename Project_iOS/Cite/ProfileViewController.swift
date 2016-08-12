//
//  ProfileViewController.swift
//  Cite
//
//  Created by David Everlöf on 12/08/16.
//
//

import Foundation

class ProfileViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = appDelegate().loginManager.loggedInUser?.username
    }
    
}