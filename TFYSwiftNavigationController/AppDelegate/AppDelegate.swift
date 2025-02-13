//
//  AppDelegate.swift
//  TFYSwiftNavigationController
//
//  Created by 田风有 on 2021/5/15.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) {
            // iOS 13 以上使用 SceneDelegate
            return true
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            let tabBarController = TFYSwiftTaBbarController()
            window?.rootViewController = tabBarController
            window?.makeKeyAndVisible()
            return true
        }
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

