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
    let showLoading = BehaviorSubject<Bool>(value: true)
    let publishSellList = PublishSubject<[ItemNoted]>()
    
    func fetchSellList() {
        
        TodoRepository.shared.getSellList()
            .subscribe(onSuccess: { itemNoteds in
                publishSellList.onNext(itemNoteds)
                showLoading.onNext(false)
            }, onFailure: { error in
                publishSellList.onError(error)
                showLoading.onNext(false)
            })
            .disposed(by: disposeBag)
    }
}
