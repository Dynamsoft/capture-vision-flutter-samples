
#ifndef common_h
#define common_h

/// ExceptionTip.
static NSString *const exceptionTip = @"Error";

/// PluginChannel.
static NSString *const methodChannel_Identifier = @"com.dynamsoft/cature_vision";
static NSString *const barcodeResult_EventChannel_Identifier = @"com.dynamsoft/barcode_result_observer";
static NSString *const platformFactory_identifier = @"com.dynamsoft/platform_factory";

/// DBR methods.
static NSString *const barcodeReader_initLicense = @"barcodeReader_initLicense";
static NSString *const barcodeReader_createInstance = @"barcodeReader_createInstance";
static NSString *const barcodeReader_getVersion = @"barcodeReader_getVersion";
static NSString *const barcodeReader_startScanning = @"barcodeReader_startScanning";
static NSString *const barcodeReader_stopScanning = @"barcodeReader_stopScanning";
static NSString *const barcodeReader_updateRuntimeSettings = @"barcodeReader_updateRuntimeSettings";
static NSString *const barcodeReader_getRuntimeSettings = @"barcodeReader_getRuntimeSettings";
static NSString *const barcodeReader_updateRuntimeSettingsFromTemplate = @"barcodeReader_updateRuntimeSettingsFromTemplate";
static NSString *const barcodeReader_updateRuntimeSettingsFromJson = @"barcodeReader_updateRuntimeSettingsFromJson";
static NSString *const barcodeReader_resetRuntimeSettings = @"barcodeReader_resetRuntimeSettings";
static NSString *const barcodeReader_outputRuntimeSettingsToString = @"barcodeReader_outputRuntimeSettingsToString";
static NSString *const barcodeReader_addResultlistener = @"barcodeReader_addResultlistener";
static NSString *const barcodeReader_decodeFile = @"barcodeReader_decodeFile";
static NSString *const barcodeReader_enableResultVerification = @"barcodeReader_enableResultVerification";
static NSString *const barcodeReader_setModeArgument = @"barcodeReader_setModeArgument";
static NSString *const barcodeReader_getModeArgument = @"barcodeReader_getModeArgument";

/// DCE methods.
static NSString *const cameraEnhancer_createInstance = @"cameraEnhancer_createInstance";
static NSString *const cameraEnhancer_dispose = @"cameraEnhancer_dispose";
static NSString *const cameraEnhancer_setScanRegion = @"cameraEnhancer_setScanRegion";
static NSString *const cameraEnhancer_setScanRegionVisible = @"cameraEnhancer_setScanRegionVisible";
static NSString *const cameraEnhancer_setOverlayVisible = @"cameraEnhancer_setOverlayVisible";
static NSString *const cameraEnhancer_openCamera = @"cameraEnhancer_openCamera";
static NSString *const cameraEnhancer_closeCamera = @"cameraEnhancer_closeCamera";
static NSString *const cameraEnhancer_selectCamera = @"cameraEnhancer_selectCamera";
static NSString *const cameraEnhancer_turnOnTorch = @"cameraEnhancer_turnOnTorch";
static NSString *const cameraEnhancer_turnOffTorch = @"cameraEnhancer_turnOffTorch";

/// DCECameraView methods.
static NSString *const cameraView_torchButton = @"cameraView_torchButton";



/// Navigation methods.
static NSString *const navigation_didPopNext = @"navigation_didPopNext";
static NSString *const navigation_didPushNext = @"navigation_didPushNext";

#endif /* common_h */
