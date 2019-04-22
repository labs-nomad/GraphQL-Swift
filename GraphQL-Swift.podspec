#
# Be sure to run `pod lib lint GraphQL-Swift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name = 'GraphQL-Swift'
    s.version = '1.0.12'
    s.summary = 'Make basic GraphQL requests using `URLSession`'
    s.description = <<-DESC 
    Written in Swift 5 this library allows you to define an `GQLAPIConnection` and pass `GQLRequests` into a POST HTTP request.

    Simple and lightweight. Protocol oriented with generics <T> so you can deal with the returned JSON yourself.
     DESC
    
    s.homepage = 'https://github.com/labs-nomad/GraphQL-Swift'

    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'shared@nomad-go.com' => 'nomad@shared-go.com' }
    s.source           = { :git => 'https://github.com/labs-nomad/GraphQL-Swift.git', :tag => s.version.to_s }
    
    s.ios.deployment_target = '11.0'

    s.source_files = '**/*.{h,m,swift}'
  
    s.swift_version = '5'
    # s.resource_bundles = {
    #   'iOSFileSystem' => ['iOSFileSystem/Assets/*.png']
    # }

    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'

end