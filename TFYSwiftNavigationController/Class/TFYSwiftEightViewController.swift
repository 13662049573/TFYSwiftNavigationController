//
//  TFYSwiftEightViewController.swift
//  TFYSwiftNavigationController
//
//  Created by mi ni on 2025/2/13.
//

import UIKit

@available(iOS 15.0, *)
class TFYSwiftEightViewController: UIViewController {
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "禁用滑动返回演示\n\n• 完全禁用手势返回\n• 只能通过按钮返回\n• 性能优化支持\n• 安全交互体验"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("返回上一页", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 启用性能优化
        TFYSwiftNavigationConfig.enablePerformanceOptimization = true
        
        view.backgroundColor = UIColor.systemBackground
        setupUI()
        setupDisabledGesture()
        
        // 性能监控
        TFYSwiftNavigationPerformanceMonitor.startMonitoring("disabled_gesture_setup")
    }
    
    private func setupUI() {
        view.addSubview(infoLabel)
        view.addSubview(backButton)
        
        // 异步布局优化
        TFYSwiftNavigationAsyncLayoutManager.performAsyncLayout({
            // 后台计算布局
        }) {
            // 主线程更新UI
            self.updateLayout()
        }
        
        infoLabel.text = "当前展示: \(title ?? "")\n\n这是一个演示页面，用于展示禁用滑动返回功能\n\n• 禁用滑动返回手势\n• 只能通过按钮返回\n• 性能优化支持\n• 手势状态监控"
        
        backButton.setTitle("返回", for: .normal)
        backButton.setTitleColor(UIColor.systemBlue, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func setupDisabledGesture() {
        // 禁用滑动返回手势
        tfy_disableInteractivePopGesture = true
        
        // 配置导航栏样式
        tfy_backgroundColor = UIColor.systemBackground
        tfy_tintColor = UIColor.systemBlue
        tfy_titleColor = UIColor.systemBlue
        
        // 缓存禁用设置
        if TFYSwiftNavigationConfig.enableCaching {
            TFYSwiftNavigationCacheManager.cacheColor(UIColor.systemRed, forKey: "disabled_gesture_color")
        }
    }
    
    private func updateLayout() {
        // 更新布局
        infoLabel.frame = CGRect(x: 20, y: 120, width: view.bounds.width - 40, height: 120)
        backButton.frame = CGRect(x: 50, y: 300, width: view.bounds.width - 100, height: 50)
    }
    
    @objc private func backButtonTapped() {
        // 自定义返回按钮点击事件
        print("自定义返回按钮被点击")
        
        // 性能监控
        if let duration = TFYSwiftNavigationPerformanceMonitor.endMonitoring("disabled_gesture_setup") {
            TFYSwiftNavigationPerformanceMonitor.recordMetric("disabled_gesture_setup", duration: duration)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 验证手势是否被禁用
        validateGestureDisabled()
    }
    
    private func validateGestureDisabled() {
        // 验证手势是否被正确禁用
        if tfy_disableInteractivePopGesture {
            print("✅ 滑动返回手势已禁用")
        } else {
            print("❌ 滑动返回手势未禁用")
        }
        
        // 显示提示信息
        showDisabledGestureInfo()
    }
    
    private func showDisabledGestureInfo() {
        let alert = UIAlertController(title: "手势已禁用", message: "滑动返回手势已被禁用，请使用返回按钮", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "知道了", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - Performance Testing
    func testDisabledGesturePerformance() {
        // 测试禁用手势的性能
        TFYSwiftNavigationPerformanceMonitor.startMonitoring("disabled_gesture_performance")
        
        // 模拟手势禁用处理
        for _ in 0..<50 {
            // 模拟手势禁用逻辑
        }
        
        if let duration = TFYSwiftNavigationPerformanceMonitor.endMonitoring("disabled_gesture_performance") {
            TFYSwiftNavigationPerformanceMonitor.recordMetric("disabled_gesture_performance", duration: duration)
        }
    }
    
    // MARK: - Touch Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        // 点击时显示禁用信息
        showDisabledGestureInfo()
    }
}
