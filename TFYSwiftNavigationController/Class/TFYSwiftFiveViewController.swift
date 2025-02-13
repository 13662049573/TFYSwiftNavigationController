//
//  TFYSwiftFiveViewController.swift
//  TFYSwiftNavigationController
//
//  Created by mi ni on 2025/2/13.
//

import UIKit

class TFYSwiftFiveViewController: UIViewController {

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
            let layer = CAGradientLayer()
            layer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor] // 渐变颜色（红→蓝）
            layer.startPoint = CGPoint(x: 0, y: 0.5) // 水平渐变起点（左中）
            layer.endPoint = CGPoint(x: 1, y: 0.5)   // 水平渐变终点（右中）
            return layer
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "sssssss"
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(descriptionLabel)
        descriptionLabel.frame = CGRect(x: 20, y: 100, width: view.bounds.width - 40, height: 100)
        descriptionLabel.text = "当前展示: \(title ?? "")\n\n这是一个演示页面，用于展示不同的导航栏效果"
    }
    
    override var tfy_titleTextAttributes: [NSAttributedString.Key : Any]? {
        return [.font: UIFont.boldSystemFont(ofSize: 18),
                .foregroundColor: UIColor.yellow]
    }

}
