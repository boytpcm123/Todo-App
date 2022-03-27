//
//  AppCoordinator.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/27/22.
//

import UIKit

struct AppCoordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewController = HomeScreenController()
        let navVC: UINavigationController = UINavigationController(rootViewController: viewController)
        navVC.navigationBar.isHidden = true
        window.rootViewController = navVC
        window.makeKeyAndVisible()
    }
}
