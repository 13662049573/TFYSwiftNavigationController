//
//  UIViewControllerr+NavigationBar.swift
//  TFYSwiftNavigationController
//
//  Created by 田风有 on 2022/5/4.
//

import Foundation
import UIKit

// MARK: -  自定义导航栏相关的属性, 支持UINavigationBar.appearance()

fileprivate var barStyleKey: Void?
fileprivate var backgroundColorKey: Void?
fileprivate var backgroundImageKey: Void?
fileprivate var tintColorKey: Void?
fileprivate var barAlphaKey: Void?
fileprivate var titleColorKey: Void?
fileprivate var titleFontKey: Void?
fileprivate var shadowHiddenKey: Void?
fileprivate var shadowColorKey: Void?
fileprivate var enablePopGestureKey: Void?
fileprivate var transparentKey: Void?

public extension UIViewController {
    
    /// 导航栏样式，默认样式
    var tfy_barStyle: UIBarStyle {
        get {
            return objc_getAssociatedObject(self, &barStyleKey) as? UIBarStyle ?? UINavigationBar.appearance().barStyle
        }
        set {
            objc_setAssociatedObject(self, &barStyleKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            tfy_setNeedsNavigationBarTintUpdate()
        }
    }
    
    /// 导航栏前景色（item的文字图标颜色），默认黑色
    var tfy_tintColor: UIColor {
        get {
            if let tintColor = objc_getAssociatedObject(self, &tintColorKey) as? UIColor {
                return tintColor
            }
            if let tintColor = UINavigationBar.appearance().tintColor {
                return tintColor
            }
            return .black
        }
        set {
            objc_setAssociatedObject(self, &tintColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            tfy_setNeedsNavigationBarTintUpdate()
        }
    }
    
    
    /// 导航栏标题文字颜色，默认黑色
    var tfy_titleColor: UIColor {
        get {
            if let titleColor = objc_getAssociatedObject(self, &titleColorKey) as? UIColor {
                return titleColor
            }
            if let titleColor = UINavigationBar.appearance().titleTextAttributes?[NSAttributedString.Key.foregroundColor] as? UIColor {
                return titleColor
            }
            return .black
        }
        set {
            objc_setAssociatedObject(self, &titleColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            tfy_setNeedsNavigationBarTintUpdate()
        }
    }
    
    /// 导航栏标题文字字体，默认17号粗体
    var tfy_titleFont: UIFont {
        get {
            if let titleFont = objc_getAssociatedObject(self, &titleFontKey) as? UIFont {
                return titleFont
            }
            if let titleFont = UINavigationBar.appearance().titleTextAttributes?[NSAttributedString.Key.font] as? UIFont {
                return titleFont
            }
            return UIFont.boldSystemFont(ofSize: 17)
        }
        set {
            objc_setAssociatedObject(self, &titleFontKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            tfy_setNeedsNavigationBarTintUpdate()
        }
    }
    
    
    /// 导航栏背景色，默认白色
    var tfy_backgroundColor: UIColor {
        get {
            if let backgroundColor = objc_getAssociatedObject(self, &backgroundColorKey) as? UIColor {
                return backgroundColor
            }
            if let backgroundColor = UINavigationBar.appearance().barTintColor {
                return backgroundColor
            }
            return .white
        }
        set {
            objc_setAssociatedObject(self, &backgroundColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            tfy_setNeedsNavigationBarBackgroundUpdate()
        }
    }
    
    /// 导航栏背景图片
    var tfy_backgroundImage: UIImage? {
        get {
            return objc_getAssociatedObject(self, &backgroundImageKey) as? UIImage ?? UINavigationBar.appearance().backgroundImage(for: .default)
        }
        set {
            objc_setAssociatedObject(self, &backgroundImageKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            tfy_setNeedsNavigationBarBackgroundUpdate()
        }
    }
    
    /// 导航栏背景透明度，默认1
    var tfy_barAlpha: CGFloat {
        get {
            return objc_getAssociatedObject(self, &barAlphaKey) as? CGFloat ?? 1
        }
        set {
            objc_setAssociatedObject(self, &barAlphaKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            tfy_setNeedsNavigationBarBackgroundUpdate()
            if newValue == 0 {
                self.navigationController?.navigationBar.isTranslucent = true
            }
        }
    }

    /// 导航栏底部分割线是否隐藏，默认不隐藏
    var tfy_shadowHidden: Bool {
        get {
            return objc_getAssociatedObject(self, &shadowHiddenKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &shadowHiddenKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            tfy_setNeedsNavigationBarShadowUpdate()
        }
    }
    
    /// 导航栏底部分割线颜色
    var tfy_shadowColor: UIColor {
        get {
            return objc_getAssociatedObject(self, &shadowColorKey) as? UIColor ?? UIColor(white: 0, alpha: 0.3)
        }
        set {
            objc_setAssociatedObject(self, &shadowColorKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            tfy_setNeedsNavigationBarShadowUpdate()
        }
    }
    
    /// 是否开启手势返回，默认开启
    var tfy_enablePopGesture: Bool {
        get {
            return objc_getAssociatedObject(self, &enablePopGestureKey) as? Bool ?? true
        }
        set {
            objc_setAssociatedObject(self, &enablePopGestureKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    // MARK: -  更新UI

    // 整体更新
    func tfy_setNeedsNavigationBarUpdate() {
        guard let naviController = navigationController as? TFYSwiftNavigationController else { return }
        naviController.tfy_updateNavigationBar(for: self)
    }
    
    // 更新文字、title颜色
    func tfy_setNeedsNavigationBarTintUpdate() {
        guard let naviController = navigationController as? TFYSwiftNavigationController else { return }
        naviController.tfy_updateNavigationBarTint(for: self)
    }

    // 更新背景
    func tfy_setNeedsNavigationBarBackgroundUpdate() {
        guard let naviController = navigationController as? TFYSwiftNavigationController else { return }
        naviController.tfy_updateNavigationBarBackground(for: self)
    }
    
    // 更新shadow
    func tfy_setNeedsNavigationBarShadowUpdate() {
        guard let naviController = navigationController as? TFYSwiftNavigationController else { return }
        naviController.tfy_updateNavigationBarShadow(for: self)
    }
    
}


