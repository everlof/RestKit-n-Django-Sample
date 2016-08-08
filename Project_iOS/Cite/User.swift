//
//  User.swift
//  Cite
//
//  Created by David Everlöf on 06/08/16.
//
//

import Foundation
import CoreData


class User: RemoteEntity {

    static let mapping: RKEntityMapping = {
        let mapping = RKEntityMapping(
            forEntityForName: String(User),
            inManagedObjectStore: appDelegate().managedObjectStore)
        
        mapping.identificationAttributes = [ "pk" ]
        mapping.addAttributeMappingsFromDictionary([
            "pk": "pk",
            "username": "username",
            "email": "email",
            "last_name": "lastName",
            "first_name": "firstName",
            "is_superuser": "isSuperuser",
            "avatar": "avatar",
        ])
        
        /*mapping.addPropertyMapping(
            RKRelationshipMapping(
                fromKeyPath: "friends",
                toKeyPath: "friends",
                withMapping: HashTag.mapping)
        )*/
        
        return mapping
    }()

    override class func rkSetupRouter() {
        RKObjectManager.sharedManager().addResponseDescriptorsFromArray([
            RKResponseDescriptor(
                mapping: mapping,
                method: .Any,
                pathPattern: "/users/:pk/",
                keyPath: nil,
                statusCodes: RKStatusCodeIndexSetForClass(.Successful)
            ),
            RKResponseDescriptor(
                mapping: mapping,
                method: .Any,
                pathPattern: "/users/",
                keyPath: nil,
                statusCodes: RKStatusCodeIndexSetForClass(.Successful)
            ),
            RKResponseDescriptor(
                mapping: mapping,
                method: .GET,
                pathPattern: "/me/",
                keyPath: nil,
                statusCodes: RKStatusCodeIndexSetForClass(.Successful)
            )
        ])
        
        RKObjectManager.sharedManager().addRequestDescriptorsFromArray([
            RKRequestDescriptor(
                mapping: mapping.inverseMapping(),
                objectClass: User.self,
                rootKeyPath: nil,
                method: .Any
            )
        ])
        
        RKObjectManager.sharedManager().router.routeSet.addRoutes([
            RKRoute(name: LoginManager.loginRoute, pathPattern: "/me/", method: .GET),
            RKRoute(withClass: User.self, pathPattern: "/users/:pk/", method: .GET),
            RKRoute(withClass: User.self, pathPattern: "/users/", method: .POST),
            RKRoute(withClass: User.self, pathPattern: "/users/:pk/", method: .PUT),
            RKRoute(withClass: User.self, pathPattern: "/users/:pk/", method: .DELETE)
        ])
    }
    
}
