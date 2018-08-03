//
//  ItemCoreDataProperties.swift
//  Todo List
//
//  Created by David Solis on 8/2/18.
//  Copyright © 2018 Peaking. All rights reserved.
//

import Foundation
import CoreData

extension Item {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        let request = NSFetchRequest<Item>(entityName: "Item")
        
        request.sortDescriptors = [NSSortDescriptor(key: "text", ascending: true)]
        
        return request
    }
    
    @NSManaged public var text: String
    @NSManaged public var isCompleted: Bool
}
