//
//  TFYSwiftNavigationBar.swift
//  TFYSwiftNavigationController
//
//  Created by mi ni on 2025/2/13.
//

import Foundation
import UIKit

// MARK: - Type Aliases
typealias TFYSwiftNavigationBarFrameDidUpdated = (CGRect) -> Void

// MARK: - Navigation Bar Style Configuration
/// 导航栏默认样式配置
@available(iOS 15.0, *)
public struct TFYSwiftNavigationBarStyle {
    /// 导航栏返回按钮图片
    public static var backImage: UIImage? = TFYSwiftNavigationBarUtility.backImage
    /// 自定义视图定制导航栏返回按钮
    public static var backButtonCustomView: UIView? = nil
    /// 导航栏背景图片
    public static var backgroundImage: UIImage? = nil
    /// 导航栏背景颜色
    public static var backgroundColor: UIColor = UIColor(white: 237.0/255, alpha: 1.0)
    /// 导航栏标题设置
    public static var titleTextAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 18),
        .foregroundColor: UIColor.black
    ]
    /// 导航栏的tintColor
    public static var tintColor: UIColor = UIColor(white: 24.0/255, alpha: 1.0)
    /// 导航栏底部阴影图片
    public static var shadowImage: UIImage? = UIImage()
    /// 是否全屏左滑手势(自定义)
    public static var fullScreenPopGestureEnabled = false
    /// 调整导航栏 BarButtonItem 距离屏幕左右的间距(0 使用系统的间距 其他动态调整间距)
    public static var itemSpace: CGFloat = 0
    /// 是否启用全屏滑动返回
    public static var fullScreenInteractivePopEnabled: Bool = false
    /// 是否禁用滑动返回
    public static var disableInteractivePopGesture: Bool = false
    /// 全屏滑动返回的最大允许距离
    public static var fullScreenPopMaxAllowedDistanceToLeftEdge: CGFloat = 0.0
}

// MARK: - Custom Navigation Bar View
/// 自定义导航栏视图
@available(iOS 15.0, *)
public class TFYSwiftNavigationBar: UIView {
    
    // MARK: - UI Components
    /// 背景图片视图
    internal lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    /// 底部分割线视图
    internal lazy var shadowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    /// 内容视图
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// 毛玻璃背景视图
    internal lazy var visualEffectView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .systemChromeMaterial)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.isHidden = true
        effectView.contentView.backgroundColor = UIColor.clear
        effectView.translatesAutoresizingMaskIntoConstraints = false
        return effectView
    }()
    
    // MARK: - Public Properties
    /// 毛玻璃效果视图（只读）
    public var blurEffectView: UIVisualEffectView {
        return visualEffectView
    }
    
    /// 毛玻璃效果是否启用
    public var isBlurEffectEnabled: Bool {
        return !visualEffectView.isHidden
    }
    
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        addSubview(backgroundImageView)
        addSubview(visualEffectView)
        addSubview(shadowImageView)
        addSubview(containerView)
        
        backgroundImageView.image = TFYSwiftNavigationBarStyle.backgroundImage
        setupConstraints()
    }
    
    private func setupConstraints() {
        // 移除可能存在的约束
        removeConstraints(constraints)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            visualEffectView.topAnchor.constraint(equalTo: topAnchor),
            visualEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            shadowImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shadowImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            shadowImageView.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
        ])
        
        // 设置容器视图的顶部约束
        let safeAreaTop: CGFloat = TFYSwiftNavigationBarUtility.keyWindow?.safeAreaInsets.top ?? 44.0
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: safeAreaTop).isActive = true
    }
    // MARK: - Public Methods
    /// 是否使用毛玻璃效果
    public func enableBlurEffect(_ enabled: Bool) {
        // 使用动画切换毛玻璃效果
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundColor = enabled ? .clear : nil
            self.backgroundImageView.alpha = enabled ? 0.0 : 1.0
            self.visualEffectView.alpha = enabled ? 1.0 : 0.0
        }) { _ in
            self.backgroundImageView.isHidden = enabled
            self.visualEffectView.isHidden = !enabled
        }
    }
    
    /// 内容视图添加子视图
    public func add(_ subView: UIView) {
        containerView.addSubview(subView)
    }
    
    /// 初始化在 didFinishLaunchingWithOptions
    public class func setup() {
        UINavigationBar.swizzleUINavigationBarOnce
        UIViewController.swizzleUIViewControllerOnce
        UINavigationController.swizzleUINavigationControllerOnce
    }
}

// MARK: - UINavigationBar Extension
@available(iOS 15.0, *)
extension UINavigationBar {
    
    /// 关联对象Keys
    private struct AssociatedKeys {
        static var frameDidUpdated = UnsafeRawPointer(bitPattern: "frameDidUpdated".hashValue)!
    }
    
    /// UINavigationBar swizzleMethod
    static let swizzleUINavigationBarOnce: Void = {
        let cls = UINavigationBar.self
        TFYSwiftNavigationBarUtility.swizzleMethod(cls, #selector(UINavigationBar.layoutSubviews), #selector(UINavigationBar.nav_layoutSubviews))
    }()
    
    /// frame改变的回调
    var frameDidUpdated: TFYSwiftNavigationBarFrameDidUpdated? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.frameDidUpdated) as? TFYSwiftNavigationBarFrameDidUpdated
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.frameDidUpdated, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    /// 加载布局
    @objc private func nav_layoutSubviews() {
        frameDidUpdated?(frame)
        effectBackdropView()
        nav_layoutSubviews()
        
        /// UIBarButtonItem 距离屏幕的左右间距
        if TFYSwiftNavigationBarStyle.itemSpace > 0 {
            configureBarButtonItemSpacing()
        }
    }
    
