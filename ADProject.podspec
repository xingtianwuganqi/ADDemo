#
#  Be sure to run `pod spec lint ADProject.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|


  spec.name         = "ADProject"
  spec.version      = "0.0.1"
  spec.summary      = "ADProject Demo"

  spec.description  = <<-DESC
   a ADProject Demo
                   DESC

  spec.homepage     = "https://github.com/xingtianwuganqi/ADDemo"

    spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.swift_versions = ['5.8', '5.9']
  
  spec.author       = { "jingjun" => "rxswift@126.com" }
  
  spec.platform     = :ios, "13.0"

  spec.source       = { :git => "https://github.com/xingtianwuganqi/ADDemo.git", :tag => "#{spec.version}" }
   
  spec.source_files = "ADDemo/ADPage/*.swift"
  spec.frameworks   = ["Foundation","UIKit"]
  spec.static_framework = true

  spec.dependency 'BasicProject'
  spec.dependency 'AnyThinkiOS','6.2.95'
  spec.dependency 'AnyThinkiOS/AnyThinkTTAdapter','6.2.95'
  spec.dependency 'AnyThinkiOS/AnyThinkGDTAdapter','6.2.95'


end
