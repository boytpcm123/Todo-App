//
//  BuyListScreenController.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/19/22.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class BuyListScreenController: BaseViewController {
    
    // MARK: - OUTLET
    @IBOutlet private weak var customNavigationBar: CustomNavigationBar! {
        didSet {
            self.customNavigationBar.title = "Buy List"
            self.customNavigationBar.onLeftButtonAction = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBOutlet private weak var buyListTableView: UITableView! {
        didSet {
            self.buyListTableView.registerReusedCell(cellNib: NoteListCell.self, bundle: nil)
            self.buyListTableView.tableFooterView = UIView()
        }
    }
    
    // MARK: - PROPERTIES
    private var viewModel = BuyListScreenViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindBuyListData()
    }
}

// MARK: - SUPPORT FUCTIONS
extension BuyListScreenController {
    
    private func bindBuyListData() {
        
        viewModel.showLoading
            .subscribe(onNext: { isLoading in
                isLoading ? ProgressHUD.show() : ProgressHUD.dismiss()
            })
            .disposed(by: disposeBag)
        
        viewModel.fetchBuyList()
            .catchAndReturn([])
            .bind(to:
                    buyListTableView.rx.items(
                        cellIdentifier: NoteListCell.dequeueIdentifier,
                        cellType: NoteListCell.self)) { _, itemNoted, cell in
                            cell.bindData(itemNoted)
                        }
                        .disposed(by: disposeBag)
        
        Observable.zip(buyListTableView.rx.modelSelected(ItemNoted.self),
                       buyListTableView.rx.itemSelected)
            .bind { [weak self] itemNoted, indexPath in
                self?.buyListTableView.deselectRow(at: indexPath, animated: true)
                print(itemNoted.name.string)
            }
            .disposed(by: disposeBag)
    }
}
