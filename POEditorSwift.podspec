#
# Be sure to run `pod lib lint POEditorSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'POEditorSwift'
  s.version          = '0.1.0'
  s.summary          = 'Localize strings from POEditor without Localizable.strings file'

  s.description      = <<-DESC
BETA VERSION
This pod downloads localizations from POEditor APIs and make them available over the air instead of using static Localizable.string files
                       DESC

  s.homepage         = 'https://github.com/neobeppe/POEditorSwift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Giuseppe Travasoni' => 'giuseppe.travasoni@gmail.com' }
  s.source           = { :git => 'https://github.com/neobeppe/POEditorSwift.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/neobeppe'

  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'

  s.source_files = 'POEditorSwift/Classes/**/*'
  
end
