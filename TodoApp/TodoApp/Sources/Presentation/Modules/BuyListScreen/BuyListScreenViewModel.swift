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
    let showLoading = BehaviorSubject<Bool>(value: true)
    let publishBuyList = PublishSubject<[ItemNoted]>()
    
    func fetchBuyList() {
        
        TodoNetworkManager.shared.getBuyList()
            .subscribe(onSuccess: { buyList in
                TodoRepository.shared.addListItem(items: buyList)
                publishBuyList.onNext(buyList)
                showLoading.onNext(false)
            }, onFailure: { error in
                publishBuyList.onError(error)
                showLoading.onNext(false)
            })
            .disposed(by: disposeBag)
    }
}
