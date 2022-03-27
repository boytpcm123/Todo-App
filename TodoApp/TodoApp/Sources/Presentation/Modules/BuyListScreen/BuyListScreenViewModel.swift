//
//  BuyListScreenViewModel.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/19/22.
//

import UIKit
import Moya
import RxSwift

struct BuyListScreenViewModel {
    
    // MARK: - PROPERTIES
    private let disposeBag = DisposeBag()
    private let todoNetworkManager: TodoNetworkManagerProtocol
    private let todoRepository: TodoRepositoryProtocol
    let showLoading = BehaviorSubject<Bool>(value: true)
    let publishBuyList = PublishSubject<[ItemNotedViewModel]>()
    
    init(todoNetworkManager: TodoNetworkManagerProtocol = TodoNetworkManager(),
         todoRepository: TodoRepositoryProtocol = TodoRepository()) {
        self.todoNetworkManager = todoNetworkManager
        self.todoRepository = todoRepository
    }
    
    func fetchBuyList() {
        
        todoNetworkManager.getBuyList()
            .map {
                $0.map {
                    ItemNotedViewModel(itemNoted: $0)
                }
            }
            .subscribe(onSuccess: { buyList in
                todoRepository.addListItem(items: buyList)
                publishBuyList.onNext(buyList)
                showLoading.onNext(false)
            }, onFailure: { error in
                publishBuyList.onError(error)
                showLoading.onNext(false)
            })
            .disposed(by: disposeBag)
    }
}
