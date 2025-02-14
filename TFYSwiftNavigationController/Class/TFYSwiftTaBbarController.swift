//
//  TFYSwiftTaBbarController.swift
//  TFYSwiftNavigationController
//
//  Created by mi ni on 2025/2/13.
//

import UIKit

class TFYSwiftTaBbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAppearance()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        // 创建三个导航控制器和对应的视图控制器
        let oneVC = TFYSwiftOneViewController()
        oneVC.title = "基础功能"
        let oneNav = TFYSwiftNavigationController(rootViewController: oneVC)
        oneNav.tabBarItem = UITabBarItem(title: "基础", image: UIImage(systemName: "1.circle"), selectedImage: UIImage(systemName: "1.circle.fill"))
        
        let twoVC = TFYSwiftTenViewController()
        twoVC.title = "样式切换"
        let twoNav = TFYSwiftNavigationController(rootViewController: twoVC)
        twoNav.tabBarItem = UITabBarItem(title: "样式", image: UIImage(systemName: "2.circle"), selectedImage: UIImage(systemName: "2.circle.fill"))
        
        let threeVC = TFYSwiftTherrViewController()
        threeVC.title = "高级特性"
        let threeNav = TFYSwiftNavigationController(rootViewController: threeVC)
        threeNav.tabBarItem = UITabBarItem(title: "高级", image: UIImage(systemName: "3.circle"), selectedImage: UIImage(systemName: "3.circle.fill"))
        
        // 设置视图控制器数组
        self.viewControllers = [oneNav, twoNav, threeNav]
        
        // 设置默认选中的标签页
        self.selectedIndex = 0
    }
    
    private func setupTabBarAppearance() {
        // 设置TabBar外观
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
        
        // 设置TabBar的颜色
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .gray
        tabBar.backgroundColor = .white
        
        // 移除顶部分割线
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
