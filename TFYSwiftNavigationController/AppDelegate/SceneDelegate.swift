//
//  SceneDelegate.swift
//  TFYSwiftNavigationController
//
//  Created by 田风有 on 2021/5/15.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // 创建窗口
        window = UIWindow(windowScene: windowScene)
        
        // 创建 TabBarController 作为根视图控制器
        let tabBarController = TFYSwiftTaBbarController()
        
        // 设置窗口的根视图控制器
        window?.rootViewController = tabBarController
        
        // 设置窗口为可见
        window?.makeKeyAndVisible()
    }
}

