//
//  BaseViewController.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/19/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - OUTLET
    
    // MARK: - PROPERTIES
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - CONFIG
extension BaseViewController {
    
    private func configView() {
        
        // Hide navigation bar
        self.navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - SUPPORT FUCTIONS
extension BaseViewController {
    
}

// MARK: - UIGestureRecognizerDelegate
extension BaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
