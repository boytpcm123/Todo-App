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
    
    func fetchBuyList() -> Observable<[ItemNoted]> {
        return Observable.create { observer in
            TodoNetworkManager.shared.getBuyList()
                .subscribe(onSuccess: { listItem in
                    TodoRepository.shared.addListItem(items: listItem)
                    observer.onNext(listItem)
                    showLoading.onNext(false)
                }, onFailure: { error in
                    observer.onError(error)
                    showLoading.onNext(false)
                })
                .disposed(by: disposeBag)
            return Disposables.create()
        }
    }
    
}
