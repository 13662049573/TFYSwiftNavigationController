//
//  TFYSwiftNineViewController.swift
//  TFYSwiftNavigationController
//
//  Created by mi ni on 2025/2/13.
//

import UIKit

@available(iOS 15.0, *)
class TFYSwiftNineViewController: UIViewController {
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "自定义滑动返回距离演示\n\n• 限制手势响应区域\n• 精确距离控制\n• 性能优化支持\n• 智能交互体验"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var distanceSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 200
        slider.value = 50
        slider.addTarget(self, action: #selector(distanceSliderChanged), for: .valueChanged)
        return slider
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "当前距离: 50pt"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var visualIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 4
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 启用性能优化
        TFYSwiftNavigationConfig.enablePerformanceOptimization = true
        
        view.backgroundColor = UIColor.systemBackground
        setupUI()
        setupCustomDistanceGesture()
        
        // 性能监控
        TFYSwiftNavigationPerformanceMonitor.startMonitoring("custom_distance_setup")
    }
    
    private func setupUI() {
        view.addSubview(infoLabel)
        view.addSubview(distanceSlider)
        view.addSubview(distanceLabel)
        view.addSubview(visualIndicator)
        
        // 异步布局优化
        TFYSwiftNavigationAsyncLayoutManager.performAsyncLayout({
            // 后台计算布局
        }) {
            // 主线程更新UI
            self.updateLayout()
        }
        
        infoLabel.text = "当前展示: \(title ?? "")\n\n这是一个演示页面，用于展示自定义滑动返回距离功能\n\n• 自定义滑动距离\n• 实时调整距离\n• 可视化指示器\n• 性能优化支持"
        
        distanceLabel.text = "滑动距离: 50pt"
        distanceLabel.textAlignment = .center
        distanceLabel.font = .systemFont(ofSize: 16)
        
        visualIndicator.backgroundColor = UIColor.systemBlue
        visualIndicator.layer.cornerRadius = 5
    }
    
    private func setupCustomDistanceGesture() {
        // 启用全屏滑动返回
        tfy_fullScreenInteractivePopEnabled = true
        
        // 安全地设置自定义距离
        if self.isViewLoaded {
            tfy_fullScreenPopMaxAllowedDistanceToLeftEdge = 50.0
        }
        
        // 配置导航栏样式
        tfy_backgroundColor = UIColor.systemBackground
        tfy_tintColor = UIColor.systemBlue
        tfy_titleColor = UIColor.systemBlue
        
        // 缓存距离设置
        if TFYSwiftNavigationConfig.enableCaching {
            TFYSwiftNavigationCacheManager.cacheColor(UIColor.systemBlue, forKey: "custom_distance_color")
        }
    }
    
    private func updateLayout() {
        // 更新布局
        infoLabel.frame = CGRect(x: 20, y: 120, width: view.bounds.width - 40, height: 120)
        distanceSlider.frame = CGRect(x: 50, y: 300, width: view.bounds.width - 100, height: 30)
        distanceLabel.frame = CGRect(x: 20, y: 340, width: view.bounds.width - 40, height: 30)
        
        // 更新视觉指示器
        let distance = CGFloat(distanceSlider.value)
        visualIndicator.frame = CGRect(x: distance, y: 100, width: 4, height: 200)
    }
    
    @objc private func distanceSliderChanged(_ sender: UISlider) {
        let distance = CGFloat(sender.value)
        
        // 更新距离标签
        distanceLabel.text = "当前距离: \(Int(distance))pt"
        
        // 安全地更新手势距离
        if self.isViewLoaded {
            tfy_fullScreenPopMaxAllowedDistanceToLeftEdge = distance
        }
        
        // 更新视觉指示器
        visualIndicator.frame = CGRect(x: distance, y: 100, width: 4, height: 200)
        
        // 缓存新的距离设置
        if TFYSwiftNavigationConfig.enableCaching {
            TFYSwiftNavigationCacheManager.cacheColor(UIColor.systemBlue, forKey: "distance_\(Int(distance))")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 记录性能指标
        if let duration = TFYSwiftNavigationPerformanceMonitor.endMonitoring("custom_distance_setup") {
            TFYSwiftNavigationPerformanceMonitor.recordMetric("custom_distance_setup", duration: duration)
        }
        
        // 验证距离设置
        validateDistanceSettings()
    }
    
    private func validateDistanceSettings() {
        // 验证距离设置是否正确
        if tfy_fullScreenInteractivePopEnabled {
            print("✅ 全屏滑动返回已启用")
        } else {
            print("❌ 全屏滑动返回未启用")
        }
        
        // 安全地获取距离值
        var distance: CGFloat = 0.0
        if self.isViewLoaded {
            distance = tfy_fullScreenPopMaxAllowedDistanceToLeftEdge
        } else {
            distance = CGFloat(distanceSlider.value)
        }
        
        print("✅ 手势距离限制为: \(distance)pt")
        
        // 显示距离信息
        showDistanceInfo()
    }
    
    private func showDistanceInfo() {
        // 添加安全检查，避免内存访问错误
        var distance: CGFloat = 0.0
        
        // 安全地获取距离值
        if self.isViewLoaded {
            distance = tfy_fullScreenPopMaxAllowedDistanceToLeftEdge
        } else {
            distance = CGFloat(distanceSlider.value)
        }
        
        let alert = UIAlertController(title: "自定义距离", message: "当前手势响应距离为 \(Int(distance))pt\n\n蓝色指示器显示了手势响应的边界", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "知道了", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - Performance Testing
    func testDistancePerformance() {
        // 测试距离设置的性能
        TFYSwiftNavigationPerformanceMonitor.startMonitoring("distance_performance_test")
        
        // 模拟不同距离的设置
        for distance in stride(from: 0, through: 200, by: 10) {
            if self.isViewLoaded {
                tfy_fullScreenPopMaxAllowedDistanceToLeftEdge = CGFloat(distance)
            }
        }
        
        if let duration = TFYSwiftNavigationPerformanceMonitor.endMonitoring("distance_performance_test") {
            TFYSwiftNavigationPerformanceMonitor.recordMetric("distance_performance_test", duration: duration)
        }
    }
    
    // MARK: - Touch Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        // 点击时显示距离信息
        showDistanceInfo()
    }
}
