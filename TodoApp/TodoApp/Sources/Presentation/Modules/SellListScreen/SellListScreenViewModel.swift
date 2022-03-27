//
//  SellListScreenViewModel.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/19/22.
//

import UIKit
import Moya
import RxSwift

struct SellListScreenViewModel {
    
    // MARK: - PROPERTIES
    private let disposeBag = DisposeBag()
    private let todoRepository: TodoRepositoryProtocol
    let showLoading = BehaviorSubject<Bool>(value: true)
    let publishSellList = PublishSubject<[ItemNotedViewModel]>()
    
    init(todoRepository: TodoRepositoryProtocol = TodoRepository()) {
        self.todoRepository = todoRepository
    }
    
    func fetchSellList() {
        
        todoRepository.getSellList()
            .subscribe(onSuccess: { itemNoteds in
                publishSellList.onNext(itemNoteds)
                showLoading.onNext(false)
            }, onFailure: { error in
                publishSellList.onError(error)
                showLoading.onNext(false)
            })
            .disposed(by: disposeBag)
    }
    
    func deleteSellItem(_ itemNoted: ItemNotedViewModel) {
        
        todoRepository.deleteItem(itemNoted)
            .subscribe(onSuccess: { itemNoteds in
                publishSellList.onNext(itemNoteds)
            }, onFailure: { error in
                publishSellList.onError(error)
            })
            .disposed(by: disposeBag)
    }
}
