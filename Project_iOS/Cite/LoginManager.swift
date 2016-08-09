//
//  LoginManager.swift
//  Cite
//
//  Created by David Everlöf on 08/08/16.
//
//

import Foundation

class LoginManager {
    
    static let loginRoute = "RK_LOGIN_ROUTE"
    
    static let kTokenKey = "kTokenKey"
    
    var token: String? {
        didSet {
            self.utilizeToken()
        }
    }
    
    var loggedInUser: User?
    
    init() {
        token = NSUserDefaults.standardUserDefaults().stringForKey(LoginManager.kTokenKey)
        
        if let t = token {
            print("Will use token: \(t)")
            utilizeToken()
        } else {
            print("No token present, maybe present login-view?")
        }
    }
    
    func utilizeToken() {
        NSUserDefaults.standardUserDefaults().setObject(self.token, forKey: LoginManager.kTokenKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        print("Set \(NSUserDefaults.standardUserDefaults().stringForKey(LoginManager.kTokenKey)) for NSUserDefault key: \(LoginManager.kTokenKey)")
        
        guard let token = self.token else {
            print("No token to utilize.")
            return
        }
        
        RKObjectManager.sharedManager().HTTPClient.setDefaultHeader("Authorization", value: "Token \(token)")
        RKObjectManager.sharedManager().getObjectsAtPathForRouteNamed(LoginManager.loginRoute, object: nil, parameters: nil, success: {
                op, mapResult in
                if let user = mapResult.firstObject as? User {
                    self.loggedInUser = user
                    print("\(user.username!) logged in")
                }
            }, failure: {
                op, err in
                print("Failed to log in user...")
                print(err)
                self.token = nil
        })
    }
    
    func appDidBecomeActive() {
        if let user = loggedInUser {
            print("Last \(user.username!) was logged in.")
        }
    }
    
    func loggedInUserInContext(context: NSManagedObjectContext) -> User? {
        var user: User? = nil
        
        context.performBlockAndWait({
            let fetchRequest = NSFetchRequest(entityName: String(User))
            fetchRequest.predicate = NSPredicate(format: "pk == %@", appDelegate().loginManager.loggedInUser!.pk!)
            
            do {
                user = (try context.executeFetchRequest(fetchRequest) as! [User]).first
            } catch {
                print("error: \(error)")
            }
        })
        
        return user
    }
    
    func login(username: String, password: String) {
        RKObjectManager.sharedManager().HTTPClient.postPath("api-token-auth/", parameters: [
            "username": username,
            "password": password
        ], success:
        {
            reqObj, any in
            if let result =  any as? [String: String],
                let gotToken = result["token"] {
                print("Got token: \(gotToken)")
                self.token = gotToken
            }
        }, failure: {
                reqOp, err in
        })
    }
 
}