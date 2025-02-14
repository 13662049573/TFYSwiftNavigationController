//
//  DemoViewController.swift
//  TFYSwiftNavigationController
//
//  Created by 田风有 on 2021/5/15.
//

import UIKit

class DemoViewController: UIViewController {

    @IBOutlet weak var barAlphaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "首页\(navigationController!.viewControllers.count % 2)"
        if navigationController!.viewControllers.count % 2 == 0 {
//            tfy_backgroundColor = .blue
//            tfy_tintColor = .white
//            tfy_titleColor = .white
//        } else {
            tfy_backgroundColor = .white
            tfy_tintColor = .red
            tfy_titleColor = .red
            tfy_barStyle = .default
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear: \(title!)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear: \(title!)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear: \(title!)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear: \(title!)")
    }
    
    @IBAction func barColorBtnClicked(_ sender: UIButton) {
        guard let color = sender.backgroundColor else { return }
        tfy_backgroundColor = color
    }
    
    @IBAction func barImageSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            let image = UIImage(named: "nav")
            tfy_backgroundImage = image
        } else {
            tfy_backgroundImage = nil
        }
    }
    
    @IBAction func blackBarStyleSwitchChanged(_ sender: UISwitch) {
        tfy_barStyle = sender.isOn ? .black : .default
    }
    
    @IBAction func shadowHiddenSwitchChanged(_ sender: UISwitch) {
        tfy_shadowHidden = sender.isOn
    }
    
    @IBAction func barAlphaSliderChanged(_ sender: UISlider) {
        barAlphaLabel.text = String(format: "%.2f", sender.value)
        tfy_barAlpha = CGFloat(sender.value)
    }
    
    @IBAction func tintColorBtnClicked(_ sender: UIButton) {
        guard let color = sender.backgroundColor else { return }
        tfy_tintColor = color
    }
    
    @IBAction func titleColorBtnClicked(_ sender: UIButton) {
        guard let color = sender.backgroundColor else { return }
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
    
}
