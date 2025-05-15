#
# Be sure to run `pod lib lint FinikIosSdk.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FinikIosSdk'
  s.version          = '0.1.1'
  s.summary          = 'A lightweight SDK for integrating Finik payments into your iOS app.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  This Pod enables seamless integration of Finik's payment system into your iOS application.
  It offers a secure and customizable SDK for initiating payments, displaying QR codes,
  handling fixed or dynamic amounts, and tracking payment status in real time.
  Designed with developers in mind, the SDK ensures smooth user experience and fast integration.
                       DESC

  s.homepage         = 'https://github.com/mancho-devs/finik-ios-sdk'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'birimkulov951' => 'birimkulov951@gmail.com' }
  s.source           = { :git => 'https://github.com/mancho-devs/finik-ios-sdk.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.swift_version    = '5.0'
  s.ios.deployment_target = '10.0'

  s.source_files     = 'FinikIosSdk/Classes/**/*'
  
  # s.resource_bundles = {
  #   'FinikIosSdk' => ['FinikIosSdk/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
