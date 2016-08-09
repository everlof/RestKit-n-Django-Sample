//
//  AddQuoteViewController.swift
//  Cite
//
//  Created by David Everlöf on 09/08/16.
//
//

import Foundation
import UIKit

class AddQuoteViewController: UIViewController,
    UITextViewDelegate
{
    var context: NSManagedObjectContext! = nil
    var newQuote: Quote! = nil
    
    let textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = RKObjectManager.sharedManager().managedObjectStore.newChildManagedObjectContextWithConcurrencyType(.PrivateQueueConcurrencyType, tracksChanges: false)
        newQuote = context.insertNewObjectForEntityForName(String(Quote)) as! Quote
        
        self.navigationItem.title = "New Quote"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Publish",
            style: .Plain,
            target: self,
            action: #selector(publish)
        )
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        
        view.addSubview(textView)
        
        textView.backgroundColor = UIColor.lightGrayColor()
        
        NSLayoutConstraint(item: textView, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: textView, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: textView, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: textView, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 0.5, constant: 0.0).active = true
    }
    
    func publish() {
        // All modifications must be performed on the correct thread
        // which we accomplish by using `performBlock(AndWait)`
        self.context.performBlockAndWait({
            if let user = appDelegate().loginManager.loggedInUserInContext(self.context) {
                
                // Set the attributes
                self.newQuote.quote = self.textView.attributedText.string
                self.newQuote.owner = user
                
                // Just set this to something - right now we dont wanna create a textfield for it..
                self.newQuote.author = "unKnown"
                
                // Now create the object remotely as well, and it will be inserted into
                // the contexts that are used by the rest of the app
                RKObjectManager.sharedManager().postObject(self.newQuote, path: nil, parameters: nil, success: {
                    reqOp, mapResult in
                    dispatch_async(dispatch_get_main_queue(), {
                        self.navigationController?.popViewControllerAnimated(true)
                    })
                }, failure: {
                    reqOp, err in
                    print("Fail!")
                })
            }
        })
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        return true
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        return true
    }
    
    func textViewDidChange(textView: UITextView) {
        let hashTags = textView.resolveHashTags()
        if hashTags.count > 0 {
            print("Hashtags: \n\(hashTags)")
        }
    }
    
    
}