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
            
            let navigationBar = UINavigationBar.appearance()
            navigationBar.barTintColor = .red
            navigationBar.tintColor = .white
            navigationBar.barStyle = .black
            navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)
            ]

            window.makeKeyAndVisible()
        }
        guard let _ = (scene as? UIWindowScene) else { return }
    }


}

