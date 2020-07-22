Pod::Spec.new do |s|
  s.name             = 'QYKit'
  s.version          = '1.0.1'
  s.summary          = 'QYKit'
  s.description      = <<-DESC
                            QYKit
                       DESC

  s.homepage         = 'https://github.com/MemoryKing/QYKit.git'
  #s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.license          = 'MIT'
  s.author           = { '╰莪呮想好好宠Nǐつ ' => '1091676312@qq.com' }
  s.source           = { :git => 'https://github.com/MemoryKing/QYKit.git', :tag => s.version.to_s }
  #s.pod_target_xcconfig = {'SWIFT_VERSION' => '5.0'}
  s.swift_versions = '5.0'
  s.platform     = :ios, "10.0"

  s.frameworks = 'UIKit','Foundation','QuartzCore','CoreGraphics','AssetsLibrary','MediaPlayer','CoreTelephony','CoreLocation','AVFoundation'

  #s.source_files = 'QYKit/**/*.swift '

#s.public_header_files   = 'QYKit/**/*.swift '

s.subspec 'Tool' do |e|
e.source_files          = 'QYKit/Tool/**/*.swift'
end

s.subspec 'Extension' do |c|
c.source_files          = 'QYKit/Extension/**/*.swift'
end

s.subspec 'Function' do |e|
e.source_files          = 'QYKit/Function/**/*.swift'
e.dependency 'MJRefresh'
e.dependency 'DZNEmptyDataSet'
e.dependency 'PKHUD'
end


s.requires_arc = true
end
