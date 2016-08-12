//
//  Quote.swift
//  Cite
//
//  Created by David Everlöf on 06/08/16.
//
//

import Foundation
import CoreData


class Quote: RemoteEntity {
    
    static let listName = "LIST_QUOTES"
    
    static let mapping: RKEntityMapping = {
        let mapping = RKEntityMapping(
            forEntityForName: String(Quote),
            inManagedObjectStore: appDelegate().managedObjectStore)
        
        mapping.identificationAttributes = [ "pk" ]
        mapping.addAttributeMappingsFromDictionary([
            "pk": "pk",
            "quote": "quote",
            "author": "author",
            "created": "created",
            "modified": "modified",
        ])
        
        mapping.addPropertyMapping(
            RKRelationshipMapping(
                fromKeyPath: "likers",
                toKeyPath: "likers",
                withMapping: User.mapping)
        )
        
        mapping.addPropertyMapping(
            RKRelationshipMapping(
                fromKeyPath: "owner",
                toKeyPath: "owner",
                withMapping: User.mapping)
        )
        
        mapping.addPropertyMapping(
            RKRelationshipMapping(
                fromKeyPath: "hashtags",
                toKeyPath: "hashtags",
                withMapping: HashTag.mapping)
        )
        
        return mapping
    }()

    static let reqMapping: RKEntityMapping = {
        let mapping = RKEntityMapping(
            forEntityForName: String(Quote),
            inManagedObjectStore: appDelegate().managedObjectStore)
        
        mapping.identificationAttributes = [ "pk" ]
        mapping.addAttributeMappingsFromDictionary([
            "pk": "pk",
            "quote": "quote",
            "author": "author",
            "owner": "owner.pk"
        ])
        
        return mapping
    }()

    
    override class func rkSetupRouter() {
        RKObjectManager.sharedManager().addResponseDescriptorsFromArray([
            RKResponseDescriptor(
                mapping: mapping,
                method: .Any,
                pathPattern: "/quotes/:pk/",
                keyPath: nil,
                statusCodes: RKStatusCodeIndexSetForClass(.Successful)
            ),
            RKResponseDescriptor(
                mapping: mapping,
                method: .Any,
                pathPattern: "/quotes/",
                keyPath: nil,
                statusCodes: RKStatusCodeIndexSetForClass(.Successful)
            )
        ])
        
        RKObjectManager.sharedManager().addRequestDescriptorsFromArray([
            RKRequestDescriptor(
                mapping: reqMapping.inverseMapping(),
                objectClass: Quote.self,
                rootKeyPath: nil,
                method: .Any
            )
        ])
        
        RKObjectManager.sharedManager().router.routeSet.addRoutes([
            RKRoute(name: Quote.listName, pathPattern: "/quotes/", method: .GET),
            RKRoute(withClass: Quote.self, pathPattern: "/quotes/:pk/", method: .GET),
            RKRoute(withClass: Quote.self, pathPattern: "/quotes/", method: .POST),
            RKRoute(withClass: Quote.self, pathPattern: "/quotes/:pk/", method: .PUT),
            RKRoute(withClass: Quote.self, pathPattern: "/quotes/:pk/", method: .DELETE)
        ])
    }
    
}
