Pod::Spec.new do |s|
  s.name             = 'YJSwiftKit'
  s.version          = '1.0.0'
  s.summary          = 'YJSwiftKit'
  s.description      = <<-DESC
                            kit
                       DESC

  s.homepage         = 'https://github.com/MemoryKing/YJSwiftKit.git'
  #s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.license          = 'MIT'
  s.author           = { '╰莪呮想好好宠Nǐつ ' => '1091676312@qq.com' }
  s.source           = { :git => 'https://github.com/MemoryKing/YJSwiftKit.git', :tag => s.version.to_s }
  s.swift_versions = '5.0'
  s.ios.deployment_target = '9.0'

  s.frameworks = 'UIKit','Foundation','QuartzCore'

  s.source_files = 'YJSwiftKit/**/*.swift '

#s.public_header_files   = 'YJSwiftKit/**/*.swift '

s.subspec 'Extension' do |c|
c.source_files          = 'YJSwiftKit/Extension/**/*.swift'
end

s.subspec 'TOOL' do |e|
e.source_files          = 'YJSwiftKit/TOOL/**/*.swift'
end

s.subspec 'HUD' do |e|
e.source_files          = 'YJSwiftKit/HUD/**/*.swift'
e.dependency 'PKHUD'
end

s.requires_arc = true
end
