//
//  TodoListController.swift
//  Todo List
//
//  Created by David Solis on 8/2/18.
//  Copyright © 2018 Peaking. All rights reserved.
//

import UIKit
import CoreData

class TodoListController: UITableViewController {
    
    let managedObjectContext = CoreDataStack().managedObjectContext
    lazy var fetchedResultsController: TodoFetchedResultsController = {
        return TodoFetchedResultsController(managedObjectContext: managedObjectContext, tableView: tableView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - TableView Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else {
            return 0
        }
        return section.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        return configureCell(cell, at: indexPath)
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        let item = fetchedResultsController.object(at: indexPath)
        
        managedObjectContext.delete(item)
        managedObjectContext.saveChanges()
    }
    
    private func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) -> UITableViewCell {
        let item = fetchedResultsController.object(at: indexPath)
        
        cell.textLabel?.text = item.text
        
        return cell
    }
    
    // MARK: - UITableView Delegate
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newItem",
            let navigationController = segue.destination as? UINavigationController,
            let addTaskController = navigationController.topViewController as? AddTaskController {
            addTaskController.managedObjectContext = managedObjectContext
        } else if segue.identifier == "showDetail",
            let detailController = segue.destination as? DetailController,
            let indexPath = tableView.indexPathForSelectedRow {
            let item = fetchedResultsController.object(at: indexPath)
            
            detailController.item = item
            detailController.context = managedObjectContext
        }
    }
}
