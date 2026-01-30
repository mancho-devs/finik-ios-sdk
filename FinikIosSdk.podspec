#
# Be sure to run `pod lib lint FinikIosSdk.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FinikIosSdk'
  s.version          = '3.1.4'
  s.summary          = 'Flutter-integrated Finik iOS SDK for seamless payments'

  s.description      = <<-DESC
  Finik iOS SDK allows you to embed payment workflows using a Flutter module.
  It provides seamless integration of QR payments and custom checkout flows
  through a simple and secure API. Compatible with iOS 13+.
  DESC

  s.homepage         = 'https://github.com/mancho-devs/finik-ios-sdk'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Finik' => 'engineering@quickpay.kg' }
  s.source           = { :git => 'https://github.com/mancho-devs/finik-ios-sdk.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'


  s.swift_version    = '5.0'
  s.ios.deployment_target = '13.0'

  s.source_files = 'FinikIosSdk/Classes/**/*'
  s.vendored_frameworks = 'FinikIosSdk/Frameworks/*'

  s.dependency 'FinikFlutterEngine'
end
