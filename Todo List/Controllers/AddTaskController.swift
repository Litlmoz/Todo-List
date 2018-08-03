//
//  AddTaskController.swift
//  Todo List
//
//  Created by David Solis on 8/2/18.
//  Copyright © 2018 Peaking. All rights reserved.
//

import UIKit
import CoreData

class AddTaskController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        guard let item = NSEntityDescription.insertNewObject(forEntityName: "Item",
                                                             into: managedObjectContext) as? Item else {
                                                                fatalError("Failed to create Item instance")
        }
        item.text = text
        managedObjectContext.saveChanges()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
