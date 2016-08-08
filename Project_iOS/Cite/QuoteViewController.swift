//
//  ViewController.swift
//  Cite
//
//  Created by David Everlöf on 05/08/16.
//
//

import UIKit

class QuoteViewController: FetchedResultBaseController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(QuoteCell.self, forCellReuseIdentifier: QuoteCell.kReusableIdentifier)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetch = NSFetchRequest(entityName: String(Quote))
        do {
            let os = try RKObjectManager.sharedManager().managedObjectStore.mainQueueManagedObjectContext.executeFetchRequest(fetch) as! [Quote]
            
            for o in os {
                RKObjectManager.sharedManager().HTTPClient.setAuthorizationHeaderWithUsername("tester", password: "tester")
                if o.pk!.integerValue == 1 {
                    print(o)
                    
                    o.quote = "Du ser ut som en påse skridskor!"
                    RKObjectManager.sharedManager().putObject(o, path: nil, parameters: nil, success: {
                            a, b in
                            print("Success!")
                        }, failure: {
                            a, b in
                            print("Fail")
                    })
                    
                }
            }
            
        } catch {
            print(error)
        }
        
    }
    
    override func createFetchController() -> NSFetchedResultsController {
        let fetchRequest = NSFetchRequest(entityName: String(Quote))
        
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "quote", ascending: true)
        ]
        
        let fetchedResultsController =
            NSFetchedResultsController(
                fetchRequest: fetchRequest,
                managedObjectContext: RKObjectManager.sharedManager().managedObjectStore.mainQueueManagedObjectContext,
                sectionNameKeyPath: nil,
                cacheName: nil)
        
        return fetchedResultsController
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(QuoteCell.kReusableIdentifier, forIndexPath: indexPath) as? QuoteCell,
            let quote = self.fetchedResultController.objectAtIndexPath(indexPath) as? Quote
        {
            return cell.configureFor(quote)
        }
        
        return UITableViewCell()
    }
    
}

