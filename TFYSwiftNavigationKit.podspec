Pod::Spec.new do |spec|

  spec.name         = "TFYSwiftNavigationKit"

  spec.version      = "2.2.0"

  spec.summary      = "Swift版的 导航栏设置，基本需求都可以满足，最新支持 iOS 15 -- Swift 5 "

  spec.description  = <<-DESC
  Swift版的 导航栏设置，基本需求都可以满足，最新支持 iOS 15 -- Swift 5 
                   DESC

  spec.homepage     = "https://github.com/13662049573/TFYSwiftNavigationController"
  
  spec.license      = "MIT"
  
  spec.author       = { "田风有" => "420144542@qq.com" }
  
  spec.platform     = :ios, "15.0"

  spec.swift_version = '5.0'

  spec.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }

  spec.source       = { :git => "https://github.com/13662049573/TFYSwiftNavigationController.git", :tag => spec.version }

  spec.source_files  = "TFYSwiftNavigationController/TFYSwiftNavigationKit/*.{swift}"

  spec.requires_arc = true

end
