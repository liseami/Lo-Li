

# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'
target 'Lo&Li' do
  # Comment the next line if you don't want to use dynamic frameworks
use_frameworks!
pod 'Moya'# 网络底层
pod 'Moya/Combine', '~> 15.0'# 网络底层结合SwiftUICombine
pod 'KakaJSON'# JSON处理
pod 'SwiftyJSON'# JSON处理
pod 'lottie-ios'# JSON动画
pod 'Kingfisher'# Web图片
pod 'Introspect' # 链接UIKIT
pod 'SwifterSwift' # 语法糖
#pod 'MapboxMaps', '10.10.1'#地图
#pod 'Tagly'#标签云
pod 'Popovers'
pod 'BottomSheet', :git => 'https://github.com/weitieda/bottom-sheet.git'
pod 'BottomSheetSwiftUI'
pod 'Down'
#pod 'WechatOpenSDK-XCFramework'
#pod 'AliyunOSSiOS'
pod "MarkdownView"
# 极光 推送、统计、验证、分享
#pod 'JCore'
#pod 'JPush'
#pod 'JVerification'
#pod 'JAnalytics'
#pod 'JAnalytics'
#pod 'JVerification'
#pod 'JShare'
# pod 'UMCommon'#友盟
# pod 'UMDevice'#友盟
# pod 'UMCCommonLog'#友盟
# pod 'AMapSearch'# 高德地图POI搜索
# pod "Texture"# 异步UI库
# pod 'Ads-CN'#穿山甲
end
post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end
