//
//  SellListScreenController.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/19/22.
//

import UIKit
import RxSwift
import RxCocoa

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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindBuyListData()
    }
}

// MARK: - SUPPORT FUCTIONS
extension SellListScreenController {
    
    private func bindBuyListData() {
        viewModel.fetchBuyList()
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
    }
}
