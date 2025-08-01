//
//  TFYSwiftFourViewController.swift
//  TFYSwiftNavigationController
//
//  Created by mi ni on 2025/2/13.
//

import UIKit

@available(iOS 15.0, *)
class TFYSwiftFourViewController: UIViewController {
    
    private lazy var tableview: UITableView = {
        let view = UITableView(frame: view.bounds, style: .plain)
        view.delegate = self
        view.dataSource = self
        view.rowHeight = 50
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "透明导航栏演示\n\n• 完全透明背景\n• 滚动时动态效果\n• 性能优化支持\n• 流畅动画效果"
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
        TFYSwiftNavigationConfig.enableAsyncLayout = true
        
        view.backgroundColor = .systemBlue
        setupUI()
        setupTransparentNavigationBar()
        
        // 性能监控
        TFYSwiftNavigationPerformanceMonitor.startMonitoring("transparent_nav_setup")
    }
    
    private func setupUI() {
        view.addSubview(tableview)
        view.addSubview(infoLabel)
        
        // 异步布局优化
        TFYSwiftNavigationAsyncLayoutManager.performAsyncLayout({
            // 后台计算布局
        }) {
            // 主线程更新UI
            self.updateLayout()
        }
    }
    
    private func setupTransparentNavigationBar() {
        // 设置完全透明的导航栏
        tfy_backgroundColor = .clear
        tfy_tintColor = .white
        tfy_titleColor = .white
        
        // 隐藏阴影
        tfy_shadowHidden = true
        
        // 启用毛玻璃效果
        tfy_useSystemBlurNavBar = false
        
        // 设置透明背景色
        tfy_navigationBarBackgroundColor = .clear
        
        // 设置导航栏透明度
        tfy_barAlpha = 0.0
        
        // 缓存透明设置
        if TFYSwiftNavigationConfig.enableCaching {
            TFYSwiftNavigationCacheManager.cacheColor(.clear, forKey: "transparent_nav_bg")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateLayout()
    }
    
    private func updateLayout() {
        self.tableview.frame = view.bounds
        self.infoLabel.frame = CGRect(x: 20, y: 120, width: view.bounds.width - 40, height: 120)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 记录性能指标
        if let duration = TFYSwiftNavigationPerformanceMonitor.endMonitoring("transparent_nav_setup") {
            TFYSwiftNavigationPerformanceMonitor.recordMetric("transparent_nav_setup", duration: duration)
        }
    }
}

@available(iOS 15.0, *)
extension TFYSwiftFourViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "透明导航栏 - 第 \(indexPath.row) 行"
        cell.textLabel?.textColor = UIColor.white
        
        // 使用缓存优化背景色
        if TFYSwiftNavigationConfig.enableCaching {
            let cellColor = TFYSwiftNavigationCacheManager.getCachedColor(forKey: "cell_bg_\(indexPath.row % 5)") ?? UIColor.systemBlue
            cell.contentView.backgroundColor = cellColor
        } else {
            cell.contentView.backgroundColor = UIColor.systemBlue
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 滚动时动态调整导航栏透明度
        let offset = scrollView.contentOffset.y
        let alpha = max(0, min(1, offset / 100))
        
        // 异步更新导航栏透明度
        TFYSwiftNavigationAsyncLayoutManager.performAsyncUIUpdate { [weak self] in
            self?.tfy_navigationBar.alpha = 1 - alpha
        }
    }
}