    private func configureBarButtonItemSpacing() {
        for subView in subviews {
            if NSStringFromClass(subView.classForCoder).contains("ContentView") {
                let space = TFYSwiftNavigationBarStyle.itemSpace
                let margins = subView.layoutMargins
                var tmpFrame = CGRect(x: 0,
                                   y: margins.top,
                                   width: 0,
                                   height: subView.frame.height)
                tmpFrame.origin.x = -margins.left + space
                tmpFrame.size.width = margins.left + margins.right + subView.frame.width - 2 * space
                subView.frame = tmpFrame
                break
            }
        }
    }
    
    private func effectBackdropView() {
        let viewbacks: [UIView] = subviews
        viewbacks.forEach { view in
            if view.isKind(of: NSClassFromString("UIVisualEffectView")!) {
                let effectViews: [UIView] = view.subviews
                effectViews.forEach { effView in
                    if effView.isKind(of: NSClassFromString("_UIVisualEffectBackdropView")!) {
                        effView.removeFromSuperview()
                    }
                }
            }
        }
    }
}

// MARK: - UIBarButtonItem Extension
@available(iOS 15.0, *)
public extension UIBarButtonItem {
    func configure(_ block: (UIBarButtonItem) -> Void) -> UIBarButtonItem {
        block(self)
        return self
    }
}

// MARK: - Utility Class
@available(iOS 15.0, *)
class TFYSwiftNavigationBarUtility {
    
    /// 导航栏返回按钮图片
    static var backImage: UIImage? = {
        let backButtonImageBase64 = "iVBORw0KGgoAAAANSUhEUgAAABIAAAAkCAYAAACE7WrnAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAEqADAAQAAAABAAAAJAAAAAC0yP9zAAABSElEQVRIDa2WO0oEQRCGF99vT+AewQN4DXNBUFQwMDAw2GADgw0MBGMjwUAQBEVBFEQRBPEUnsPH1zA/DIUIf281/FQVU/11T/d09XQ6SW10SM4J/bvoYxjOMZ1/0DfaqAUdNZACKjqtAQ0C5Ix4xAUdBsg5sb3O/QC5qIH0AuSSeAxZ7YBsLWqxV2jcIpC8j9qQG+IJF7IXIHfEky5kN0DuiadcyHaAPBJPu5BNOpRPXuvyhD+DrLZOdhvyQjxrEUheQ19IM3nFn0NWWyW7DXkjXrAITfInVjN5x1+sgdin9r9B0l6tDJKy2Jpt3P5nHtjbL1jKBynYDo52sdiqIyJYyqEVLJaRWx7YZUSwWNiueWAXNsFSSq1gKcVfsD5OezerriPBUi5Iwf68su3rFtoDmkcrDXkZu9T4VSblt0Yjlx+tLQUp9heUA33Up/m/hAAAAABJRU5ErkJggg=="
        if let data = Data(base64Encoded: backButtonImageBase64, options: .ignoreUnknownCharacters) {
            return UIImage(data: data, scale: 2.0)
        }
        return nil
    }()
    
    /// 获取应用程序的主窗口
    static var keyWindow: UIWindow? {
        guard let windowScene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else {
            return nil
        }
        return windowScene.windows.first
    }
    
    /// 获取导航栏高度
    static var navigationBarHeight: CGFloat {
        let top = keyWindow?.safeAreaInsets.top ?? 44.0
        return top + 44.0
    }
    
    /// 颜色转图片
    public class func imageFrom(color: UIColor) -> UIImage? {
        let size = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 方法交换
    public class func swizzleMethod(_ cls: AnyClass, _ originSelector: Selector, _ newSelector: Selector) {
        guard let oriMethod = class_getInstanceMethod(cls, originSelector),
              let newMethod = class_getInstanceMethod(cls, newSelector) else {
            return
        }
        
        let isAddedMethod = class_addMethod(cls, originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))
        if isAddedMethod {
            class_replaceMethod(cls, newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod))
        } else {
            method_exchangeImplementations(oriMethod, newMethod)
        }
    }
}

// MARK: - Associated Object Manager
@available(iOS 15.0, *)
class TFYSwiftAssociatedObjectManager {
    
    /// 获取关联对象
    static func getAssociatedObject<T>(_ object: AnyObject, key: UnsafeRawPointer, defaultValue: T) -> T {
        if let value = objc_getAssociatedObject(object, key) as? T {
            return value
        }
        objc_setAssociatedObject(object, key, defaultValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return defaultValue
    }
    
    /// 设置关联对象
    static func setAssociatedObject<T>(_ object: AnyObject, key: UnsafeRawPointer, value: T) {
        objc_setAssociatedObject(object, key, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    /// 获取关联对象（可空类型）
    static func getAssociatedObject<T>(_ object: AnyObject, key: UnsafeRawPointer) -> T? {
        return objc_getAssociatedObject(object, key) as? T
    }
    
    /// 设置关联对象（可空类型）
    static func setAssociatedObject<T>(_ object: AnyObject, key: UnsafeRawPointer, value: T?) {
        objc_setAssociatedObject(object, key, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

