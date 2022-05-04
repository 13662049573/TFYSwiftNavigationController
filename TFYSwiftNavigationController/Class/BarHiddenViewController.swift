//
//  BarHiddenViewController.swift
//  TFYSwiftNavigationController
//
//  Created by 田风有 on 2021/5/15.
//

import UIKit

class BarHiddenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tfy_barAlpha = 0
        tfy_tintColor = .clear
        tfy_titleColor = .clear
        tfy_barStyle = .default
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func back() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func nextVC() {
        guard let demoVC = storyboard?.instantiateViewController(withIdentifier: "DemoViewController") else { return }
        navigationController?.pushViewController(demoVC, animated: true)
    }
}
