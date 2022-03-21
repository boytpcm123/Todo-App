//
//  SellListScreenController.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/19/22.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class SellListScreenController: BaseViewController {
    
    // MARK: - OUTLET
    @IBOutlet private weak var customNavigationBar: CustomNavigationBar! {
        didSet {
            self.customNavigationBar.title = "Sell List"
            self.customNavigationBar.onLeftButtonAction = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBOutlet private weak var sellListTableView: UITableView! {
        didSet {
            self.sellListTableView.registerReusedCell(cellNib: NoteListCell.self, bundle: nil)
            self.sellListTableView.tableFooterView = UIView()
        }
    }
    
    // MARK: - PROPERTIES
    private var viewModel = SellListScreenViewModel()
    private let disposeBag = DisposeBag()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindLoadingUI()
        bindTableViewData()
        fetchSellList()
    }
}

// MARK: - SUPPORT FUCTIONS
extension SellListScreenController {
    
    private func bindLoadingUI() {
        
        sellListTableView.refreshControl = refreshControl
        refreshControl.rx
            .controlEvent(.valueChanged)
            .asObservable()
            .subscribe(onNext: { _ in
                self.fetchSellList()
            })
            .disposed(by: disposeBag)
        
        viewModel.showLoading
            .subscribe(onNext: { isLoading in
                if self.refreshControl.isRefreshing && !isLoading {
                    self.refreshControl.endRefreshing()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func bindTableViewData() {
        
        viewModel.publishSellList
            .catchAndReturn([])
            .bind(to:
                    sellListTableView.rx.items(
                        cellIdentifier: NoteListCell.dequeueIdentifier,
                        cellType: NoteListCell.self)) { _, itemNoted, cell in
                            cell.bindData(itemNoted)
                        }
                        .disposed(by: disposeBag)
        
        Observable.zip(sellListTableView.rx.modelSelected(ItemNoted.self),
                       sellListTableView.rx.itemSelected)
            .bind { [weak self] itemNoted, indexPath in
                self?.sellListTableView.deselectRow(at: indexPath, animated: true)
                print(itemNoted.name.string)
            }
            .disposed(by: disposeBag)
        
        sellListTableView.rx.modelDeleted(ItemNoted.self)
            .bind { [weak self] itemNoted in
                self?.viewModel.deleteSellItem(itemNoted)
            }
            .disposed(by: disposeBag)
    }
    
    private func fetchSellList() {
        viewModel.fetchSellList()
    }
}
