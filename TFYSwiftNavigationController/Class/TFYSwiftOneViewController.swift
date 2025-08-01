//
//  TFYSwiftOneViewController.swift
//  TFYSwiftNavigationController
//
//  Created by mi ni on 2025/2/13.
//

import UIKit

@available(iOS 15.0, *)
class TFYSwiftOneViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()
    
    private let demos = [
        "自定义返回按钮",
        "默认样式",
        "透明导航栏",
        "渐变背景",
        "自定义背景图片",
        "全屏滑动返回",
        "禁用滑动返回",
        "自定义滑动返回距离",
        "毛玻璃效果",
        "性能优化演示",
        "缓存机制演示",
        "异步布局演示"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 启用性能优化
        TFYSwiftNavigationConfig.enablePerformanceOptimization = true
        
        view.backgroundColor = UIColor.systemBackground
        setupUI()
        setupNavigationBarStyle()
        
        // 性能监控
        TFYSwiftNavigationPerformanceMonitor.startMonitoring("main_list_setup")
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupNavigationBarStyle() {
        // 使用正确的API设置导航栏
        tfy_backgroundColor = UIColor.systemBackground
        tfy_tintColor = UIColor.systemBlue
        tfy_titleColor = UIColor.systemBlue
        
        // 启用毛玻璃效果
        tfy_useSystemBlurNavBar = true
        
        // 设置阴影
        tfy_shadowImageTintColor = UIColor.systemGray5
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 记录性能指标
        if let duration = TFYSwiftNavigationPerformanceMonitor.endMonitoring("one_vc_setup") {
            TFYSwiftNavigationPerformanceMonitor.recordMetric("one_vc_setup", duration: duration)
        }
    }
}

// MARK: - UITableViewDelegate & DataSource
@available(iOS 15.0, *)
extension TFYSwiftOneViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = demos[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        // 使用缓存优化
        if TFYSwiftNavigationConfig.enableCaching {
            let cellColor = TFYSwiftNavigationCacheManager.getCachedColor(forKey: "cell_color_\(indexPath.row)") ?? UIColor.systemBackground
            cell.backgroundColor = cellColor
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 性能监控
        TFYSwiftNavigationPerformanceMonitor.startMonitoring("navigation_push")
        
        var vc = UIViewController()
        vc.view.backgroundColor = .systemBackground
        vc.title = demos[indexPath.row]
        
        switch indexPath.row {
        case 0:
            vc = TFYSwiftTwoViewController()
        case 1:
            vc = TFYSwiftTherrViewController()
        case 2:
            vc = TFYSwiftFourViewController()
        case 3:
            vc = TFYSwiftFiveViewController()
        case 4:
            vc = TFYSwiftSexViewController()
        case 5:
            vc = TFYSwiftSevenViewController()
        case 6:
            vc = TFYSwiftEightViewController()
        case 7:
            vc = TFYSwiftNineViewController()
        case 8:
            vc = TFYSwiftTenViewController()
        case 9:
            vc = TFYSwiftElevenViewController()
        case 10:
            vc = createPerformanceDemoViewController()
        case 11:
            vc = createCacheDemoViewController()
        case 12:
            vc = createAsyncLayoutDemoViewController()
        default:
            break
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
        // 记录导航性能
        if let duration = TFYSwiftNavigationPerformanceMonitor.endMonitoring("navigation_push") {
            TFYSwiftNavigationPerformanceMonitor.recordMetric("navigation_push", duration: duration)
        }
    }
    
    // MARK: - Demo View Controllers
    private func createPerformanceDemoViewController() -> UIViewController {
        let vc = UIViewController()
        vc.title = "性能优化演示"
        vc.view.backgroundColor = .systemBackground
        
        let label = UILabel()
        label.text = "性能优化功能演示\n\n• 异步布局\n• 智能缓存\n• 内存优化\n• 性能监控"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.frame = CGRect(x: 20, y: 100, width: vc.view.bounds.width - 40, height: 200)
        vc.view.addSubview(label)
        
        // 演示性能优化
        TFYSwiftNavigationConfig.enablePerformanceOptimization = true
        TFYSwiftNavigationConfig.enableCaching = true
        TFYSwiftNavigationConfig.enableAsyncLayout = true
        
        return vc
    }
    
    private func createCacheDemoViewController() -> UIViewController {
        let vc = UIViewController()
        vc.title = "缓存机制演示"
        vc.view.backgroundColor = .systemBackground
        
        let label = UILabel()
        label.text = "缓存机制功能演示\n\n• 图片缓存\n• 颜色缓存\n• 布局缓存\n• 自动清理"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.frame = CGRect(x: 20, y: 100, width: vc.view.bounds.width - 40, height: 200)
        vc.view.addSubview(label)
        
        // 演示缓存功能
        let testColors: [UIColor] = [.red, .blue, .green, .yellow, .purple]
        for (index, color) in testColors.enumerated() {
            TFYSwiftNavigationCacheManager.cacheColor(color, forKey: "demo_color_\(index)")
        }
        
        return vc
    }
    
    private func createAsyncLayoutDemoViewController() -> UIViewController {
        let vc = UIViewController()
        vc.title = "异步布局演示"
        vc.view.backgroundColor = .systemBackground
        
        let label = UILabel()
        label.text = "异步布局功能演示\n\n• 后台布局计算\n• 主线程UI更新\n• 性能优化\n• 流畅体验"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.frame = CGRect(x: 20, y: 100, width: vc.view.bounds.width - 40, height: 200)
        vc.view.addSubview(label)
        
        // 演示异步布局
        TFYSwiftNavigationAsyncLayoutManager.performAsyncLayout({
            // 模拟复杂的后台计算
            Thread.sleep(forTimeInterval: 0.1)
        }) {
            // 主线程更新
            label.text = "异步布局完成！\n\n后台计算已完成，UI已更新"
        }
        
        return vc
    }
}
