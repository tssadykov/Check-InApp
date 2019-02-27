//
//  AppDelegate.swift
//  Check-InApp
//
//  Created by Тимур on 07/12/2018.
//  Copyright © 2018 Тимур. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootAssembly = RootAssembly()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            rootAssembly.presentationAssembly.getRegisterVC().wrappedInNavigation.withTabbarItem(with: "airplaneTab"),
            rootAssembly.presentationAssembly.getDataRegisterVC().withTabbarItem(with: "id-card")
        ]
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        return true
    }
}
