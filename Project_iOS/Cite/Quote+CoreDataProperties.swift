//
//  Quote+CoreDataProperties.swift
//  Cite
//
//  Created by David Everlöf on 12/08/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Quote {
  
  @NSManaged var author: String?
  @NSManaged var quote: String?
  @NSManaged var created: NSDate?
  @NSManaged var modified: NSDate?
  @NSManaged var hashtags: NSSet?
  @NSManaged var likers: NSSet?
  @NSManaged var owner: User?
  
}
