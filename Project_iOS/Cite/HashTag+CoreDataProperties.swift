//
//  HashTag+CoreDataProperties.swift
//  Cite
//
//  Created by David Everlöf on 06/08/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension HashTag {
  
  @NSManaged var name: String?
  @NSManaged var quotes: NSSet?
  
}
