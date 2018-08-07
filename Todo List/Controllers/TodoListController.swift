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
    
    lazy var dataSource: DataSource = {
        return DataSource(tableView: tableView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
    }
    
    // MARK: - UITableView Delegate
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail",
            let detailController = segue.destination as? DetailController,
            let indexPath = tableView.indexPathForSelectedRow {
            let item = dataSource.object(at: indexPath)
            
            detailController.item = item
        }
    }
}
