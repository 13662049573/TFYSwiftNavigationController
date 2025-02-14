//
//  ProfileViewController.swift
//  TFYSwiftNavigationController
//
//  Created by 田风有 on 2021/5/15.
//

import UIKit

class ProfileViewController: UITableViewController {

    @IBOutlet weak var header: UIView!
    @IBOutlet weak var headerView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        let headerFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width * 0.75)
        header.frame = headerFrame
        headerView.frame = headerFrame
        headerView.image = UIImage(named: "back_5")
        tfy_backgroundColor = .cyan
        tfy_barAlpha = 0
        tfy_tintColor = .white
        tfy_titleColor = UIColor(white: 0, alpha: 0)
        tfy_shadowHidden = true
    }
    
    private func adjustHeaderFrame() {
        var imageWidth = view.bounds.width
        var imageHeight = imageWidth * 0.75
        var originY: CGFloat = 0
        let contentOffsetY = tableView.contentOffset.y
        if contentOffsetY < 0 {
            originY += contentOffsetY
            imageHeight -= contentOffsetY
            imageWidth = imageHeight / 0.75
        }
        let headViewFrame = CGRect(x: (view.bounds.width - imageWidth) / 2, y: originY, width: imageWidth, height: imageHeight)
        headerView.frame = headViewFrame
    }
    
    @IBAction func popToRoot(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "个人中心 \(indexPath.row + 1)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let barHiddenVC = storyboard?.instantiateViewController(withIdentifier: "BarHiddenViewController") else { return }
        navigationController?.pushViewController(barHiddenVC, animated: true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerHeight = view.bounds.width * 0.75
        let contentOffsetY = scrollView.contentOffset.y
        let progress = min(1, max(0, contentOffsetY / headerHeight))
        if progress < 0.1 {
            tfy_barStyle = .black
            tfy_tintColor = .white
            tfy_titleColor = UIColor(white: 0, alpha: 0)
        } else {
            tfy_barStyle = .default
            tfy_tintColor = UIColor(white: 0, alpha: progress)
            tfy_titleColor = UIColor(white: 0, alpha: progress)
        }
        tfy_barAlpha = progress
        adjustHeaderFrame()
    }
    
}
