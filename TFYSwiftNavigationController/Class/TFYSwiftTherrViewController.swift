//
//  TFYSwiftTherrViewController.swift
//  TFYSwiftNavigationController
//
//  Created by mi ni on 2025/2/13.
//

import UIKit

@available(iOS 15.0, *)
class TFYSwiftTherrViewController: UIViewController {
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        return blurView
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
        TFYSwiftNavigationPerformanceMonitor.startMonitoring("blur_effect_setup")
    }
    
    private func setupUI() {
        view.addSubview(backgroundImageView)
        view.addSubview(blurEffectView)
        view.addSubview(descriptionLabel)
        
        // 异步布局优化
        TFYSwiftNavigationAsyncLayoutManager.performAsyncLayout({
            // 后台计算布局
        }) {
            // 主线程更新UI
            self.updateLayout()
        }
        
        descriptionLabel.text = "当前展示: \(title ?? "")\n\n这是一个演示页面，用于展示毛玻璃效果功能\n\n• 系统毛玻璃效果\n• 背景图片模糊\n• 性能优化支持\n• 动态效果切换"
        
        // 设置背景图片
        backgroundImageView.image = UIImage(named: "moment_cover")
        
        // 启用毛玻璃效果
        tfy_useSystemBlurNavBar = true
        
        // 配置导航栏样式
        tfy_backgroundColor = .clear
        tfy_tintColor = .white
        tfy_titleColor = .white
        
        // 隐藏阴影
        tfy_shadowHidden = true
        
        // 缓存毛玻璃设置
        if TFYSwiftNavigationConfig.enableCaching {
            TFYSwiftNavigationCacheManager.cacheColor(.clear, forKey: "blur_nav_bg")
        }
    }
    
    private func updateLayout() {
        backgroundImageView.frame = view.bounds
        blurEffectView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 200)
        descriptionLabel.frame = CGRect(x: 20, y: 220, width: view.bounds.width - 40, height: 120)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 记录性能指标
        if let duration = TFYSwiftNavigationPerformanceMonitor.endMonitoring("blur_effect_setup") {
            TFYSwiftNavigationPerformanceMonitor.recordMetric("blur_effect_setup", duration: duration)
        }
        
        // 动态切换毛玻璃效果
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.toggleBlurEffect()
        }
    }
    
    private func toggleBlurEffect() {
        // 动态切换毛玻璃效果
        tfy_useSystemBlurNavBar.toggle()
        
        // 异步更新UI
        TFYSwiftNavigationAsyncLayoutManager.performAsyncUIUpdate { [weak self] in
            self?.blurEffectView.isHidden = !self!.tfy_useSystemBlurNavBar
        }
    }
}
