//
//  TFYSwiftFiveViewController.swift
//  TFYSwiftNavigationController
//
//  Created by mi ni on 2025/2/13.
//

import UIKit

@available(iOS 15.0, *)
class TFYSwiftFiveViewController: UIViewController {
    
    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.systemBlue.cgColor,
            UIColor.systemPurple.cgColor,
            UIColor.systemPink.cgColor
        ]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        return layer
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "渐变背景演示\n\n• 线性渐变效果\n• 动态渐变变化\n• 性能优化支持\n• 流畅动画效果"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 启用性能优化
        TFYSwiftNavigationConfig.enablePerformanceOptimization = true
        
        view.backgroundColor = UIColor.systemBackground
        setupUI()
        setupGradientNavigationBar()
        
        // 性能监控
        TFYSwiftNavigationPerformanceMonitor.startMonitoring("gradient_nav_setup")
    }
    
    private func setupUI() {
        view.addSubview(infoLabel)
        infoLabel.frame = CGRect(x: 20, y: 120, width: view.bounds.width - 40, height: 120)
        
        // 添加渐变背景到视图
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // 异步布局优化
        TFYSwiftNavigationAsyncLayoutManager.performAsyncLayout({
            // 后台计算渐变
        }) {
            // 主线程更新UI
            self.updateGradientColors()
        }
    }
    
    private func setupGradientNavigationBar() {
        // 设置渐变导航栏背景 - 使用正确的方法
        
        // 配置导航栏样式
        tfy_backgroundColor = .clear
        tfy_tintColor = .white
        tfy_titleColor = .white
        
        // 添加渐变层到导航栏
        gradientLayer.frame = tfy_navigationBar.bounds
        tfy_navigationBar.layer.insertSublayer(gradientLayer, at: 0)
        
        // 缓存渐变设置
        if TFYSwiftNavigationConfig.enableCaching {
            TFYSwiftNavigationCacheManager.cacheColor(.systemBlue, forKey: "gradient_start_color")
            TFYSwiftNavigationCacheManager.cacheColor(.systemPurple, forKey: "gradient_end_color")
        }
    }
    
    private func updateGradientColors() {
        // 动态更新渐变颜色
        let colors: [CGColor] = [
            UIColor.systemBlue.cgColor,
            UIColor.systemPurple.cgColor,
            UIColor.systemPink.cgColor
        ]
        
        gradientLayer.colors = colors
        
        // 添加动画效果
        let animation = CABasicAnimation(keyPath: "colors")
        animation.duration = 2.0
        animation.repeatCount = .infinity
        animation.autoreverses = true
        gradientLayer.add(animation, forKey: "gradientAnimation")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 更新渐变层frame
        gradientLayer.frame = view.bounds
        tfy_navigationBar.layer.sublayers?.first?.frame = tfy_navigationBar.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 记录性能指标
        if let duration = TFYSwiftNavigationPerformanceMonitor.endMonitoring("gradient_nav_setup") {
            TFYSwiftNavigationPerformanceMonitor.recordMetric("gradient_nav_setup", duration: duration)
        }
        
        // 开始渐变动画
        startGradientAnimation()
    }
    
    private func startGradientAnimation() {
        // 创建动态渐变效果
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = [
            UIColor.systemBlue.cgColor,
            UIColor.systemPurple.cgColor,
            UIColor.systemPink.cgColor
        ]
        animation.toValue = [
            UIColor.systemPurple.cgColor,
            UIColor.systemPink.cgColor,
            UIColor.systemBlue.cgColor
        ]
        animation.duration = 3.0
        animation.repeatCount = .infinity
        animation.autoreverses = true
        
        gradientLayer.add(animation, forKey: "gradientAnimation")
    }
    
    // MARK: - Touch Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        // 点击时改变渐变方向
        let newStartPoint = CGPoint(x: CGFloat.random(in: 0...1), y: CGFloat.random(in: 0...1))
        let newEndPoint = CGPoint(x: CGFloat.random(in: 0...1), y: CGFloat.random(in: 0...1))
        
        gradientLayer.startPoint = newStartPoint
        gradientLayer.endPoint = newEndPoint
    }
}
