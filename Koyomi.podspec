#
# Be sure to run `pod lib lint Koyomi.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Koyomi'
  s.version          = '1.2.7'
  s.summary          = 'Simple customizable calendar component in Swift'
  s.description      = <<-DESC

                        Koyomi is a simple calender view framework for iOS, written in Swift.
                        * Simple Calendar View
                        * Easily usable.
                        * Selectable calender
                        * Customizable in any properties for appearance.
                        * Support @IBDesignable and @IBInspectable
                        * Support Swift 2.3
                        * Support Swift 3.0
                        * Compatible with Carthage

                        Koyomi is designed to be easy to use!!

                        DESC

  s.homepage         = 'https://github.com/shoheiyokoyama/Koyomi'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'shoheiyokoyama' => 'shohei.yok0602@gmail.com' }
  s.source           = { :git => 'https://github.com/shoheiyokoyama/Koyomi.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Koyomi/**/*.swift'
end
