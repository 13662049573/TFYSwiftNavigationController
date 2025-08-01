//
//  TFYSwiftSexViewController.swift
//  TFYSwiftNavigationController
//
//  Created by mi ni on 2025/2/13.
//

import UIKit

@available(iOS 15.0, *)
class TFYSwiftSexViewController: UIViewController {

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 启用性能优化
        TFYSwiftNavigationConfig.enablePerformanceOptimization = true
        
        view.backgroundColor = .white
        setupUI()
        
        // 性能监控
        TFYSwiftNavigationPerformanceMonitor.startMonitoring("background_image_setup")
    }
    
    private func setupUI() {
        view.addSubview(backgroundImageView)
        view.addSubview(descriptionLabel)
        
        // 异步布局优化
        TFYSwiftNavigationAsyncLayoutManager.performAsyncLayout({
            // 后台计算布局
        }) {
            // 主线程更新UI
            self.updateLayout()
        }
        
        descriptionLabel.text = "当前展示: \(title ?? "")\n\n这是一个演示页面，用于展示导航栏背景图片功能\n\n• 自定义导航栏背景图片\n• 图片自适应缩放\n• 性能优化支持\n• 缓存机制"
        
        // 获取背景图片
        let navImage = UIImage(named: "nav")
        
        // 设置导航栏背景图片
        tfy_navigationBarBackgroundImage = navImage
        tfy_backgroundImage = navImage
        
        // 设置背景图片
        backgroundImageView.image = navImage
        
        // 配置导航栏样式
        tfy_backgroundColor = UIColor.clear
        tfy_tintColor = UIColor.white
        tfy_titleColor = UIColor.white
        
        // 缓存背景图片
        if TFYSwiftNavigationConfig.enableCaching, let image = navImage {
            TFYSwiftNavigationCacheManager.cacheImage(image, forKey: "nav_background")
        }
    }
    
    private func updateLayout() {
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 200)
        descriptionLabel.frame = CGRect(x: 20, y: 220, width: view.bounds.width - 40, height: 120)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 记录性能指标
        if let duration = TFYSwiftNavigationPerformanceMonitor.endMonitoring("background_image_setup") {
            TFYSwiftNavigationPerformanceMonitor.recordMetric("background_image_setup", duration: duration)
        }
    }
}
