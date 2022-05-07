//
//  DynamsoftCaptureVisionFactory.h
//  dynamsoft_capture_vision
//
//  Created by dynamsoft on 2022/3/28.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import <DynamsoftBarcodeReader/DynamsoftBarcodeReader.h>
#import <DynamsoftCameraEnhancer/DynamsoftCameraEnhancer.h>

NS_ASSUME_NONNULL_BEGIN

@interface DynamsoftCaptureVisionFactory : NSObject<FlutterPlatformViewFactory, FlutterStreamHandler>

- (instancetype)initWithFlutterChannel:(FlutterMethodChannel *)channel binaryMessenger:(NSObject<FlutterPluginRegistrar>*)registrar;

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result;

@end

NS_ASSUME_NONNULL_END
