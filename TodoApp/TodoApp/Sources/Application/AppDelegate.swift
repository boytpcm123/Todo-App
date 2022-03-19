//
//  AppDelegate.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/19/22.
//

import UIKit
import CoreData

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        // Set root
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.setRootViewController(HomeScreenController())
        
        return true
    }
    
    fileprivate func setRootViewController(_ viewController: UIViewController) {
        let navVC: UINavigationController = UINavigationController(rootViewController: viewController)
        navVC.setNavigationBarHidden(true, animated: true)
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
    }
}
