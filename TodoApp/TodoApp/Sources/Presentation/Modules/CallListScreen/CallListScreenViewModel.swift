//
//  CallListScreenViewModel.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/19/22.
//

import UIKit
import Moya
import RxSwift

struct CallListScreenViewModel {
    
    // MARK: - PROPERTIES
    private let disposeBag = DisposeBag()
    let showLoading = BehaviorSubject<Bool>(value: true)
    
    func fetchCallList() -> Observable<[UserCall]> {
        return Observable.create { observer in
            TodoNetworkManager.shared.getCallList()
                .subscribe(onSuccess: { userCalls in
                    observer.onNext(userCalls)
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
