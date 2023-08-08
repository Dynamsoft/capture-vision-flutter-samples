#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint dynamsoft_capture_vision_flutter.podspec` to validate before publishing.
#
require "yaml"

pubspec = YAML.load_file(File.join('..', 'pubspec.yaml'))

Pod::Spec.new do |s|
  s.name             = pubspec['name']
  s.version          = pubspec['version']
  s.summary          = pubspec['description']
  s.homepage         = pubspec['homepage']
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Dynamsoft' => 'support@dynamsoft.com' }
  s.platforms        = { :ios => '11.0'}
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'DynamsoftBarcodeReader', '9.6.20'
  s.dependency 'DynamsoftCameraEnhancer', '2.3.12'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
