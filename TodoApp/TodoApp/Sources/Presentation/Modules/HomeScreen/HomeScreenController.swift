//
//  HomeScreenController.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/19/22.
//

import UIKit
import RxSwift
import RxCocoa

class HomeScreenController: BaseViewController {
    
    // MARK: - OUTLET
    @IBOutlet private weak var callListBtn: UIButton!
    @IBOutlet private weak var buyListBtn: UIButton!
    @IBOutlet private weak var sellListBtn: UIButton!
    
    // MARK: - PROPERTIES
    private var viewModel = HomeScreenViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindCallListButton()
        bindBuyListButton()
        bindSellListButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - SUPPORT FUCTIONS
extension HomeScreenController {
    
    fileprivate func bindCallListButton() {
        callListBtn.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                let callListVC = CallListScreenController()
                self.navigationController?.pushViewController(callListVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func bindBuyListButton() {
        buyListBtn.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                print("Buy call list button")
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func bindSellListButton() {
        sellListBtn.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                print("Sell call list button")
            })
            .disposed(by: disposeBag)
    }
    
}
