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
            self.callListTableView.delegate = self
            self.callListTableView.dataSource = self
            self.callListTableView.tableFooterView = UIView()
        }
    }
    
    // MARK: - PROPERTIES
    private var viewModel = HomeScreenViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CallListScreenController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusable(cellNib: CallListCell.self, indexPath: indexPath) else {
            return UITableViewCell()
        }
        return cell
    }
}

extension CallListScreenController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select cell")
    }
}
