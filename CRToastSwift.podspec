#
# Be sure to run `pod lib lint CRToastSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CRToastSwift"
  s.version          = "0.1.0"
  s.summary          = "A CRToast wrapper library for Swift."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
                       CRToastSwift is a Swift wrapper library of CRToast.
                       It provides strongly-typed properties and enum types, and non-Singleton based APIs.
                       So you can show toast notifications briefly, easily and safely.
                       Additionally, it provides 4 custom themes for common situations, such as notifying completion of a task or occurence of an error.
                       DESC

  s.homepage         = "https://github.com/masahikot/CRToastSwift"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Masahiko Tsujita" => "tsujitamasahiko.dev@icloud.com" }
  s.source           = { :git => "https://github.com/masahikot/CRToastSwift.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'CRToastSwift/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'CRToast', '~> 0.0.9'
end
