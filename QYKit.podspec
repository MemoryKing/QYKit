Pod::Spec.new do |s|
  s.name             = 'QYKit'
  s.version          = '1.0.8'
  s.summary          = 'QYKit 类扩展,功能集合'
  s.description      = <<-DESC
                            ...
                       DESC

  s.homepage         = 'https://github.com/MemoryKing/QYKit'
  #s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.license          = 'MIT'
  s.author           = { '╰莪呮想好好宠Nǐつ ' => '1091676312@qq.com' }
  s.source           = { :git => 'https://github.com/MemoryKing/QYKit.git', :tag => s.version.to_s }
  #s.pod_target_xcconfig = {'SWIFT_VERSION' => '5.0'}
  s.swift_versions = '5.0'
  s.platform     = :ios, "10.0"
  s.frameworks = 'UIKit','Foundation','QuartzCore','CoreGraphics','AssetsLibrary','MediaPlayer','CoreTelephony','CoreLocation','AVFoundation'
  
  s.dependency 'MJRefresh'
  s.dependency 'DZNEmptyDataSet'
  s.dependency 'PKHUD'
  s.dependency 'SnapKit'
  
  #s.resources  = 'QYKit/Resource/*.json'
  s.source_files = 'QYKit/**/*.swift'

#s.subspec 'Tool' do |t|
#t.source_files          = 'QYKit/Tool/**/*.swift'
#end

#s.subspec 'Extension' do |c|
#c.source_files          = 'QYKit/Extension/**/*.swift'
#end

#s.subspec 'Function' do |e|
#e.source_files          = 'QYKit/Function/**/*.swift'
#end

s.requires_arc = true
end
