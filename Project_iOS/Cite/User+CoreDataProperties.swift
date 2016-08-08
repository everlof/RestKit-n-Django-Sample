//
//  User+CoreDataProperties.swift
//  Cite
//
//  Created by David Everlöf on 08/08/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var email: String?
    @NSManaged var username: String?
    @NSManaged var lastName: String?
    @NSManaged var firstName: String?
    @NSManaged var isSuperuser: NSNumber?
    @NSManaged var avatar: String?
    @NSManaged var likes: NSSet?
    @NSManaged var quotes: NSSet?

}
