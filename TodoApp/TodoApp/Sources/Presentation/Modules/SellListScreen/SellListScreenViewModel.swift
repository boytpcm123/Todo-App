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
    
    func fetchBuyList() -> Observable<[ItemNoted]> {
        return Observable.create { observer in
            TodoRepository.shared.getSellList()
                .subscribe(onSuccess: { itemNoteds in
                    observer.onNext(itemNoteds)
                    observer.onCompleted()
                }, onFailure: { error in
                    observer.onError(error)
                })
                .disposed(by: disposeBag)
            return Disposables.create()
        }
    }
}
