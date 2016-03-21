#
# Be sure to run `pod lib lint CRToastSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CRToastSwift"
  s.version          = "1.0.0-alpha.2"
  s.summary          = "A wrapper library of CRToast totally redesigned for Swift 2."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
                       A wrapper library of CRToast totally redesigned for Swift 2.
                       DESC

  s.homepage         = "https://github.com/masahiko24/CRToastSwift"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Masahiko Tsujita" => "tsujitamasahiko.dev@icloud.com" }
  s.source           = { :git => "https://github.com/masahiko24/CRToastSwift.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'CRToastSwift/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'CRToast', '~> 0.0.9'
end
