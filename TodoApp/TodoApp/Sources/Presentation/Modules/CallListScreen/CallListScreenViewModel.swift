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
    
    func fetchCallList() -> Observable<[UserCall]> {
        return Observable.create { observer in
            TodoNetworkManager.shared.getCallList()
                .subscribe(onSuccess: { userCalls in
                    observer.onNext(userCalls)
                    observer.onCompleted()
                }, onFailure: { error in
                    observer.onError(error)
                })
                .disposed(by: disposeBag)
            return Disposables.create()
        }
    }
    
}
