//
//  AppDelegate.swift
//  Cite
//
//  Created by David Everlöf on 05/08/16.
//
//

import UIKit

func appDelegate() -> AppDelegate {
    return UIApplication.sharedApplication().delegate as! AppDelegate
}

private var SERVER_PROTOCOL: String =    "http"
private var SERVER_IP: String =          "127.0.0.1"
private var SERVER_PORT: String  =       "8000"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var loginManager: LoginManager! = nil
    
    var setup_controllers_once_token: dispatch_once_t = 0
    
    let mainTabBar = UITabBarController()
    
    var managedObjectStore: RKManagedObjectStore!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        setupRestkit()
        
        // We need to initialize restkit before we create `LoginManager`
        // Since we use it's HTTPClient
        loginManager = LoginManager()
        
        setupMainTabController()

        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func setupMainTabController() {
        dispatch_once(&setup_controllers_once_token) {
            var vcs = [UIViewController]()
            
            let quoteVC = QuoteViewController()
            let quoteNavVC = UINavigationController()
            quoteNavVC.setViewControllers([ quoteVC ], animated: false)
            quoteNavVC.tabBarItem.title = "Quotes"
            quoteNavVC.tabBarItem.image = UIImage(named: "ic_quotes")
            vcs.append(quoteNavVC)
            
            self.mainTabBar.setViewControllers(vcs, animated: false)
            
            if self.window == nil {
                self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            }
            
            if self.loginManager.loggedInUser == nil {
                self.window?.rootViewController = LoginViewController()
            } else {
                self.window?.rootViewController = self.mainTabBar
            }

        }
    }
    
    func setupRestkit() {
        
        let baseURL = NSURL(string: "\(SERVER_PROTOCOL)://\(SERVER_IP):\(SERVER_PORT)")
        let objectManager = RKObjectManager(baseURL: baseURL)
        
        AFNetworkActivityIndicatorManager.sharedManager().enabled = true
        
        let modelURL = NSBundle.mainBundle().URLForResource("Cite", withExtension: "momd")!
        
        let managedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL)!
        let managedObjectStore = RKManagedObjectStore(managedObjectModel: managedObjectModel)
        objectManager.managedObjectStore = managedObjectStore
        self.managedObjectStore = managedObjectStore
        
        //RKlcl_configure_by_name("RestKit/CoreData", RKlcl_vDebug.rawValue)
        //RKlcl_configure_by_name("RestKit/Network", RKlcl_vDebug.rawValue);
        //RKlcl_configure_by_name("RestKit/ObjectMapping", RKlcl_vDebug.rawValue);
        
        RKlcl_configure_by_name("RestKit/CoreData", RKlcl_vError.rawValue)
        RKlcl_configure_by_name("RestKit/Network", RKlcl_vError.rawValue);
        RKlcl_configure_by_name("RestKit/ObjectMapping", RKlcl_vError.rawValue);
        
        RKObjectManager.sharedManager().requestSerializationMIMEType = RKMIMETypeJSON
        
        User.rkSetupRouter()
        Quote.rkSetupRouter()
        HashTag.rkSetupRouter()
        
        // We print it, to force the lazy load of the static properties
        print(User.mapping)
        print(HashTag.mapping)
        print(Quote.mapping)
        
        managedObjectStore.createPersistentStoreCoordinator()
        let storePath = RKApplicationDataDirectory().stringByAppendingString("/Cite.sqlite")
        let _ = try! managedObjectStore.addSQLitePersistentStoreAtPath(storePath, fromSeedDatabaseAtPath: nil, withConfiguration: nil, options: nil)
        
        managedObjectStore.createManagedObjectContexts()
        
        managedObjectStore.managedObjectCache = RKInMemoryManagedObjectCache(managedObjectContext: managedObjectStore.persistentStoreManagedObjectContext)
    }
    
}

