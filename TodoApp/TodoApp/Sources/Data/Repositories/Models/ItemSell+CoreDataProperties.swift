//
//  ItemSell+CoreDataProperties.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/21/22.
//
//

import Foundation
import CoreData

extension ItemSell {
    
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<ItemSell> {
        return NSFetchRequest<ItemSell>(entityName: "ItemSell")
    }
    
    @NSManaged public var id: Int32
    @NSManaged public var nameItem: String?
    @NSManaged public var price: Int32
    @NSManaged public var quantity: Int32
    @NSManaged public var type: Int32
    
}
