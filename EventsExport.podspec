require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "EventsExport"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => 13 }
  s.source       = { :git => "https://github.com/41a91/react-native-events-export.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,mm,swift,cpp}"
  s.private_header_files = "ios/**/*.h"

  s.module_name = "EventsExport"
  s.requires_arc = true
  s.swift_version = "5.0"

  s.frameworks = [
    'UIKit',
    'EventKit',
    'EventKitUI'
  ]

  s.dependency "React-Core"
  s.dependency "React-Codegen"

  install_modules_dependencies(s)
end
