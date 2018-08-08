//
//  CoreDataStack.swift
//  Todo List
//
//  Created by David Solis on 8/7/18.
//  Copyright © 2018 Peaking. All rights reserved.
//

import CoreData

extension Item {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Item> {
        let request = NSFetchRequest<Item>(entityName: "Item")
        
        request.sortDescriptors = [NSSortDescriptor(key: "text", ascending: true)]
        
        return request
    }
}

class CoreDataStack {
    
    private init() {}
    
    static let sharedInstance = CoreDataStack()
    
    lazy var context: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "Todo_List")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container.viewContext
    }()
}

extension NSManagedObjectContext {
    
    /// Saving support
    func saveChanges() {
        if self.hasChanges {
            do {
                try save()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
