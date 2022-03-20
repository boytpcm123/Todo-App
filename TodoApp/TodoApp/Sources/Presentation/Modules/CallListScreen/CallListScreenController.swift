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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindCallListData()
    }
}

// MARK: - SUPPORT FUCTIONS
extension CallListScreenController {
    
    private func bindCallListData() {
        
        viewModel.showLoading
            .subscribe(onNext: { isLoading in
                isLoading ? ProgressHUD.show() : ProgressHUD.dismiss()
            })
            .disposed(by: disposeBag)
        
        viewModel.fetchCallList()
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
            .bind { [weak self] userCall, indexPath in
                self?.callListTableView.deselectRow(at: indexPath, animated: true)
                print(userCall.name.string)
            }
            .disposed(by: disposeBag)
    }
}
