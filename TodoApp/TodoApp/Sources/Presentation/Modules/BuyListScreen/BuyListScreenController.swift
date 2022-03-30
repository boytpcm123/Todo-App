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
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindLoadingUI()
        bindTableViewData()
        fetchBuyList()
    }
}

// MARK: - SUPPORT FUCTIONS
extension BuyListScreenController {
    
    private func bindLoadingUI() {
        
        buyListTableView.refreshControl = refreshControl
        refreshControl.rx
            .controlEvent(.valueChanged)
            .asObservable()
            .subscribe(onNext: { _ in
                self.fetchBuyList()
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
        
        viewModel.publishBuyList
            .catchAndReturn([])
            .bind(to:
                    buyListTableView.rx.items(
                        cellIdentifier: NoteListCell.dequeueIdentifier,
                        cellType: NoteListCell.self)) { _, itemNoted, cell in
                            cell.bindData(itemNoted)
                        }
                        .disposed(by: disposeBag)
        
        Observable.zip(buyListTableView.rx.modelSelected(ItemNotedViewModel.self),
                       buyListTableView.rx.itemSelected)
            .bind { [weak self] itemNoted, indexPath in
                self?.buyListTableView.deselectRow(at: indexPath, animated: true)
                print(itemNoted.getName())
            }
            .disposed(by: disposeBag)
    }
    
    private func fetchBuyList() {
        viewModel.fetchBuyList()
    }
}
