//
//  CallListScreenController.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/19/22.
//

import UIKit

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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
