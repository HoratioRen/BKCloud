#
# Be sure to run `pod lib lint BKCloud.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BKCloud'
  s.version          = '1.0.2'
  s.summary          = '北控云SDK'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/HoratioRen'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'BKSX CN' => 'bksxapp@163.com' }
  s.source           = { :git => 'https://github.com/HoratioRen/BKCloud.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  #s.source_files = 'BKCloud/Classes/**/*.{h,m}'
  
  # s.resource_bundles = {
  #   'BKCloud' => ['BKCloud/Assets/*.png']
  # }

  s.public_header_files = 'Pod/Classes/BKCloudKit.h'
  
  s.subspec 'Category' do |category|
      category.source_files = 'BKCloud/Classes/Category/**/*'
      # category.dependency 'AFNetworking'
  end

  s.subspec 'Tools' do |tools|
      tools.source_files = 'BKCloud/Classes/Tools/**/*'
      # tools.dependency 'YYModel'
  end
  
  
  #依赖自己的或别人的Framework文件
  s.vendored_frameworks = 'BKCloud/Classes/*.framework'
  
  s.frameworks = 'UIKit', 'Foundation',"CoreLocation"
  s.dependency 'AFNetworking', '~> 3.2.1'
  s.dependency 'SAMKeychain', '~> 1.5.3'
end
