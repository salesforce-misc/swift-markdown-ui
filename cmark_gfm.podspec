Pod::Spec.new do |s|
  s.name             = 'cmark_gfm'
  s.version          = '0.26.1'
  s.summary          = 'A framework to render markdown UI'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/salesforce-misc/swift-markdown-ui'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Salesforce' => '' }
  s.source           = { :git => 'https://github.com/salesforce-misc/swift-markdown-ui.git', :tag => "v2.4.0" }

  s.ios.deployment_target = '16.0'
  s.swift_versions = ["5.0", "5.1"]

  s.source_files = "Sources/cmark_gfm/**/*{.c,.h}"
  s.preserve_paths = "Sources/cmark_gfm/**/*"
  s.public_header_files = "Sources/cmark_gfm/include/*.h"
end
