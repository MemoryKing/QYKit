
Pod::Spec.new do |s|
  s.name             = 'WYJKit_Swift'
  s.version          = '1.1.1'
  s.summary          = 'WYJKit_Swift'
  s.description      = <<-DESC
                            hud
                       DESC

  s.homepage         = 'https://github.com/MemoryKing/WYJKit-Swift.git'
  #s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.license          = 'MIT'
  s.author           = { '╰莪呮想好好宠Nǐつ ' => '1091676312@qq.com' }
  s.source           = { :git => 'https://github.com/MemoryKing/WYJKit-Swift.git', :tag => s.version.to_s }
  s.swift_versions = '5.0'
  s.ios.deployment_target = '10.0'

  s.frameworks = 'UIKit','Foundation','AVFoundation','WebKit'

#s.source_files = 'WYJKit_Swift/**/*.swift '

#s.public_header_files   = 'WYJKit_Swift/**/*.swift '

s.subspec 'Extension' do |c|
#c.public_header_files   = 'WYJKit_Swift/Extension/**/*.swift'
c.source_files          = 'WYJKit_Swift/Extension/**/*.swift'
end

s.subspec 'Tool' do |e|
#e.public_header_files   = 'WYJKit_Swift/Tool/**/*.swift'
e.source_files          = 'WYJKit_Swift/Tool/**/*.swift'
e.dependency 'PKHUD'
end

s.requires_arc = true
end

