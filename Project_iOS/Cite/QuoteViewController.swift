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
        
        self.navigationItem.title = "Quotes"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Add",
            style: .Plain,
            target: self,
            action: #selector(addNewQuote)
        )
        
        self.tableView.registerClass(QuoteCell.self, forCellReuseIdentifier: QuoteCell.kReusableIdentifier)
    }
    
    func addNewQuote() {
        self.navigationController?.pushViewController(AddQuoteViewController(), animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        RKObjectManager.sharedManager().getObjectsAtPathForRouteNamed(Quote.listName, object: nil, parameters: nil, success: {
                reqOp, mapping in
                print("Quotes listed successfully!")
        }, failure: {
                reqOp, err in
                print("Fail")
        })
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

