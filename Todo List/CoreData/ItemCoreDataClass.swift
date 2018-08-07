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
    
    @NSManaged public var text: String
    @NSManaged public var isCompleted: Bool
    @NSManaged public var color: Data?
    
    required convenience init(from decoder: Decoder) throws {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Item", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try container.decodeIfPresent(String.self, forKey: .text) ?? ""
        self.isCompleted = try container.decodeIfPresent(Bool.self, forKey: .isCompleted) ?? false
        self.color = try container.decodeIfPresent(Data.self, forKey: .color)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(text, forKey: .text)
        try container.encodeIfPresent(isCompleted, forKey: .isCompleted)
        try container.encodeIfPresent(color, forKey: .color)
    }
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
        case isCompleted = "is_completed"
        case color = "color"
    }
}
