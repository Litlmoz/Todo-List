//
//  ItemCoreDataClass.swift
//  Todo List
//
//  Created by David Solis on 8/2/18.
//  Copyright © 2018 Peaking. All rights reserved.
//

import UIKit
import CoreData

class Item: NSManagedObject, Codable {
    
    @NSManaged var text: String
    @NSManaged var isCompleted: Bool
    @NSManaged var color: Data?
    
    required convenience init(from decoder: Decoder) throws {
        let context = CoreDataStack.sharedInstance.context
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let entity = NSEntityDescription.entity(forEntityName: "Item", in: context) else {
            fatalError("Failed to intialize Item")
        }
        
        self.init(entity: entity, insertInto: context)
        
        self.text = try container.decode(String.self, forKey: .text)
        self.isCompleted = try container.decode(Bool.self, forKey: .isCompleted)
        self.color = try container.decodeIfPresent(Data.self, forKey: .color)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(text, forKey: .text)
        try container.encode(isCompleted, forKey: .isCompleted)
        try container.encodeIfPresent(color, forKey: .color)
    }
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
        case isCompleted = "is_completed"
        case color = "color"
    }
}
