//
//  TFYNavigationBar.swift
//  TFYSwiftNavigationKit
//
//  Created by 田风有 on 2021/5/15.
//

import UIKit

open class TFYNavigationBar: UINavigationBar {

    open var automaticallyAdjustsPosition: Bool = true

    open var additionalHeight: CGFloat = 0 {
        didSet {
            frame.size.height = barHeight + _additionalHeight
            viewController?.adjustsSafeAreaInsetsAfterIOS11()
        }
    }
    
    /// 隐藏导航栏下面的黑线
    open var isShadowHidden: Bool = false {
        didSet {
            guard let background = subviews.first else { return }
            background.clipsToBounds = isShadowHidden
        }
    }

    /// 状态栏颜色
    open var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            superNavigationBar?.barStyle = superBarStyle
        }
    }
    
    /// 用于子导航项中的后退按钮的栏按钮项。
    open var backBarButtonItem: TFYBarButtonItem? {
        didSet {
            backBarButtonItem?.navigationController = viewController?.navigationController
            
            viewController?._navigationItem.leftBarButtonItem = backBarButtonItem
        }
    }
    
    /// 导航栏内容视图的填充。
    @available(iOS 11.0, *)
    open var layoutPaddings: UIEdgeInsets {
        get { _layoutPaddings }
        set { _layoutPaddings = newValue }
    }
    
    /// 导航栏底部的附加视图
    open var additionalView: UIView? {
        didSet {
            guard let additionalView = additionalView else {
                oldValue?.removeFromSuperview()
                return
            }
            
            setupAdditionalView(additionalView)
        }
    }

    /// 导航栏下面的线条
    open var shadow: NavigationShadow = .none {
        didSet { layer.apply(shadow) }
    }
    
    private lazy var appearance: UINavigationBarAppearance = {
        let appearance = UINavigationBarAppearance()
        
        if #available(iOS 15, *) {
            
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes =  self.titleTextAttributes ?? [:]
            appearance.backgroundColor = self.barTintColor
            appearance.largeTitleTextAttributes = self.largeTitleTextAttributes ?? [:]
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            
        } else {
            
            appearance.backgroundColor = self.barTintColor
            appearance.titleTextAttributes = self.titleTextAttributes ?? [:]
            appearance.largeTitleTextAttributes = self.largeTitleTextAttributes ?? [:]
            
        }
        return appearance
    }()
    
    private var _alpha: CGFloat = 1
    
    private var _layoutPaddings: UIEdgeInsets = .barLayoutPaddings
    
    private var _contentView: UIView?
    
    private weak var viewController: UIViewController?
    
    public convenience init(viewController: UIViewController) {
        self.init()
        self.viewController = viewController
        setItems([viewController._navigationItem], animated: false)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        _layoutSubviews()
    }
}

// MARK: - override
extension TFYNavigationBar {

    /// 隐藏导航栏
    open override var isHidden: Bool {
        didSet { viewController?.adjustsSafeAreaInsetsAfterIOS11() }
    }
    /// 是否透明度
    open override var isTranslucent: Bool {
        didSet {
            guard #available(iOS 13.0, *), !isTranslucent else { return }
            
            appearance.backgroundEffect = nil
            updateAppearance(appearance)
        }
    }

    /// 导航栏透明度
    open override var alpha: CGFloat {
        get { return super.alpha }
        set {
            _alpha = newValue
            
            layer.shadowOpacity = newValue < 1 ? 0 : shadow.opacity
            
            if let background = subviews.first {
                background.alpha = newValue
            }
        }
    }

    /// 背景颜色
    open override var barTintColor: UIColor? {
        didSet {
            guard #available(iOS 13.0, *) else { return }
            
            appearance.backgroundColor = barTintColor
            updateAppearance(appearance)
        }
    }
    

    ///映射到barTintColor
    open override var backgroundColor: UIColor? {
        get { return super.backgroundColor }
        set { barTintColor = newValue }
    }

    /// 导航栏下面线条背景图片
    open override var shadowImage: UIImage? {
        didSet {
            guard #available(iOS 13.0, *) else { return }
            
            appearance.shadowImage = shadowImage
            updateAppearance(appearance)
        }
    }

    /// 设置标题副本
    open override var titleTextAttributes: [NSAttributedString.Key : Any]? {
        didSet {
            guard #available(iOS 13.0, *) else { return }
            
            appearance.titleTextAttributes = titleTextAttributes ?? [:]
            updateAppearance(appearance)
        }
    }

    /// 开启有大标题
    open override var prefersLargeTitles: Bool {
        get { return super.prefersLargeTitles }
        set {
            guard super.prefersLargeTitles != newValue else { return }
            
            super.prefersLargeTitles = newValue
            
            superNavigationBar?.prefersLargeTitles = newValue
            
            guard #available(iOS 13.0, *) else { return }
            
            updateAppearance(appearance)
        }
    }

