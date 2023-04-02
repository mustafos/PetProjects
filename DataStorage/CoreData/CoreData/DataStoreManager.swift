//
//  DataStoreManager.swift
//  DataStorage
//
//  Created by Mustafa Bekirov on 31.03.2023.
//

import Foundation
import CoreData

class DataStoreManager {
    
    // MARK: - Core Data stack
    
    lazy var dataFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "DataStorage")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    lazy var viewContex: NSManagedObjectContext = persistentContainer.viewContext
    lazy var backgroundContext: NSManagedObjectContext = persistentContainer.newBackgroundContext()
    
    // MARK: - CRUD
    
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
    
    func obtainMainUser() -> User {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "isMain = true")
        
        if let users = try? viewContext.fetch(fetchRequest) as? [User], !users.isEmpty {
            return users.first!
        } else {
            let company = Company(context: viewContext)
            company.name = "Apple Inc."
            
            let user = User(context: viewContext)
            user.name = "Mark777"
            user.age = 23
            user.company = company
            user.isMain = true
            
            do {
                try viewContext.save()
            } catch let error {
                print("Error: \(error)")
            }
            
            return user
        }
    }
    
    func updateMainUser(with name: String) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "isMain = true")
        
        if let users = try? viewContext.fetch(fetchRequest) as? [User] {
            
            guard let mainUser = users.first else { return }
            
            mainUser.name = name
            
            try? viewContext.save()
        }
    }
    
    func removeMainUser() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "isMain = true")
        
        if let users = try? backgroundContext.fetch(fetchRequest) as? [User] {
            
            guard let mainUser = users.first else { return }
            
            backgroundContext.delete(mainUser)
            
            try? backgroundContext.save()
        }
    }
}
