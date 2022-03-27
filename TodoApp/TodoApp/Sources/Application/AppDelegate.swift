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
    private var appCoordinator: AppCoordinator?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        // Setup MagicalRecord
        MagicalRecord.setupAutoMigratingCoreDataStack()
        
        // Set root
        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator?.start()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
        // Clean up data
        MagicalRecord.cleanUp()
    }
}

// MARK: - SUPPORT FUCTIONS
extension AppDelegate {
    
}
