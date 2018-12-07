Pod::Spec.new do |s|
  s.name             = 'ViewSizeCalculator'
  s.version          = '0.7.0'
  s.summary          = 'Calculate view size with AutoLayout.'
  s.homepage         = 'https://github.com/muukii/ViewSizeCalculator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'muukii' => 'm@muukii.me' }
  s.source           = { :git => 'https://github.com/muukii/ViewSizeCalculator.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/muukii0803'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ViewSizeCalculator/**/*.swift'
  s.frameworks = 'UIKit'
end
