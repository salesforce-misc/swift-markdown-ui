Pod::Spec.new do |s|
  s.name             = 'swift-markdown-ui'
  s.version          = '2.4.0'
  s.summary          = 'A framework to render markdown UI'

  s.description      = <<-DESC
A swift UI rendering of Markdown content supporting most of GitHub Flavored Markdown. A fork of https://github.com/gonzalezreal/swift-markdown-ui
                       DESC

  s.homepage         = 'https://github.com/salesforce-misc/swift-markdown-ui'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Salesforce' => '' }
  s.source           = { :git => 'https://github.com/salesforce-misc/swift-markdown-ui.git', :tag => "2.4.0" }

  s.ios.deployment_target = '15.0'
  s.swift_versions = ["5.0", "5.1"]
  s.dependency 'NetworkImage'
  s.dependency 'cmark_gfm', '~> 0.26'

  _source_files = 'Sources/MarkdownUI/**/*.swift'
  s.source_files = _source_files
end
