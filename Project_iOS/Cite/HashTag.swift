//
//  HashTag.swift
//  Cite
//
//  Created by David Everlöf on 06/08/16.
//
//

import Foundation
import CoreData


class HashTag: RemoteEntity {

    static let mapping: RKEntityMapping = {
        let mapping = RKEntityMapping(
            forEntityForName: String(HashTag),
            inManagedObjectStore: appDelegate().managedObjectStore)
        
        mapping.identificationAttributes = [ "pk" ]
        mapping.addAttributeMappingsFromDictionary([
            "pk": "pk",
            "tag": "name"
        ])
        
        return mapping
    }()

    override class func rkSetupRouter() {
        RKObjectManager.sharedManager().router.routeSet.addRoute(RKRoute(withClass: HashTag.self, pathPattern: "/hashtags/:pk/", method: .GET))
        RKObjectManager.sharedManager().router.routeSet.addRoute(RKRoute(withClass: HashTag.self, pathPattern: "/hashtags/", method: .POST))
        RKObjectManager.sharedManager().router.routeSet.addRoute(RKRoute(withClass: HashTag.self, pathPattern: "/hashtags/:pk/", method: .PUT))
        RKObjectManager.sharedManager().router.routeSet.addRoute(RKRoute(withClass: HashTag.self, pathPattern: "/hashtags/:pk/", method: .DELETE))
    }
}
