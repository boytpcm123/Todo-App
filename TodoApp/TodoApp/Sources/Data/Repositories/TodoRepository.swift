//
//  TodoRepository.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/20/22.
//

import Foundation
import MagicalRecord
import RxSwift

struct TodoRepository {
    
    static let shared = TodoRepository()
    
    private init() {}
}

// MARK: - PUBLIC FUNCTIONS
extension TodoRepository {
    
    func addListItem(items: [ItemNoted]) {
        
        for item in items {
            if checkExistItem(item) {
                self.updateItem(item)
            } else {
                self.addItem(item)
            }
        }
    }
    
    func getSellList() -> Single<[ItemNoted]> {
        let itemSells = getItemSells()
        var sellList: [ItemNoted] = []
        for itemSell in itemSells {
            let itemNoted: ItemNoted = ItemNoted(id: Int(itemSell.id),
                                                 name: itemSell.nameItem,
                                                 price: Int(itemSell.price),
                                                 quantity: Int(itemSell.quantity),
                                                 type: Int(itemSell.type))
            sellList.append(itemNoted)
        }
        return Single<[ItemNoted]>.create { single in
            single(.success(sellList))
            return Disposables.create()
        }
    }
    
    func deleteItem(_ itemNoted: ItemNoted) -> Single<[ItemNoted]> {
        
        let itemId = itemNoted.id
        
        MagicalRecord.save(blockAndWait: { context in
            let predicate = NSPredicate(format: "id = '\(itemId)'")
            ItemSell.mr_deleteAll(matching: predicate, in: context)
        })
        
        return getSellList()
    }
}

// MARK: - SUPPORT FUNCTIONS
extension TodoRepository {
    
    private func addItem(_ item: ItemNoted) {
        
        MagicalRecord.save({ context in
            let entity = ItemSell.mr_createEntity(in: context)
            entity?.id = Int32(item.id)
            entity?.nameItem = item.name
            entity?.price = Int32(item.price ?? 0)
            entity?.quantity = Int32(item.quantity ?? 0)
            entity?.type = Int32(item.type ?? 0)
        })
    }
    
    private func checkExistItem(_ item: ItemNoted) -> Bool {
        
        let context = NSManagedObjectContext.mr_contextForCurrentThread()
        let predicate = NSPredicate(format: "id = '\(item.id)'")
        return ItemSell.mr_findFirst(with: predicate, in: context) != nil
    }
    
    private func updateItem(_ item: ItemNoted) {
        
        MagicalRecord.save({ context in
            let predicate = NSPredicate(format: "id = '\(item.id)'")
            guard let entity = ItemSell.mr_findFirst(with: predicate, in: context) else { return }
            entity.nameItem = item.name
            entity.price = Int32(item.price ?? 0)
            entity.quantity = Int32(item.quantity ?? 0)
            entity.type = Int32(item.type ?? 0)
        })
    }
    
    private func getItemSellById(_ itemId: String) -> ItemSell? {
        
        let context = NSManagedObjectContext.mr_contextForCurrentThread()
        let predicate = NSPredicate(format: "id = '\(itemId)'")
        if let itemSell = ItemSell.mr_findFirst(with: predicate, in: context) {
            return itemSell
        }
        return nil
    }
    
    private func getItemSells() -> [ItemSell] {
        
        let context = NSManagedObjectContext.mr_contextForCurrentThread()
        // swiftlint:disable:next force_unwrapping
        if let itemSells = ItemSell.mr_findAll(in: context)! as? [ItemSell] {
            return itemSells
        }
        return []
    }
}
