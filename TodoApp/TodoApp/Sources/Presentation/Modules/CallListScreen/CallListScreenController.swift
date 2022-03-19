//
//  CallListScreenController.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/19/22.
//

import UIKit
import RxSwift
import RxCocoa

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
    private var userCalls: [UserCall] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindCallListData()
    }
}

// MARK: - SUPPORT FUCTIONS
extension CallListScreenController {
    
    private func bindCallListData() {
        viewModel.fetchCallList()
            .bind(to:
                    callListTableView.rx.items(
                        cellIdentifier: CallListCell.dequeueIdentifier,
                        cellType: CallListCell.self)) { _, model, cell in
                            cell.bindData(model)
                        }
                        .disposed(by: disposeBag)
    }
}
