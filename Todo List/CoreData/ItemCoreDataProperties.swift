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
        return NSFetchRequest<Item>(entityName: "Item")
    }
    
    @NSManaged public var text: String
    @NSManaged public var isCompleted: Bool
}
