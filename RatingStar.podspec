#
# Be sure to run `pod lib lint RatingStar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RatingStar'
  s.version          = '0.2.2'
  s.summary          = 'A nice-looking new concept for rating bars implemented for iOS.'

  s.description      = <<-DESC
A nice-looking new concept for rating bars implemented for iOS. The concept looks like a flower with every petal representing a specific rating.
                       DESC
  s.homepage         = 'https://github.com/mohakapt/ratingStar-ios'
  s.screenshots      = 'https://raw.githubusercontent.com/mohakapt/ratingstar-ios/master/Images/screenshot.jpg'
  s.license          = { :type => 'Apache-2.0', :file => 'LICENSE' }
  s.author           = { 'Haytham KATBY' => 'mohakapt@gmail.com' }
  s.source           = { :git => 'https://github.com/mohakapt/ratingstar-ios.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/mo_ha_ka'

  s.swift_version = '4.0'
  s.ios.deployment_target = '9.0'

  s.ios.framework  = 'UIKit'
  s.source_files = 'RatingStar/Classes/**/*'
  
  # s.resource_bundles = {
  #   'RatingStar' => ['RatingStar/Assets/*.png']
  # }
end
