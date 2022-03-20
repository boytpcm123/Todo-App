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
    public let publishCallList = PublishSubject<[UserCall]>()
    
    public func fetchCallList() {
        
        TodoNetworkManager.shared.getCallList()
            .subscribe(onSuccess: { callList in
                publishCallList.onNext(callList)
                showLoading.onNext(false)
            }, onFailure: { error in
                publishCallList.onError(error)
                showLoading.onNext(false)
            })
            .disposed(by: disposeBag)
    }
    
}
