//
//  AppDelegate.swift
//  RandomUserPractical
//
//  Created by Paresh Kacha on 30/05/22.
//

import UIKit
import IQKeyboardManager
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared().isEnabled = true
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = MainNavigationController(rootViewController: ULRouter.createModule())
        self.window?.makeKeyAndVisible()
        return true
    }
}

