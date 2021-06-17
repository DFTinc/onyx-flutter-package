#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint onyx_plugin.podspec` to validate before publishing.
#
# run from terminal to buld podspec pod lib lint --verbose   --platforms=ios  --fail-fast      
Pod::Spec.new do |s|
  s.name             = 'onyx_plugin'
  s.version          = '0.0.1'
  s.summary          = 'Onyx Flutter Plugin for iOS.'
  s.description      = 'Onyx software development iOS Flutter plugin'
  s.homepage         = 'https://diamondfortress.com/'
  s.license          = { :type => 'custom',  :file => '../LICENSE' }
  s.author           = { 'Diamond Fortress' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  #s.he
  s.dependency 'Flutter'
  #s.dependency 'OnyxCamera', '7.0.0'
  s.platform = :ios, '9.0'
  # Flutter.framework does not contain a i386 slice.
  s.info_plist = {
    'NSCameraUsageDescription' => 'Capture fingerprint image'
  }

  s.static_framework = true

 s.ios.deployment_target   = '9.0'
 s.requires_arc            = true
 s.xcconfig                = { 'FRAMEWORK_SEARCH_PATHS' => '$(inherited)', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386, arm64' }
 s.pod_target_xcconfig     = { 'ENABLE_BITCODE' => 'NO', 'OTHER_LDFLAGS' => '-lObjC', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386, arm64', 'DEFINES_MODULE' => 'YES' }
 s.resource_bundles        = { 'onyx_plugin' => ['Assets/**/onyx_4f_logo_v2.png',
 'onyx_4f_logo_v2@2x.png',
 'capture_unet_nn_quant.tflite'] }
 s.ios.vendored_frameworks = 'Frameworks/*.framework'
 s.frameworks              = 'CoreMedia', 'AVFoundation', 'AssetsLibrary'
 s.dependency                'OpenCV', '3.4.5'
 s.dependency                'TensorFlowLiteObjC'

 #s.header_mappings_dir = 'src/include'
 #s.public_header_files = ['**/*.h', 'Classes/**/*.h']
 s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386, arm64',
 #'DEFINES_MODULE' => 'YES',
 }
#s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES'}

 #'HEADER_SEARCH_PATHS' => '"${PODS_ROOT}"/**',

  
 s.swift_version = '5.0'
end
