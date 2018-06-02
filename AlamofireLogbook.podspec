#
# Be sure to run `pod lib lint AlamofireLogbook.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AlamofireLogbook'
  s.version          = '0.1.0'
  s.summary          = 'Alamofire network activity logger view'

  # s.description      = <<-DESC
  # Alamofire network activity logger view
  #                      DESC

  s.homepage         = 'https://github.com/mikeAttia/AlamofireLogbook'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mikeAttia' => 'dr.mike.attia@gmail.com' }
  s.source           = { :git => 'https://github.com/mikeAttia/AlamofireLogbook.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.swift_version = '3.2'

  s.source_files = 'AlamofireLogbook/Classes/**/*'
  
  s.resource_bundles = {
    'AlamofireLogbook' => ['AlamofireLogbook/Assets/*.{storyboard,xib,png}']
  }
  s.dependency 'Alamofire'
end
