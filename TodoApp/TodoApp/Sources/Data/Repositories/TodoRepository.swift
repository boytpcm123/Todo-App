//
//  TodoRepository.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/20/22.
//

import Foundation
import MagicalRecord

class TodoRepository: NSObject {
    
    func addProduct(itemNoted: ItemNoted) {
        MagicalRecord.save { (context) -> Void in
            var entity = ItemSell.mr_create(in: context)
            entity.id = itemNoted.id
            entity.name = itemNoted.name
            entity.price = itemNoted.price
            entity.quantity = itemNoted.quantity
            entity.type = itemNoted.type
        }
    }
    
    func updateProduct(product: ItemNoted) {
        MagicalRecord.saveUsingCurrentThreadContextWithBlockAndWait { (context) -> Void in
            var predicate = NSPredicate(format: "id = '\(product.id)'")
            if var entity = ItemSell.MR_findFirstWithPredicate(predicate, inContext: context) as? Product {
                entity.name = product.name
                entity.price = product.price
            }
        }
    }
    
    func deleteProduct(productId: String) {
        MagicalRecord.saveUsingCurrentThreadContextWithBlockAndWait { (context) -> Void in
            var predicate = NSPredicate(format: "id = '\(productId)'")
            ItemSell.MR_deleteAllMatchingPredicate(predicate, inContext: context)
        }
    }
    
    func getProductById(productId: String) -> ItemSell? {
        var context = NSManagedObjectContext.MR_contextForCurrentThread()
        var predicate = NSPredicate(format: "id = '\(productId)'")
        if let product = ItemSell.MR_findFirstWithPredicate(predicate, inContext: context) as? Product {
            return product
        }
        return nil
    }
    
    func getProducts() -> [ItemSell]? {
        var context = NSManagedObjectContext.MR_contextForCurrentThread()
        
        if let products = ItemSell.MR_findAllInContext(context) as [Product]? {
            return products
        }
        return nil
    }
    
}
