# 🚀 TFYSwiftNavigationKit

[![Version](https://img.shields.io/cocoapods/v/TFYSwiftNavigationKit.svg?style=flat)](https://cocoapods.org/pods/TFYSwiftNavigationKit)
[![License](https://img.shields.io/cocoapods/l/TFYSwiftNavigationKit.svg?style=flat)](https://cocoapods.org/pods/TFYSwiftNavigationKit)
[![Platform](https://img.shields.io/cocoapods/p/TFYSwiftNavigationKit.svg?style=flat)](https://cocoapods.org/pods/TFYSwiftNavigationKit)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-16.0+-blue.svg)](https://developer.apple.com/ios/)

<div align="center">
  <img src="https://img.shields.io/badge/Performance-Optimized-green.svg" alt="Performance Optimized">
  <img src="https://img.shields.io/badge/Memory-Efficient-blue.svg" alt="Memory Efficient">
  <img src="https://img.shields.io/badge/Async-Layout-yellow.svg" alt="Async Layout">
  <img src="https://img.shields.io/badge/Cache-Enabled-purple.svg" alt="Cache Enabled">
</div>

## 📖 简介

**TFYSwiftNavigationKit** 是一个专为 iOS 16+ 设计的高性能、现代化的 Swift 导航栏管理库。它提供了完整的导航栏自定义解决方案，支持流畅的动画效果、内存优化、异步布局等高级特性。

### ✨ 核心优势

- 🚀 **高性能优化** - 采用异步布局、智能缓存、内存管理
- 🎨 **完全自定义** - 支持背景、阴影、毛玻璃、渐变等效果
- 📱 **现代化设计** - 专为 iOS 16+ 优化，支持最新系统特性
- 🔧 **易于集成** - 简单的 API 设计，快速上手
- 🛡️ **稳定可靠** - 经过严格测试，生产环境验证

## 🎯 主要特性

### 🎨 视觉定制
- [x] **完全自定义导航栏样式** - 背景色、透明度、阴影等
- [x] **毛玻璃效果** - 支持系统级毛玻璃背景
- [x] **渐变背景** - 支持线性渐变和径向渐变
- [x] **背景图片** - 支持自定义背景图片
- [x] **动态阴影** - 可调节阴影颜色和透明度
- [x] **自定义返回按钮** - 支持图片和自定义视图

### 🖱️ 交互体验
- [x] **全屏返回手势** - 支持全屏滑动返回
- [x] **手势距离控制** - 可设置手势响应距离
- [x] **流畅动画** - 60fps 流畅过渡动画
- [x] **智能手势识别** - 防止误触和冲突

### ⚡ 性能优化
- [x] **异步布局** - 后台线程处理复杂布局
- [x] **智能缓存** - 图片和颜色缓存机制
- [x] **内存优化** - 弱引用管理，防止内存泄漏
- [x] **性能监控** - 内置性能指标监控

### 🔧 开发体验
- [x] **简单 API** - 链式调用，代码简洁
- [x] **类型安全** - 完整的 Swift 类型系统支持
- [x] **配置验证** - 自动验证配置参数
- [x] **调试支持** - 详细的日志和错误提示

## 📋 系统要求

- **iOS 16.0+** - 支持最新的 iOS 系统
- **Swift 5.0+** - 使用最新的 Swift 语法
- **Xcode 13.0+** - 支持最新的开发工具

## 🚀 快速开始

### 安装

#### CocoaPods

```ruby
pod 'TFYSwiftNavigationKit'
```

#### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/your-repo/TFYSwiftNavigationKit.git", from: "1.0.0")
]
```

### 基本使用

#### 1. 初始化导航控制器

```swift
import TFYSwiftNavigationKit

class CustomNavigationController: TFYSwiftNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // 启用性能优化
        TFYSwiftNavigationConfig.enablePerformanceOptimization = true
    }
}
```

#### 2. 配置导航栏样式

```swift
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置导航栏背景色
        tfy_navigationBarBackgroundColor = .systemBlue
        
        // 设置导航栏透明度
        tfy_navigationBar.alpha = 0.9
        
        // 设置标题样式
        tfy_titleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .foregroundColor: UIColor.white
        ]
        
        // 启用毛玻璃效果
        tfy_useSystemBlurNavBar = true
        
        // 自定义返回按钮
        tfy_backImage = UIImage(named: "custom_back")
    }
}
```

#### 3. 高级配置

```swift
// 性能配置
TFYSwiftNavigationConfig.enableCaching = true
TFYSwiftNavigationConfig.enableAsyncLayout = true
TFYSwiftNavigationConfig.animationDuration = 0.25

