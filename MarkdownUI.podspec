Pod::Spec.new do |s|
  s.name             = 'MarkdownUI'
  s.version          = '2.4.1'
  s.summary          = 'A framework to render markdown UI'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://git.soma.salesforce.com/iOS/CopilotSDK'
  s.license          = { :type => 'MIT' }
  s.author           = { 'asikora' => 'asikora@salesforce.com' }
  s.source           = { :git => 'https://git.soma.salesforce.com/iOS/swift-markdown-ui.git', :tag => s.version.to_s }

  s.ios.deployment_target = '16.0'
  s.swift_versions = ["5.0", "5.1"]
  s.default_subspec = 'main'

  s.subspec 'main' do |sp|
	  sp.dependency 'NetworkImage'
  	sp.dependency 'cmark_gfm'

  	_source_files = 'Sources/MarkdownUI/**/*.swift'
  	sp.source_files = _source_files
  end
end
