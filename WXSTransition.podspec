Pod::Spec.new do |s|
  s.name         = 'WXSTransition'
  s.summary      = ‘A library for transition animations between view controlles’
  s.version      = ‘1.1.0’
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { ‘alanwangmodify’ => ‘alanwangmodify@126.com’ }
  s.homepage     = 'https://github.com/alanwangmodify/WXSTransition'

  s.ios.deployment_target = ‘7.0’

  s.source       = { :git => 'https://github.com/alanwangmodify/WXSTransition.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.source_files = 'WXSTransition/*.{h,m}'
  s.public_header_files = 'WXSTransition/*.{h}'
 
end
