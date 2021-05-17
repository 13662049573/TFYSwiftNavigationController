
Pod::Spec.new do |spec|

  spec.name         = "TFYSwiftNavigationKit"

  spec.version      = "2.0.0"

  spec.summary      = "Swift版的 导航栏设置，基本需求都可以满足，最新支持 iOS 13 -- Swift 5 "

  spec.description  = <<-DESC
  Swift版的 导航栏设置，基本需求都可以满足，最新支持 iOS 13 -- Swift 5 
                   DESC

  spec.homepage     = "https://github.com/13662049573/TFYSwiftNavigationController"
  
  spec.license      = "MIT"
  
  spec.author             = { "田风有" => "420144542@qq.com" }
  
  spec.platform     = :ios, "13.0"

  spec.swift_version = '5.0'

  spec.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }

  spec.source       = { :git => "https://github.com/13662049573/TFYSwiftNavigationController.git", :tag => spec.version }

  
  spec.subspec 'Extension' do |ss|
    ss.source_files  = "TFYSwiftNavigationKit/TFYSwiftNavigationKit/Extension/*.{swift}"
    ss.dependency "TFYSwiftNavigationKit/Xcassets"
    ss.dependency "TFYSwiftNavigationKit/Base"
  end

  spec.subspec 'Base' do |ss|
    ss.source_files  = "TFYSwiftNavigationKit/TFYSwiftNavigationKit/Base/*.{swift}"
  end
  
  spec.subspec 'Xcassets' do |ss|
    ss.resource_bundles = { 'TFYNavigationBar' => ['TFYSwiftNavigationKit/TFYSwiftNavigationKit/*.xcassets'] }
  end
  
  spec.requires_arc = true

end