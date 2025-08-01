//
//  TFYSwiftTwoViewController.swift
//  TFYSwiftNavigationController
//
//  Created by mi ni on 2025/2/13.
//

import UIKit

@available(iOS 15.0, *)
class TFYSwiftTwoViewController: UIViewController {
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var customBackButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icon_back"), for: .normal)
        button.setTitle(" 返回", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(customBackAction), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 启用性能优化
        TFYSwiftNavigationConfig.enablePerformanceOptimization = true
        
        view.backgroundColor = .white
        setupUI()
        setupNavigationBar()
        
        // 性能监控
        TFYSwiftNavigationPerformanceMonitor.startMonitoring("custom_back_setup")
    }
    
    private func setupUI() {
        view.addSubview(descriptionLabel)
        descriptionLabel.frame = CGRect(x: 20, y: 100, width: view.bounds.width - 40, height: 100)
        descriptionLabel.text = "当前展示: \(title ?? "")\n\n这是一个演示页面，用于展示自定义返回按钮功能\n\n• 自定义返回按钮图片\n• 自定义返回按钮文字\n• 自定义返回按钮样式\n• 性能优化支持"
    }
    
    private func setupNavigationBar() {
        // 使用正确的API设置导航栏
        tfy_backgroundColor = UIColor.systemBackground
        tfy_tintColor = UIColor.systemBlue
        tfy_titleColor = UIColor.systemBlue
        
        // 设置自定义返回按钮
        tfy_backButtonCustomView = customBackButton
        
        // 设置自定义返回图片
        tfy_backImage = UIImage(named: "icon_back")
        
        // 缓存自定义按钮
        if TFYSwiftNavigationConfig.enableCaching {
            TFYSwiftNavigationCacheManager.cacheColor(UIColor.systemBlue, forKey: "custom_back_color")
        }
    }
    
    @objc private func customBackAction() {
        // 自定义返回按钮点击事件
        print("自定义返回按钮被点击")
        
        // 性能监控
        if let duration = TFYSwiftNavigationPerformanceMonitor.endMonitoring("custom_back_setup") {
            TFYSwiftNavigationPerformanceMonitor.recordMetric("custom_back_setup", duration: duration)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 异步更新自定义按钮样式
        TFYSwiftNavigationAsyncLayoutManager.performAsyncUIUpdate { [weak self] in
            self?.updateCustomBackButtonStyle()
        }
    }
    
    private func updateCustomBackButtonStyle() {
        // 动态更新自定义返回按钮样式
        customBackButton.setTitleColor(.systemBlue, for: .normal)
        customBackButton.setTitleColor(.systemBlue.withAlphaComponent(0.6), for: .highlighted)
    }
}
