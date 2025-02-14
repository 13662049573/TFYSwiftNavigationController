//
//  TFYSwiftOneViewController.swift
//  TFYSwiftNavigationController
//
//  Created by mi ni on 2025/2/13.
//

import UIKit

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
        "自定义滑动返回距离"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}

// MARK: - UITableViewDelegate & DataSource
extension TFYSwiftOneViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = demos[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var vc = UIViewController()
        vc.view.backgroundColor = .systemBackground
        vc.title = demos[indexPath.row]
        switch indexPath.row {
            case 0:
            vc = TFYSwiftTwoViewController()
            break
            case 1:
            vc = TFYSwiftTherrViewController()
            break
            case 2:
            vc = TFYSwiftFourViewController()
            break
            case 3:
            vc = TFYSwiftFiveViewController()
            break
            case 4:
            vc = TFYSwiftSexViewController()
            break
            case 5:
            vc = TFYSwiftSevenViewController()
            break
            case 6:
            vc = TFYSwiftEightViewController()
            break
            case 7:
            vc = TFYSwiftNineViewController()
            break
            case 8:
            vc = TFYSwiftTenViewController()
            break
            case 9:
            vc = TFYSwiftElevenViewController()
            break
        default:
            break
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
