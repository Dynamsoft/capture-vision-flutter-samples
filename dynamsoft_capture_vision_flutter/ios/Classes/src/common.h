//
//  common.h
//  dynamsoft_capture_vision
//
//  Created by dynamsoft on 2022/3/28.
//

#ifndef common_h
#define common_h

/// ExceptionTip
static NSString *const exceptionTip = @"Error";

/// PluginChannel
static NSString *const methodChannel_Identifier = @"com.dynamsoft/cature_vision";
static NSString *const barcodeResult_EventChannel_Identifier = @"com.dynamsoft/barcode_result_observer";
static NSString *const platformFactory_identifier = @"com.dynamsoft/platform_factory";

/// DBR methods
static const NSString *barcodeReader_initLicense = @"barcodeReader_initLicense";
static const NSString *barcodeReader_createInstance = @"barcodeReader_createInstance";
static const NSString *barcodeReader_getVersion = @"barcodeReader_getVersion";
static const NSString *barcodeReader_startScanning = @"barcodeReader_startScanning";
static const NSString *barcodeReader_stopScanning = @"barcodeReader_stopScanning";
static const NSString *barcodeReader_updateRuntimeSettings = @"barcodeReader_updateRuntimeSettings";
static const NSString *barcodeReader_getRuntimeSettings = @"barcodeReader_getRuntimeSettings";
static const NSString *barcodeReader_updateRuntimeSettingsFromTemplate = @"barcodeReader_updateRuntimeSettingsFromTemplate";
static const NSString *barcodeReader_updateRuntimeSettingsFromJson = @"barcodeReader_updateRuntimeSettingsFromJson";
static const NSString *barcodeReader_resetRuntimeSettings = @"barcodeReader_resetRuntimeSettings";
static const NSString *barcodeReader_outputRuntimeSettingsToString = @"barcodeReader_outputRuntimeSettingsToString";

static NSString *const barcodeReader_addResultlistener = @"barcodeReader_addResultlistener";

/// DCE methods
static const NSString *cameraEnhancer_dispose = @"cameraEnhancer_dispose";
static const NSString *cameraEnhancer_setScanRegion = @"cameraEnhancer_setScanRegion";
static const NSString *cameraEnhancer_setScanRegionVisible = @"cameraEnhancer_setScanRegionVisible";
static const NSString *cameraEnhancer_setOverlayVisible = @"cameraEnhancer_setOverlayVisible";

/// Navigation methods
static const NSString *navigation_didPopNext = @"navigation_didPopNext";
static const NSString *navigation_didPushNext = @"navigation_didPushNext";

#endif /* common_h */
