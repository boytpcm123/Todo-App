//
//  ItemNotedViewModel.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/27/22.
//

import Foundation

struct ItemNotedViewModel {
    
    private let itemNoted: ItemNoted
    
    init(itemNoted: ItemNoted) {
        self.itemNoted = itemNoted
    }
    
    func getId() -> Int32 {
        return Int32(itemNoted.id)
    }
    
    func getName() -> String {
        return itemNoted.name ?? ""
    }
    
    func getPrice() -> Int32 {
        return Int32(itemNoted.price ?? 0)
    }
    
    func getQuantity() -> Int32 {
        return Int32(itemNoted.quantity ?? 0)
    }
    
    func getType() -> Int32 {
        return Int32(itemNoted.type ?? 0)
    }
}
