Pod::Spec.new do |s|
  s.name             = 'FinikFlutterEngine'
  s.version          = '3.35.7' 
  s.summary          = 'A binary wrapper for the Finik Flutter engine.'
  s.homepage         = 'github.com'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Finik' => 'engineering@quickpay.kg' }

  s.ios.deployment_target = '13.0'
  s.swift_version    = '5.0'

  s.source           = { :http => 'https://github.com/mancho-devs/finik-ios-sdk/releases/download/v3.35.7/Flutter.xcframework.zip' }
  s.vendored_frameworks = 'Flutter.xcframework'
  s.xcconfig = { 'OTHER_LDFLAGS' => '$(inherited) -ObjC -framework Flutter' }
end