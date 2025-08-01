//
//  TFYSwiftTenViewController.swift
//  TFYSwiftNavigationController
//
//  Created by mi ni on 2025/2/13.
//

import UIKit

@available(iOS 15.0, *)
class TFYSwiftTenViewController: UIViewController {
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "毛玻璃效果演示\n\n• 系统级毛玻璃背景\n• 动态透明度调节\n• 性能优化支持\n• 流畅视觉效果"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var blurSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = true
        switchControl.addTarget(self, action: #selector(blurSwitchChanged), for: .valueChanged)
        return switchControl
    }()
    
    private lazy var blurLabel: UILabel = {
        let label = UILabel()
        label.text = "毛玻璃效果: 开启"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
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
        TFYSwiftNavigationConfig.enableCaching = true
        
        setupBackground()
        setupUI()
        setupBlurNavigationBar()
        
        // 性能监控
        TFYSwiftNavigationPerformanceMonitor.startMonitoring("blur_effect_setup")
    }
    
    private func setupBackground() {
        // 设置背景图片
        if let backgroundImage = UIImage(named: "moment_cover") {
            backgroundImageView.image = backgroundImage
            view.addSubview(backgroundImageView)
            backgroundImageView.frame = view.bounds
            backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        } else {
            // 如果没有背景图片，创建渐变背景
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [
                UIColor.systemBlue.cgColor,
                UIColor.systemPurple.cgColor,
                UIColor.systemPink.cgColor
            ]
            gradientLayer.frame = view.bounds
            view.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    private func setupUI() {
        view.addSubview(infoLabel)
        view.addSubview(blurSwitch)
        view.addSubview(blurLabel)
        
        infoLabel.frame = CGRect(x: 20, y: 120, width: view.bounds.width - 40, height: 120)
        blurSwitch.frame = CGRect(x: view.bounds.width / 2 - 25, y: 300, width: 50, height: 30)
        blurLabel.frame = CGRect(x: 20, y: 340, width: view.bounds.width - 40, height: 30)
        
        // 异步布局优化
        TFYSwiftNavigationAsyncLayoutManager.performAsyncLayout({
            // 后台计算布局
        }) {
            // 主线程更新UI
            self.updateLayout()
        }
    }
    
    private func setupBlurNavigationBar() {
        // 启用毛玻璃效果
        tfy_useSystemBlurNavBar = true
        
        // 设置导航栏样式
        tfy_backgroundColor = .clear
        tfy_tintColor = .white
        tfy_titleColor = .white
        
        // 隐藏阴影
        tfy_shadowHidden = true
        
        // 缓存毛玻璃设置
        if TFYSwiftNavigationConfig.enableCaching {
            TFYSwiftNavigationCacheManager.cacheColor(UIColor.clear, forKey: "blur_nav_bg")
        }
    }
    
    private func updateLayout() {
        // 更新布局
        infoLabel.frame = CGRect(x: 20, y: 120, width: view.bounds.width - 40, height: 120)
        blurSwitch.frame = CGRect(x: view.bounds.width / 2 - 25, y: 300, width: 50, height: 30)
        blurLabel.frame = CGRect(x: 20, y: 340, width: view.bounds.width - 40, height: 30)
    }
    
    @objc private func blurSwitchChanged(_ sender: UISwitch) {
        // 动态切换毛玻璃效果
        tfy_useSystemBlurNavBar = sender.isOn
        
        // 更新标签
        blurLabel.text = sender.isOn ? "毛玻璃效果: 启用" : "毛玻璃效果: 禁用"
        
        // 更新背景图片的透明度
        UIView.animate(withDuration: 0.3) {
            self.backgroundImageView.alpha = sender.isOn ? 0.3 : 1.0
        }
        
        // 缓存毛玻璃设置
        if TFYSwiftNavigationConfig.enableCaching {
            TFYSwiftNavigationCacheManager.cacheColor(sender.isOn ? UIColor.clear : UIColor.systemBackground, forKey: "blur_effect_\(sender.isOn)")
        }
        
        // 显示状态提示
        showBlurStatusChange(sender.isOn)
    }
    
    private func showBlurStatusChange(_ enabled: Bool) {
        let message = enabled ? "毛玻璃效果已启用" : "毛玻璃效果已禁用"
        let alert = UIAlertController(title: "状态更新", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default))
        present(alert, animated: true)
    }
    
    private func updateBlurEffect() {
        // 更新毛玻璃效果
        if tfy_useSystemBlurNavBar {
            tfy_navigationBar.enableBlurEffect(true)
        } else {
            tfy_navigationBar.enableBlurEffect(false)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 记录性能指标
        if let duration = TFYSwiftNavigationPerformanceMonitor.endMonitoring("blur_effect_setup") {
            TFYSwiftNavigationPerformanceMonitor.recordMetric("blur_effect_setup", duration: duration)
        }
        
        // 验证毛玻璃设置
        validateBlurSettings()
    }
    
    private func validateBlurSettings() {
        // 验证毛玻璃设置是否正确
        if tfy_useSystemBlurNavBar {
            print("✅ 毛玻璃效果已启用")
        } else {
            print("❌ 毛玻璃效果未启用")
        }
        
        // 检查毛玻璃效果状态
        let statusCorrect = checkBlurEffectStatus()
        if statusCorrect {
            print("✅ 毛玻璃效果状态正确")
        } else {
            print("❌ 毛玻璃效果状态不正确")
        }
        
        // 显示毛玻璃信息
        showBlurInfo()
    }
    
    private func showBlurInfo() {
        let status = checkBlurEffectStatus() ? "正常" : "异常"
        let alert = UIAlertController(title: "毛玻璃效果", message: "当前毛玻璃效果状态: \(tfy_useSystemBlurNavBar ? "开启" : "关闭")\n\n状态检查: \(status)\n\n使用开关可以动态切换毛玻璃效果", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "知道了", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - Performance Testing
    func testBlurPerformance() {
        // 测试毛玻璃效果的性能
        TFYSwiftNavigationPerformanceMonitor.startMonitoring("blur_performance_test")
        
        // 模拟毛玻璃效果切换
        for _ in 0..<10 {
            tfy_useSystemBlurNavBar.toggle()
            tfy_navigationBar.enableBlurEffect(tfy_useSystemBlurNavBar)
        }
        
        if let duration = TFYSwiftNavigationPerformanceMonitor.endMonitoring("blur_performance_test") {
            TFYSwiftNavigationPerformanceMonitor.recordMetric("blur_performance_test", duration: duration)
        }
    }
    
    // MARK: - Touch Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        // 点击时显示毛玻璃信息
        showBlurInfo()
    }
}

