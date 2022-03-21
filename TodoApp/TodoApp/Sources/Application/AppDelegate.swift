//
//  AppDelegate.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/19/22.
//

import UIKit
import CoreData
import MagicalRecord

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        // Setup MagicalRecord
        MagicalRecord.setupAutoMigratingCoreDataStack()
        
        // Set root
        setRootViewController(HomeScreenController())
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
        // Clean up data
        MagicalRecord.cleanUp()
    }
}

// MARK: - SUPPORT FUCTIONS
extension AppDelegate {
    
    private func setRootViewController(_ viewController: UIViewController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navVC: UINavigationController = UINavigationController(rootViewController: viewController)
        navVC.navigationBar.isHidden = true
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}
