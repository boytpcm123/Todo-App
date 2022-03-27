//
//  TodoRepository.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/20/22.
//

import Foundation
import MagicalRecord
import RxSwift

protocol TodoRepositoryProtocol {
    
    func addListItem(items: [ItemNotedViewModel])
    func getSellList() -> Single<[ItemNotedViewModel]>
    func deleteItem(_ itemNoted: ItemNotedViewModel) -> Single<[ItemNotedViewModel]>
}

struct TodoRepository: TodoRepositoryProtocol {
    
}

// MARK: - PUBLIC FUNCTIONS
extension TodoRepository {
    
    func addListItem(items: [ItemNotedViewModel]) {
        
        for item in items {
            if checkExistItem(item) {
                self.updateItem(item)
            } else {
                self.addItem(item)
            }
        }
    }
    
    func getSellList() -> Single<[ItemNotedViewModel]> {
        let itemSells = getItemSells()
        var sellList: [ItemNotedViewModel] = []
        for itemSell in itemSells {
            let itemNoted: ItemNoted = ItemNoted(id: Int(itemSell.id),
                                                 name: itemSell.nameItem,
                                                 price: Int(itemSell.price),
                                                 quantity: Int(itemSell.quantity),
                                                 type: Int(itemSell.type))
            let itemNotedViewModel = ItemNotedViewModel(itemNoted: itemNoted)
            sellList.append(itemNotedViewModel)
        }
        return Single<[ItemNotedViewModel]>.create { single in
            single(.success(sellList))
            return Disposables.create()
        }
    }
    
    func deleteItem(_ itemNoted: ItemNotedViewModel) -> Single<[ItemNotedViewModel]> {
        
        let itemId = itemNoted.getId()
        
        MagicalRecord.save(blockAndWait: { context in
            let predicate = NSPredicate(format: "id = '\(itemId)'")
            ItemSell.mr_deleteAll(matching: predicate, in: context)
        })
        
        return getSellList()
    }
}

// MARK: - SUPPORT FUNCTIONS
extension TodoRepository {
    
    private func addItem(_ item: ItemNotedViewModel) {
        
        MagicalRecord.save({ context in
            let entity = ItemSell.mr_createEntity(in: context)
            entity?.id = item.getId()
            entity?.nameItem = item.getName()
            entity?.price = item.getPrice()
            entity?.quantity = item.getQuantity()
            entity?.type = item.getType()
        })
    }
    
    private func checkExistItem(_ item: ItemNotedViewModel) -> Bool {
        
        let context = NSManagedObjectContext.mr_contextForCurrentThread()
        let predicate = NSPredicate(format: "id = '\(item.getId())'")
        return ItemSell.mr_findFirst(with: predicate, in: context) != nil
    }
    
    private func updateItem(_ item: ItemNotedViewModel) {
        
        MagicalRecord.save({ context in
            let predicate = NSPredicate(format: "id = '\(item.getId())'")
            guard let entity = ItemSell.mr_findFirst(with: predicate, in: context) else { return }
            entity.nameItem = item.getName()
            entity.price = item.getPrice()
            entity.quantity = item.getQuantity()
            entity.type = item.getType()
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
