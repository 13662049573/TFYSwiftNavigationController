//
//  TFYSwiftSevenViewController.swift
//  TFYSwiftNavigationController
//
//  Created by mi ni on 2025/2/13.
//

import UIKit

@available(iOS 15.0, *)
class TFYSwiftSevenViewController: UIViewController {
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "全屏滑动返回演示\n\n• 全屏手势识别\n• 智能距离控制\n• 性能优化支持\n• 流畅交互体验"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var gestureInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "从屏幕左边缘向右滑动即可返回"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 启用性能优化
        TFYSwiftNavigationConfig.enablePerformanceOptimization = true
        
        view.backgroundColor = UIColor.systemBackground
        setupUI()
        setupFullScreenGesture()
        
        // 性能监控
        TFYSwiftNavigationPerformanceMonitor.startMonitoring("fullscreen_gesture_setup")
    }
    
    private func setupUI() {
        view.addSubview(infoLabel)
        view.addSubview(gestureInfoLabel)
        
        // 异步布局优化
        TFYSwiftNavigationAsyncLayoutManager.performAsyncLayout({
            // 后台计算布局
        }) {
            // 主线程更新UI
            self.updateLayout()
        }
        
        infoLabel.text = "当前展示: \(title ?? "")\n\n这是一个演示页面，用于展示全屏滑动返回功能\n\n• 全屏滑动返回手势\n• 自定义滑动距离\n• 性能优化支持\n• 手势状态监控"
        
        gestureInfoLabel.text = "手势状态: 启用\n滑动距离: 全屏\n响应区域: 屏幕左边缘"
    }
    
    private func setupFullScreenGesture() {
        // 启用全屏滑动返回
        tfy_fullScreenInteractivePopEnabled = true
        
        // 设置最大允许距离（0表示全屏）
        tfy_fullScreenPopMaxAllowedDistanceToLeftEdge = 0.0
        
        // 配置导航栏样式
        tfy_backgroundColor = UIColor.systemBackground
        tfy_tintColor = UIColor.systemBlue
        tfy_titleColor = UIColor.systemBlue
        
        // 缓存手势设置
        if TFYSwiftNavigationConfig.enableCaching {
            TFYSwiftNavigationCacheManager.cacheColor(UIColor.systemBlue, forKey: "fullscreen_gesture_color")
        }
    }
    
    private func updateLayout() {
        // 更新布局
        infoLabel.frame = CGRect(x: 20, y: 120, width: view.bounds.width - 40, height: 120)
        gestureInfoLabel.frame = CGRect(x: 20, y: 250, width: view.bounds.width - 40, height: 60)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 记录性能指标
        if let duration = TFYSwiftNavigationPerformanceMonitor.endMonitoring("fullscreen_gesture_setup") {
            TFYSwiftNavigationPerformanceMonitor.recordMetric("fullscreen_gesture_setup", duration: duration)
        }
        
        // 验证手势是否启用
        validateGestureSettings()
    }
    
    private func validateGestureSettings() {
        // 验证手势设置是否正确
        if tfy_fullScreenInteractivePopEnabled {
            print("✅ 全屏滑动返回已启用")
        } else {
            print("❌ 全屏滑动返回未启用")
        }
        
        if tfy_fullScreenPopMaxAllowedDistanceToLeftEdge == 0.0 {
            print("✅ 全屏手势距离设置正确")
        } else {
            print("⚠️ 手势距离限制为: \(tfy_fullScreenPopMaxAllowedDistanceToLeftEdge)")
        }
    }
    
    // MARK: - Gesture Testing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        // 点击时显示手势信息
        showGestureInfo()
    }
    
    private func showGestureInfo() {
        let alert = UIAlertController(title: "全屏滑动返回", message: "从屏幕左边缘向右滑动即可返回上一页", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "知道了", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - Performance Testing
    func testGesturePerformance() {
        // 测试手势性能
        TFYSwiftNavigationPerformanceMonitor.startMonitoring("gesture_performance_test")
        
        // 模拟手势识别
        for _ in 0..<100 {
            // 模拟手势处理
        }
        
        if let duration = TFYSwiftNavigationPerformanceMonitor.endMonitoring("gesture_performance_test") {
            TFYSwiftNavigationPerformanceMonitor.recordMetric("gesture_performance_test", duration: duration)
        }
    }
}
