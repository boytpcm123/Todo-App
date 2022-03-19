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
    
    // MARK: - PROPERTIES
    private var viewModel = HomeScreenViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
