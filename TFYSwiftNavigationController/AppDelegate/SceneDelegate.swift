//
//  SceneDelegate.swift
//  TFYSwiftNavigationController
//
//  Created by 田风有 on 2021/5/15.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            let nav = UINavigationController(rootViewController: MainViewController())

            nav.navigation.configuration.isEnabled = true
            nav.navigation.configuration.barTintColor = UIColor.green
            nav.navigation.configuration.tintColor = UIColor.white
            
            if #available(iOS 11.0, *) {
                nav.navigation.configuration.prefersLargeTitles = true
                nav.navigation.configuration.largeTitle.displayMode = .never
            }
            
            let shadow = NavigationShadow(
                color: UIColor.black.cgColor,
                opacity: 0.5,
                offset: CGSize(width: 0, height: 3)
            )
            nav.navigation.configuration.shadow = shadow
            
            window.rootViewController = nav
            self.window = window
            window.makeKeyAndVisible()
        }
        guard let _ = (scene as? UIWindowScene) else { return }
    }


}

