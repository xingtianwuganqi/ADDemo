source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '13.0'

target 'ADDemo' do
  use_frameworks!

  pod 'BasicProject', :path=>'./../iOS_BasicProject'
  pod 'AnyThinkiOS','6.5.83'
  #Anythink Kuying Adx SDK(necessary)
  pod 'AnyThinkMediationAdxSmartdigimktCNAdapter','6.5.90.2.1'
  pod 'AnyThinkMediationTTAdapter','7.7.0.8.2.0'



end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
       end
    end
  end
end
