platform :ios, '10.0'
target 'RxSwiftLearning' do
  use_frameworks!
  # Swift三方库
  # Rx
  pod 'RxSwift', '6.2.0'
  pod 'RxCocoa', '6.2.0'
  pod 'RxDataSources'
  # 网络请求
  pod "Moya"
  pod 'RxBlocking'
  #布局
  pod "SnapKit"
  #数据解析
  pod "ObjectMapper"
end

target 'RxSwiftLearningTests' do
  use_frameworks!
  # 网络请求
  pod "Moya"
  pod 'RxBlocking'
end
post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = '$(inherited)'
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
        end
    end
end