// 手势配置
TFYSwiftNavigationConfig.gestureMinimumDistance = 10.0
TFYSwiftNavigationConfig.gestureMaximumVelocity = 1000.0

// 视觉配置
TFYSwiftNavigationConfig.navigationBarAlpha = 1.0
TFYSwiftNavigationConfig.shadowAlpha = 0.1
TFYSwiftNavigationConfig.blurIntensity = 0.8
```

## 🎨 高级用法

### 动态导航栏

```swift
// 滚动时动态改变导航栏透明度
func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offset = scrollView.contentOffset.y
    let alpha = max(0, min(1, offset / 100))
    tfy_navigationBar.alpha = alpha
}
```

### 渐变背景

```swift
// 创建渐变背景
let gradientLayer = CAGradientLayer()
gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemPurple.cgColor]
gradientLayer.frame = tfy_navigationBar.bounds
tfy_navigationBar.layer.insertSublayer(gradientLayer, at: 0)
```

### 自定义返回按钮

```swift
// 创建自定义返回按钮
let customBackButton = UIButton(type: .custom)
customBackButton.setImage(UIImage(named: "back_icon"), for: .normal)
customBackButton.addTarget(self, action: #selector(customBackAction), for: .touchUpInside)
tfy_backButtonCustomView = customBackButton
```

### 性能监控

```swift
// 监控导航栏更新性能
TFYSwiftNavigationPerformanceMonitor.startMonitoring("navigation_update")
// ... 执行导航栏更新
if let duration = TFYSwiftNavigationPerformanceMonitor.endMonitoring("navigation_update") {
    TFYSwiftNavigationPerformanceMonitor.recordMetric("navigation_update", duration: duration)
}
```

## 📊 性能特性

### 缓存机制
- **图片缓存** - 自动缓存导航栏背景图片
- **颜色缓存** - 缓存常用颜色值
- **布局缓存** - 缓存复杂布局计算结果

### 内存管理
- **弱引用** - 防止循环引用导致的内存泄漏
- **自动清理** - 定期清理无效的弱引用
- **内存监控** - 实时监控内存使用情况

### 异步处理
- **异步布局** - 后台线程处理复杂布局
- **异步渲染** - 异步处理图片和渐变效果
- **主线程优化** - 减少主线程阻塞

## 🔧 配置选项

### 性能配置
```swift
TFYSwiftNavigationConfig.enablePerformanceOptimization = true  // 启用性能优化
TFYSwiftNavigationConfig.enableCaching = true                 // 启用缓存
TFYSwiftNavigationConfig.enableAsyncLayout = true             // 启用异步布局
TFYSwiftNavigationConfig.enableMemoryOptimization = true      // 启用内存优化
```

### 动画配置
```swift
TFYSwiftNavigationConfig.animationDuration = 0.25            // 动画持续时间
TFYSwiftNavigationConfig.enableSmoothAnimation = true         // 启用流畅动画
```

### 手势配置
```swift
TFYSwiftNavigationConfig.gestureMinimumDistance = 10.0        // 最小手势距离
TFYSwiftNavigationConfig.gestureMaximumVelocity = 1000.0     // 最大手势速度
```

## 📱 示例项目

查看完整的示例项目，了解所有功能的使用方法：

1. 克隆仓库
```bash
git clone https://github.com/your-repo/TFYSwiftNavigationKit.git
cd TFYSwiftNavigationKit
```

2. 安装依赖
```bash
pod install
```

3. 打开示例项目
```bash
open TFYSwiftNavigationController.xcworkspace
```

## 🤝 贡献

我们欢迎所有形式的贡献！请查看我们的 [贡献指南](CONTRIBUTING.md)。

### 开发环境设置
1. Fork 项目
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开 Pull Request

## 📄 许可证

本项目基于 MIT 许可证开源。详见 [LICENSE](LICENSE) 文件。

## 👨‍💻 作者

**田风有** - [13662049573](tel:13662049573) - [420144542@qq.com](mailto:420144542@qq.com)

## 🙏 致谢

感谢所有为这个项目做出贡献的开发者！

---

<div align="center">
  <strong>如果这个项目对你有帮助，请给我们一个 ⭐️</strong>
</div>
