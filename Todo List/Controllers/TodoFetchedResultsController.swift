//
//  TodoFetchedResultsController.swift
//  Todo List
//
//  Created by David Solis on 8/2/18.
//  Copyright © 2018 Peaking. All rights reserved.
//

import UIKit
import CoreData

class TodoFetchedResultsController: NSFetchedResultsController<Item>, NSFetchedResultsControllerDelegate {
    private let tableView: UITableView
    
    init(managedObjectContext: NSManagedObjectContext, tableView: UITableView) {
        self.tableView = tableView
        super.init(fetchRequest: Item.fetchRequest(),
                   managedObjectContext: managedObjectContext,
                   sectionNameKeyPath: nil,
                   cacheName: nil)
        self.delegate = self
        
        tryFetch()
    }
    
    func tryFetch() {
        do {
            try performFetch()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: - Fetched Results Controller Delegate
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
