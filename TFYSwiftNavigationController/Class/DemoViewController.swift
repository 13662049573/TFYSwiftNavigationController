//
//  DemoViewController.swift
//  TFYSwiftNavigationController
//
//  Created by 田风有 on 2021/5/15.
//

import UIKit

@available(iOS 15.0, *)
class DemoViewController: UIViewController {

    @IBOutlet weak var barAlphaLabel: UILabel!
    
    // MARK: - Performance Monitoring
    private var performanceStartTime: TimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 启用性能监控
        TFYSwiftNavigationPerformanceMonitor.startMonitoring("demo_viewDidLoad")
        
        title = "首页\(navigationController!.viewControllers.count % 2)"
        
        // 配置性能优化
        TFYSwiftNavigationConfig.enablePerformanceOptimization = true
        TFYSwiftNavigationConfig.enableCaching = true
        TFYSwiftNavigationConfig.enableAsyncLayout = true
        
        setupNavigationBar()
        setupPerformanceMonitoring()
        
        // 结束性能监控
        if let duration = TFYSwiftNavigationPerformanceMonitor.endMonitoring("demo_viewDidLoad") {
            TFYSwiftNavigationPerformanceMonitor.recordMetric("demo_viewDidLoad", duration: duration)
        }
    }
    
    private func setupNavigationBar() {
        // 使用正确的API设置导航栏
        tfy_backgroundColor = UIColor.systemBackground
        tfy_tintColor = UIColor.systemBlue
        tfy_titleColor = UIColor.systemBlue
        
        // 启用毛玻璃效果
        tfy_useSystemBlurNavBar = true
        
        // 设置阴影
        tfy_shadowImageTintColor = UIColor.systemGray5
    }
    
    private func setupPerformanceMonitoring() {
        // 监控导航栏更新性能
        TFYSwiftNavigationPerformanceMonitor.startMonitoring("navigation_update")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear: \(title!)")
        
        // 异步更新导航栏
        TFYSwiftNavigationAsyncLayoutManager.performAsyncUIUpdate { [weak self] in
            self?.updateNavigationBarPerformance()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear: \(title!)")
        
        // 记录性能指标
        if let duration = TFYSwiftNavigationPerformanceMonitor.endMonitoring("navigation_update") {
            TFYSwiftNavigationPerformanceMonitor.recordMetric("navigation_update", duration: duration)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear: \(title!)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear: \(title!)")
    }
    
    private func updateNavigationBarPerformance() {
        // 使用缓存机制
        if TFYSwiftNavigationConfig.enableCaching {
            let cacheKey = "demo_nav_style_\(navigationController!.viewControllers.count)"
            TFYSwiftNavigationCacheManager.cacheColor(tfy_navigationBarBackgroundColor ?? .clear, forKey: cacheKey)
        }
    }
    
    @IBAction func barColorBtnClicked(_ sender: UIButton) {
        guard let color = sender.backgroundColor else { return }
        
        // 使用正确的API
        tfy_backgroundColor = color
        
        // 缓存颜色
        if TFYSwiftNavigationConfig.enableCaching {
            TFYSwiftNavigationCacheManager.cacheColor(color, forKey: "bar_color_\(color)")
        }
    }
    
    @IBAction func barImageSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            let image = UIImage(named: "nav")
            tfy_backgroundImage = image
            
            // 缓存图片
            if TFYSwiftNavigationConfig.enableCaching, let image = image {
                TFYSwiftNavigationCacheManager.cacheImage(image, forKey: "nav_background")
            }
        } else {
            tfy_backgroundImage = nil
        }
    }
    
    @IBAction func blackBarStyleSwitchChanged(_ sender: UISwitch) {
        // 使用新的毛玻璃效果API
        tfy_useSystemBlurNavBar = sender.isOn
    }
    
    @IBAction func shadowHiddenSwitchChanged(_ sender: UISwitch) {
        // 使用正确的阴影API
        tfy_shadowHidden = sender.isOn
    }
    
    @IBAction func barAlphaSliderChanged(_ sender: UISlider) {
        barAlphaLabel.text = String(format: "%.2f", sender.value)
        
        // 使用正确的透明度API
        tfy_barAlpha = CGFloat(sender.value)
    }
    
    @IBAction func tintColorBtnClicked(_ sender: UIButton) {
        guard let color = sender.backgroundColor else { return }
        tfy_tintColor = color
    }
    
    @IBAction func titleColorBtnClicked(_ sender: UIButton) {
        guard let color = sender.backgroundColor else { return }
        
        // 使用正确的标题颜色API
        tfy_titleColor = color
    }
    
    @IBAction func pushToNext(_ sender: Any) {
        guard let demoVC = storyboard?.instantiateViewController(withIdentifier: "DemoViewController") else { return }
        navigationController?.pushViewController(demoVC, animated: true)
    }
    
    @IBAction func present(_ sender: Any) {
        guard let demoVC = storyboard?.instantiateViewController(withIdentifier: "DemoViewController") else { return }
        let nav = TFYSwiftNavigationController(rootViewController: demoVC)
        present(nav, animated: true, completion: nil)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Performance Testing
    @IBAction func performanceTest(_ sender: Any) {
        // 测试性能优化功能
        TFYSwiftNavigationPerformanceMonitor.startMonitoring("performance_test")
        
        // 模拟大量导航栏更新
        for i in 0..<100 {
            tfy_backgroundColor = UIColor(hue: CGFloat(i) / 100.0, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        }
        
        if let duration = TFYSwiftNavigationPerformanceMonitor.endMonitoring("performance_test") {
            TFYSwiftNavigationPerformanceMonitor.recordMetric("performance_test", duration: duration)
        }
    }
    
    @IBAction func cacheTest(_ sender: Any) {
        // 测试缓存功能
        let testColors: [UIColor] = [.red, .blue, .green, .yellow, .purple]
        
        for (index, color) in testColors.enumerated() {
            TFYSwiftNavigationCacheManager.cacheColor(color, forKey: "test_color_\(index)")
        }
        
        // 验证缓存
        for i in 0..<testColors.count {
            if let cachedColor = TFYSwiftNavigationCacheManager.getCachedColor(forKey: "test_color_\(i)") {
                print("Cached color \(i): \(cachedColor)")
            }
        }
    }
}
