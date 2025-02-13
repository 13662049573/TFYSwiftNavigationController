//
//  TFYSwiftNineViewController.swift
//  TFYSwiftNavigationController
//
//  Created by mi ni on 2025/2/13.
//

import UIKit

class TFYSwiftNineViewController: UIViewController {

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(descriptionLabel)
        descriptionLabel.frame = CGRect(x: 20, y: 100, width: view.bounds.width - 40, height: 100)
        descriptionLabel.text = "当前展示: \(title ?? "")\n\n这是一个演示页面，用于展示不同的导航栏效果"
    }

    override var tfy_fullScreenPopMaxAllowedDistanceToLeftEdge: CGFloat {
        return 100
    }
}
