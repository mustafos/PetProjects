//
//  TableViewController.swift
//  CoreData2
//
//  Created by Mustafa Bekirov on 31.03.2023.
//

import UIKit
import CoreData

// MARK: - Core Data stack

var persistentContainer: NSPersistentCloudKitContainer = {
    
    let container = NSPersistentCloudKitContainer(name: "CoreData2")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
        
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
}()

// MARK: - Core Data Saving support

func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var fetchResultController: NSFetchedResultsController<User>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(User.firstName), ascending: true)
        
        fetchRequest.fetchLimit = 15
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchResultController.delegate = self
        
        try! fetchResultController.performFetch()
    }
    
    @IBAction func addPressed(_ sender: Any) {
        let user = User(context: persistentContainer.viewContext)
        user.firstName = "Name \(Int.random(in: 0 ..< Int.max))"
        user.avatar = UIImage(named: "autism")
        
        let book = Book(context: persistentContainer.viewContext)
        book.name = "Some book"
        
        user.book = book
        
        saveContext()
        
        tableView.reloadData()
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            case .insert:
                if indexPath != nil {
                    tableView.insertRows(at: [indexPath!], with: .automatic)
                }
                
            case .delete:
                tableView.deleteRows(at: [indexPath!], with: .middle)
                
            default:
                break
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionInfo = fetchResultController.sections?[section]
        
        return sectionInfo?.numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let user = fetchResultController.object(at: indexPath)
        
        cell.textLabel?.text = user.firstName
        cell.detailTextLabel?.text = user.book?.name
        cell.imageView?.image = user.avatar
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let user = fetchResultController.object(at: indexPath)
            persistentContainer.viewContext.delete(user)
            saveContext()
        }
    }
}
