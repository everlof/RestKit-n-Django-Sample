//
//  RemoteEntity.swift
//  Cite
//
//  Created by David Everlöf on 06/08/16.
//
//

import Foundation
import CoreData


class RemoteEntity: NSManagedObject {
    
    class func newInCoreData<T: NSManagedObject>() -> T {
        return NSEntityDescription.insertNewObjectForEntityForName(String(T), inManagedObjectContext: RKObjectManager.sharedManager().managedObjectStore.mainQueueManagedObjectContext) as! T
    }

    class func rkMapping(store: RKManagedObjectStore) -> RKEntityMapping {
        fatalError()
    }

    class func rkSetupRouter() {
        fatalError()
    }
    
}
