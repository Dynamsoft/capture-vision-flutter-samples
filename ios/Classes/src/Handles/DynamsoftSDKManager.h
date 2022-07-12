//
//  DynamsoftSDKManager.h
//  dbr_test_plugin
//
//  Created by dynamsoft on 2022/2/21.
//

#import <Foundation/Foundation.h>
#import <DynamsoftBarcodeReader/DynamsoftBarcodeReader.h>
#import <DynamsoftCameraEnhancer/DynamsoftCameraEnhancer.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DynamsoftBarcodeReaderState) {
    DynamsoftBarcodeReaderStateStartScanning,
    DynamsoftBarcodeReaderStateStopScanning
};

typedef NS_ENUM(NSInteger, DynamsoftCameraEnhancerState) {
    DynamsoftCameraEnhancerStateOpen,
    DynamsoftCameraEnhancerStateClose
};

@interface DynamsoftSDKManager : NSObject<NSCopying, NSMutableCopying, DBRTextResultListener>

+ (DynamsoftSDKManager *)manager;

/// SDK
@property (nonatomic, strong) DynamsoftBarcodeReader *barcodeReader;

@property (nonatomic, strong, nullable) DynamsoftCameraEnhancer *cameraEnhancer;

@property (nonatomic, assign) BOOL barcodeReaderLinkCameraEnhancerIsFinished;

@property (nonatomic, assign) DynamsoftBarcodeReaderState dynamsoftBarcodeReaderState;

@property (nonatomic, assign) DynamsoftCameraEnhancerState dynamsoftCameraEnhancerState;

/// DBR set license
- (void)barcodeReaderInitLicense:(NSString *)license;

/// TextResultCallBack
@property (nonatomic, copy) void(^barcodeTextResultCallBack)(NSArray<iTextResult *> *results);

/// DBRLicenseVerificationCallback
@property (nonatomic, copy) void(^dbrLicenseVerificationCallback)(bool isSuccess, NSError *error);

@end

NS_ASSUME_NONNULL_END
