#
#  Be sure to run `pod spec lint ADDemo.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "ADDemo"
  spec.version      = "0.0.1"
  spec.summary      = "广告项目"

  spec.description  = <<-DESC
  广告
                   DESC

  spec.homepage     = "http://EXAMPLE/ADDemo"


  spec.license      = { :type => "MIT" }

  spec.platform     = :ios
  
  spec.swift_versions = ['5.0', '5.1', '5.2', '5.3']
  
  spec.author       = { "jingjun" => "rxswift@126.com" }
  
  spec.platform     = :ios, "11.0"

  spec.source       = { :git => "https://github.com/xingtianwuganqi/ADDemo.git", :tag => "#{spec.version}" }

  spec.source_files = "ADDemo/ADPage/*.swift"
  spec.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }

  
  spec.frameworks   = ["Foundation","UIKit"]

  #spec.dependency 'BasicProject'
  spec.dependency 'AnyThinkiOS'
  spec.dependency 'AnyThinkiOS/AnyThinkTTAdapter'
  spec.dependency 'AnyThinkGDTAdapter'
  
  spec.subspec 'BasicProject' do |ss|
    ss.source_files   = "./../iOS_BasicProject/BasicProject/Thrpart/*.{h,m}","./../iOS_BasicProject/BasicProject/Base/*.swift", "BasicProject/Common/*.swift", "./../iOS_BasicProject/BasicProject/Extension/*.swift"'
    ss.framework  = ["Foundation","UIKit","Photos"]
  end

end
