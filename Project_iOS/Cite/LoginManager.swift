//
//  LoginManager.swift
//  Cite
//
//  Created by David Everlöf on 08/08/16.
//
//

import Foundation

class LoginManager {
    
    enum LoginEvent: String {
        case LogOut = "LogOut"
        case LogIn = "LogIn"
    }
    
    static let kLoginChange = "LoginChangeNotification"
    
    static let kLoginChangeUserInfoEventKey = "LoginEvent"
    
    static let loginRoute = "RK_LOGIN_ROUTE"
    
    static let kUserKey = "kUserPKKey"
    
    private var _loggedInUser: User?
    var loggedInUser: User? {
        get {
            return _loggedInUser
        }
        set (newVal) {
            if let token = newVal?.token {
                RKObjectManager.sharedManager().HTTPClient.setDefaultHeader("Authorization", value: "Token \(token)")
            }
            
            if newVal == nil {
                NSNotificationCenter.defaultCenter().postNotificationName(LoginManager.kLoginChange, object: nil, userInfo: [LoginManager.kLoginChangeUserInfoEventKey: LoginEvent.LogOut.rawValue])
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName(LoginManager.kLoginChange, object: nil, userInfo: [LoginManager.kLoginChangeUserInfoEventKey: LoginEvent.LogIn.rawValue])
            }
            
            _loggedInUser = newVal
        }
    }
    
    init() {
        
        // If we we're logged in before - we will use that (untill token is proven bad)
        if let userPK = NSUserDefaults.standardUserDefaults().objectForKey(LoginManager.kUserKey) as? NSNumber {
            let fetchRequest = NSFetchRequest(entityName: String(User))
            fetchRequest.predicate = NSPredicate(format: "pk == %@", userPK)
            
            do {
                let user = try (RKObjectManager.sharedManager().managedObjectStore.mainQueueManagedObjectContext.executeFetchRequest(fetchRequest) as! [User]).first
                self.loggedInUser = user
            } catch {
                print("error: \(error)")
            }
        }
        
        checkToken(nil, ok: nil, notOk: nil)
    }
    
    func checkToken(token: String?, ok: (() -> Void)?, notOk: (() -> Void)?) {
        
        // Default is to use the provided token - if one was provided
        var tokenToUse = token
        
        // If token wasnt provided, and user has token, we use that
        if let userToken = loggedInUser?.token where tokenToUse == nil {
            tokenToUse = userToken
        }
        
        if tokenToUse == nil {
            self.loggedInUser = nil
            NSUserDefaults.standardUserDefaults().removeObjectForKey(LoginManager.kUserKey)
            notOk?()
            return
        }
        
        RKObjectManager.sharedManager().HTTPClient.setDefaultHeader("Authorization", value: "Token \(tokenToUse!)")
        RKObjectManager.sharedManager().getObjectsAtPathForRouteNamed(LoginManager.loginRoute, object: nil, parameters: nil, success: {
                op, mapResult in
                if let user = mapResult.firstObject as? User {
                    // Persist user PK in NSUserDefault
                    NSUserDefaults.standardUserDefaults().setObject(user.pk!, forKey: LoginManager.kUserKey)
                    
                    print("Token OK - \(user.username!) logged in")
                    
                    self.loggedInUser = user
                    
                    RKObjectManager.sharedManager().managedObjectStore.mainQueueManagedObjectContext.performBlockAndWait({
                        self.loggedInUser?.token = tokenToUse
                        
                        do {
                            try RKObjectManager.sharedManager().managedObjectStore.mainQueueManagedObjectContext.saveToPersistentStore()
                        } catch {
                            print("error: \(error)")
                        }
                    })
                    
                    ok?()
                }
            }, failure: {
                op, err in
                print("Token NOT OK")
                print(err)
                NSUserDefaults.standardUserDefaults().removeObjectForKey(LoginManager.kUserKey)
                self.loggedInUser = nil
                notOk?()
        })
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
    
    func login(username: String, password: String, ok: (() -> Void)?, notOk: (() -> Void)?) {
        RKObjectManager.sharedManager().HTTPClient.postPath("api-token-auth/", parameters: [
            "username": username,
            "password": password
        ], success:
        {
            reqObj, any in
            if let result =  any as? [String: String],
                let gotToken = result["token"] {
                print("Got token: \(gotToken), will now check it, to get the user details etc.")
                self.checkToken(gotToken, ok: {
                    ok?()
                }, notOk: {
                    notOk?()
                })
            }
        }, failure: {
            reqOp, err in
            notOk?()
        })
    }
 
}