    /// 开启有大标题 设置
    open override var largeTitleTextAttributes: [NSAttributedString.Key : Any]? {
        get { return super.largeTitleTextAttributes }
        set {
            super.largeTitleTextAttributes = newValue
            
            viewController?.navigationItem.title = viewController?._navigationItem.title
            superNavigationBar?.largeTitleTextAttributes = newValue
            
            guard #available(iOS 13.0, *) else { return }
            
            appearance.largeTitleTextAttributes = newValue ?? [:]
            updateAppearance(appearance)
        }
    }

    /// 更改导航位置
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if super.point(inside: point, with: event) { return true }
        
        return additionalView?.frame.contains(point) ?? false
    }

    /// 背景图片
    open override func setBackgroundImage(
        _ backgroundImage: UIImage?,
        for barPosition: UIBarPosition,
        barMetrics: UIBarMetrics
    ) {
        super.setBackgroundImage(backgroundImage, for: barPosition, barMetrics: barMetrics)
        
        guard #available(iOS 13.0, *) else { return }
        
        appearance.backgroundImage = backgroundImage
        updateAppearance(appearance)
    }
}

extension TFYNavigationBar {
    
    var superBarStyle: UIBarStyle {
        return statusBarStyle == .lightContent ? .black : .default
    }
    
    var _additionalHeight: CGFloat {
        if #available(iOS 11.0, *) {
            if isLargeTitleShown { return 0 }
        }
        return additionalHeight
    }
    
    var barMinY: CGFloat {
        superNavigationBar?.frame.minY ?? .statusBarMaxY
    }
    
    func adjustsLayout() {
        guard let navigationBar = superNavigationBar else { return }
        
        if automaticallyAdjustsPosition {
            frame = navigationBar.frame
            frame.origin.y = barMinY
        } else {
            frame.size = navigationBar.frame.size
        }
        
        frame.size.height = navigationBar.frame.height + _additionalHeight
    }
}

// MARK: - private
private extension TFYNavigationBar {
    
    var superNavigationBar: UINavigationBar? {
        return viewController?.navigationController?.navigationBar
    }
    
    @available(iOS 11.0, *)
    var contentView: UIView? {
        if let contentView = _contentView { return contentView }
        
        _contentView = subviews.first {
            String(describing: $0.classForCoder) == "_UINavigationBarContentView"
        }
        
        return _contentView
    }
    
    @available(iOS 11.0, *)
    var isLargeTitleShown: Bool {
        return prefersLargeTitles && viewController?._navigationItem.largeTitleDisplayMode != .never
    }
    
    var barHeight: CGFloat {
        superNavigationBar?.frame.height ?? .navigationBarHeight
    }
    
    func _layoutSubviews() {
        guard let background = subviews.first else { return }
        background.alpha = _alpha
        background.clipsToBounds = isShadowHidden
        background.frame = CGRect(
            x: 0,
            y: -barMinY,
            width: bounds.width,
            height: bounds.height + barMinY
        )
        
        adjustsLayoutMarginsAfterIOS11()
    }
    
    func adjustsLayoutMarginsAfterIOS11() {
        guard #available(iOS 11.0, *) else { return }
        
        layoutMargins = .barLayoutMargins
        
        guard let contentView = contentView else { return }
        
        if #available(iOS 13.0, *) {
            contentView.frame = CGRect(
                x: layoutPaddings.left - layoutMargins.left,
                y: isLargeTitleShown ? 0 : additionalHeight,
                width: layoutMargins.left
                    + layoutMargins.right
                    - layoutPaddings.left
                    - layoutPaddings.right
                    + contentView.frame.width,
                height: contentView.frame.height
            )
        } else {
            contentView.frame.origin.y = isLargeTitleShown ? 0 : additionalHeight
            contentView.layoutMargins = layoutPaddings
        }
    }
    
    func setupAdditionalView(_ additionalView: UIView) {
        addSubview(additionalView)
        additionalView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            additionalView.topAnchor.constraint(equalTo: bottomAnchor),
            additionalView.leftAnchor.constraint(equalTo: leftAnchor),
            additionalView.widthAnchor.constraint(equalTo: widthAnchor),
            additionalView.heightAnchor.constraint(equalToConstant: additionalView.frame.height)
        ])
    }
    
    @available(iOS 13.0, *)
    func updateAppearance(_ appearance: UINavigationBarAppearance) {
        self.standardAppearance = appearance
        self.compactAppearance = appearance
        self.scrollEdgeAppearance = appearance
    }
}
