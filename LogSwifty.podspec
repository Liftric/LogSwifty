Pod::Spec.new do |s|
  s.name = "LogSwifty"
  s.version = "1.1.0"
  s.license = { :type => "MIT", :file => "LICENSE" }

  s.summary = "Simple logging for Swift."
  s.homepage = "https://github.com/benjohnde/LogSwifty"

  s.authors = { "Ben John" => "github@benjohn.de" }
  s.social_media_url = "http://twitter.com/benjohnde"

  s.platform         = :ios, "9.0"
  s.swift_version    = "4.2"

  s.source           = { :git => "https://github.com/benjohnde/LogSwifty.git", :tag => "#{s.version}" }

  s.source_files      = "LogSwifty/Source/**/*.{swift}"
  s.requires_arc = true
end