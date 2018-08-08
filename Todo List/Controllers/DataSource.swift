//
//  DataSource.swift
//  Todo List
//
//  Created by David Solis on 8/2/18.
//  Copyright © 2018 Peaking. All rights reserved.
//

import UIKit
import CoreData

class DataSource: NSObject, UITableViewDataSource {
    
    private let tableView: UITableView
    lazy var fetchedResultsController: TodoFetchedResultsController = {
        return TodoFetchedResultsController(tableView: tableView)
    }()
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func object(at indexPath: IndexPath) -> Item {
        return fetchedResultsController.object(at: indexPath)
    }
    
    // MARK: - TableView Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else {
            return 0
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        return configureCell(cell, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        let context = CoreDataStack.sharedInstance.context
        let item = fetchedResultsController.object(at: indexPath)
        
        context.delete(item)
        context.saveChanges()
    }
    
    private func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) -> UITableViewCell {
        let item = fetchedResultsController.object(at: indexPath)
        
        cell.textLabel?.text = item.text
        if item.isCompleted {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        } else {
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }
        
        return cell
    }
}
