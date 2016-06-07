Pod::Spec.new do |s|
	s.name         = "AsyncStarterKit"
	s.version      = "1.0.0"
	s.summary      = "A starter Kit for those who want to have a quick start with PromiseKit and ObjectMapper"

	s.homepage     = "https://github.com/jonasman/AsyncStarterKit"

	s.license      = { :type => "MIT", :file => "LICENSE" }

	s.author             = { "Joao Nunes" => "joao3001@hotmail.com" }
	s.social_media_url   = "https://twitter.com/jonas2man"
	s.platform     = :ios, "8.0"

	s.source       = { :git => "https://github.com/jonasman/AsyncStarterKit.git", :tag => "#{s.version}" }

	s.source_files  = "Sources/**/*.swift"


	s.framework  = "Foundation"

	s.requires_arc = true

	s.dependency "PromiseKit" , "~> 3.0"
	s.dependency 'ObjectMapper', '~> 1.1'

end
