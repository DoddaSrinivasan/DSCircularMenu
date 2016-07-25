#
# Be sure to run `pod lib lint DSCircularMenu.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DSCircularMenu'
  s.version          = '0.1.0'
  s.summary          = 'A Container View Controller to present circular wheel menu based navigation'

  s.homepage         = 'https://github.com/DoddaSrinivasan/DSCircularMenu'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dodda Srinivasan' => 'srinivasan.munna@gmail.com' }
  s.source           = { :git => 'https://github.com/DoddaSrinivasan/DSCircularMenu.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'DSCircularMenu/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DSCircularMenu' => ['DSCircularMenu/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
