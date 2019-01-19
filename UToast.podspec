
Pod::Spec.new do |spec|
  spec.name         = "UToast"
  spec.version      = "0.1.0"
  spec.authors      = { "4074" => "fourzerosevenfour@gmail.com" }
  spec.homepage     = "https://github.com/4074/UToast"
  spec.summary      = "Toast component in Swift"
  spec.source       = { :git => "https://github.com/4074/UToast.git" }
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.platform     = :ios, '8.0'
  spec.source_files = "UToast/*.swift"

  spec.requires_arc = true

  spec.ios.deployment_target = '8.0'
  spec.ios.frameworks = ['UIKit', 'Foundation']
end
