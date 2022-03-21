//
//  CallListScreenController.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/19/22.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class CallListScreenController: BaseViewController {
    
    // MARK: - OUTLET
    @IBOutlet private weak var customNavigationBar: CustomNavigationBar! {
        didSet {
            self.customNavigationBar.title = "Call List"
            self.customNavigationBar.onLeftButtonAction = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBOutlet private weak var callListTableView: UITableView! {
        didSet {
            self.callListTableView.registerReusedCell(cellNib: CallListCell.self, bundle: nil)
            self.callListTableView.tableFooterView = UIView()
        }
    }
    
    // MARK: - PROPERTIES
    private var viewModel = CallListScreenViewModel()
    private let disposeBag = DisposeBag()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindLoadingUI()
        bindTableViewData()
        fetchCallList()
    }
}

// MARK: - SUPPORT FUCTIONS
extension CallListScreenController {
    
    private func bindLoadingUI() {
        
        callListTableView.refreshControl = refreshControl
        refreshControl.rx
            .controlEvent(.valueChanged)
            .asObservable()
            .subscribe(onNext: { _ in
                self.fetchCallList()
            })
            .disposed(by: disposeBag)
        
        viewModel.showLoading
            .subscribe(onNext: { isLoading in
                isLoading ? ProgressHUD.show() : ProgressHUD.dismiss()
                if self.refreshControl.isRefreshing && !isLoading {
                    self.refreshControl.endRefreshing()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func bindTableViewData() {
        
        viewModel.publishCallList
            .catchAndReturn([])
            .bind(to:
                    callListTableView.rx.items(
                        cellIdentifier: CallListCell.dequeueIdentifier,
                        cellType: CallListCell.self)) { _, userCall, cell in
                            cell.bindData(userCall)
                        }
                        .disposed(by: disposeBag)
        
        Observable.zip(callListTableView.rx.modelSelected(UserCall.self),
                       callListTableView.rx.itemSelected)
            .bind { userCall, indexPath in
                self.callListTableView.deselectRow(at: indexPath, animated: true)
                print(userCall.name.string)
            }
            .disposed(by: disposeBag)
        
    }
    
    private func fetchCallList() {
        viewModel.fetchCallList()
    }
}
