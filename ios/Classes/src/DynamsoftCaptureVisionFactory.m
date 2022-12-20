
#import "DynamsoftCaptureVisionFactory.h"
#import "CaptureView/BarcodeScanningCaptureView.h"
#import "Handles/DynamsoftSDKManager.h"
#import "Handles/DynamsoftToolsManager.h"
#import "Handles/DynamsoftConvertManager.h"
#import "common.h"

@interface DynamsoftCaptureVisionFactory ()

@property (nonatomic, strong) FlutterMethodChannel *methodChannel;

@property (nonatomic, strong) NSObject<FlutterPluginRegistrar> *registrar;

@property (nonatomic, copy) FlutterResult resultMethod;

@property (nonatomic, copy) FlutterEventSink textResultStream;

@property (nonatomic, strong) BarcodeScanningCaptureView *captureView;

@end

@implementation DynamsoftCaptureVisionFactory

- (instancetype)initWithFlutterChannel:(FlutterMethodChannel *)channel binaryMessenger:(NSObject<FlutterPluginRegistrar>*)registrar
{
    self = [super init];
    if (self) {
        self.methodChannel = channel;
        self.registrar = registrar;
        
        // Stream
        FlutterEventChannel *barcodeResultEventChannel = [FlutterEventChannel eventChannelWithName:barcodeResult_EventChannel_Identifier binaryMessenger:[registrar messenger]];
        
        [barcodeResultEventChannel setStreamHandler:self];
    }
    return self;
}

//MARK: FlutterPlatformViewFactory
- (NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args
{
    self.captureView = [[BarcodeScanningCaptureView alloc] init];
    [self.captureView createViewWithArguments:args];
    return self.captureView;
}

- (NSObject<FlutterMessageCodec> *)createArgsCodec
{
    return FlutterStandardMessageCodec.sharedInstance;
}

//MARK: FlutterStreamHandler delegate
- (FlutterError *)onCancelWithArguments:(id)arguments
{
    return nil;
}

- (FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events
{
    NSString *streamName = [arguments valueForKey:@"streamName"];
    
    if ([streamName isEqualToString:barcodeReader_addResultlistener]) {
        _textResultStream = events;
        [DynamsoftSDKManager manager].barcodeTextResultCallBack = ^(NSArray<iTextResult *> * _Nullable results) {
            if (self.textResultStream) {
                self.textResultStream([[DynamsoftConvertManager manager] wrapResultsToJson:results]);
               
            }
        };
    }
    return nil;
}

//MARK: FlutterMethodCall
- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result
{
    self.resultMethod = result;
    
    // DBR
    if ([barcodeReader_initLicense isEqualToString:call.method]) {
        [self barcodeReaderInitLicense:call.arguments];
    } else if ([barcodeReader_createInstance isEqualToString:call.method]) {
        [self barcodeReaderCreateInstance:call.arguments];
    } else if ([barcodeReader_getVersion isEqualToString:call.method]) {
        [self barcodeReaderGetVersion:call.arguments];
    } else if ([barcodeReader_startScanning isEqualToString:call.method]) {
        [self barcodeReaderStartScanning:call.arguments];
    } else if ([barcodeReader_stopScanning isEqualToString:call.method]) {
        [self barcodeReaderStopScanning:call.arguments];
    } else if ([barcodeReader_updateRuntimeSettings isEqualToString:call.method]) {
        [self barcodeReaderUpdateRuntimeSettings:call.arguments];
    } else if ([barcodeReader_getRuntimeSettings isEqualToString:call.method]) {
        [self barcodeReaderGetRuntimeSettings:call.arguments];
    } else if ([barcodeReader_updateRuntimeSettingsFromTemplate isEqualToString:call.method]) {
        [self barcodeReaderUpdateRuntimeSettingsFromTemplate:call.arguments];
    } else if ([barcodeReader_updateRuntimeSettingsFromJson isEqualToString:call.method]) {
        [self barcodeReaderUpdateRuntimeSettingsFromJson:call.arguments];
    } else if ([barcodeReader_resetRuntimeSettings isEqualToString:call.method]) {
        [self barcodeReaderResetRuntimeSettings:call.arguments];
    } else if ([barcodeReader_outputRuntimeSettingsToString isEqualToString:call.method]) {
        [self barcodeReaderOutputRuntimeSettingsToString:call.arguments];
    } else if ([barcodeReader_decodeFile isEqualToString:call.method]) {
        [self barcodeReader_decodeFile:call.arguments];
    } else if ([barcodeReader_enableResultVerification isEqualToString:call.method]) {
        [self barcodeReader_enableResultVerification:call.arguments];
    } else if ([barcodeReader_setModeArgument isEqualToString:call.method]) {
        [self barcodeReader_setModeArgument:call.arguments];
    } else if ([barcodeReader_getModeArgument isEqualToString:call.method]) {
        [self barcodeReader_getModeArgument:call.arguments];
    }

    // DCE
    else if ([cameraEnhancer_createInstance isEqualToString:call.method]) {
        [self cameraEnhancer_createInstance:call.arguments];
    } else if ([cameraEnhancer_dispose isEqualToString:call.method]) {
        [self cameraEnhancerDispose:call.arguments];
    } else if ([cameraEnhancer_setScanRegion isEqualToString:call.method]) {
        [self cameraEnhancer_setScanRegion:call.arguments];
    } else if ([cameraEnhancer_setScanRegionVisible isEqualToString:call.method]) {
        [self cameraEnhancer_setScanRegionVisible:call.arguments];
    } else if ([cameraEnhancer_setOverlayVisible isEqualToString:call.method]) {
        [self cameraEnhancer_setOverlayVisible:call.arguments];
    } else if ([cameraEnhancer_openCamera isEqualToString:call.method]) {
        [self cameraEnhancer_openCamera:call.arguments];
    } else if ([cameraEnhancer_closeCamera isEqualToString:call.method]) {
        [self cameraEnhancer_closeCamera:call.arguments];
    } else if ([cameraEnhancer_selectCamera isEqualToString:call.method]) {
        [self cameraEnhancer_selectCamera:call.arguments];
    } else if ([cameraEnhancer_turnOnTorch isEqualToString:call.method]) {
        [self cameraEnhancer_turnOnTorch:call.arguments];
    } else if ([cameraEnhancer_turnOffTorch isEqualToString:call.method]) {
        [self cameraEnhancer_turnOffTorch:call.arguments];
    }
    
    // DCECameraView
    else if ([cameraView_torchButton isEqualToString:call.method]) {
        [self cameraView_torchButton:call.arguments];
    }
    
    // Navigation methods
    else if ([navigation_didPopNext isEqualToString:call.method]) {
        [self navigationDidPopNext];
    } else if ([navigation_didPushNext isEqualToString:call.method]) {
        [self navigationDidPushNext];
    }
    
    else {
        result(FlutterMethodNotImplemented);
    }
}

//MARK: DBR methods
- (void)barcodeReaderInitLicense:(id)arguments
{
    NSString *license = [arguments valueForKey:@"license"];
    [DynamsoftSDKManager manager].dbrLicenseVerificationCallback = ^(bool isSuccess, NSError * _Nonnull error) {
        NSString *errorString = @"";
        if (!isSuccess && error != nil) {
            errorString =  [error.userInfo valueForKey:@"NSUnderlyingError"];
        }
        NSDictionary *responseDic = @{@"isSuccess":@(isSuccess),
                                      @"errorString":errorString
        };
        self.resultMethod(responseDic);
    };
    [[DynamsoftSDKManager manager] barcodeReaderInitLicense:license];
}

- (void)barcodeReaderCreateInstance:(id)arguments
{
    [DynamsoftSDKManager manager].barcodeReader = [[DynamsoftBarcodeReader alloc] init];
    self.resultMethod(nil);
}

- (void)barcodeReaderGetVersion:(id)arguments
{
    self.resultMethod([DynamsoftBarcodeReader getVersion]);
}

- (void)barcodeReaderStartScanning:(id)arguments
{
    [[DynamsoftSDKManager manager].barcodeReader startScanning];
    
    if ([DynamsoftSDKManager manager].cameraEnhancer != nil) {
        [[DynamsoftSDKManager manager].barcodeReader setDBRTextResultListener:[DynamsoftSDKManager manager]];
        [[DynamsoftSDKManager manager].barcodeReader setCameraEnhancer:[DynamsoftSDKManager manager].cameraEnhancer];
    }
    
    self.resultMethod(nil);
}

- (void)barcodeReaderStopScanning:(id)arguments
{
    [[DynamsoftSDKManager manager].barcodeReader stopScanning];
    self.resultMethod(nil);
}

- (void)barcodeReaderUpdateRuntimeSettings:(id)arguments
{
    iPublicRuntimeSettings *runtimeSettings = [[DynamsoftConvertManager manager] analyzeRuntimeSettingsFromJson:arguments];
    
    NSError *error = nil;
    [[DynamsoftSDKManager manager].barcodeReader updateRuntimeSettings:runtimeSettings error:&error];
    
    if ([[DynamsoftToolsManager manager] verifyOperationResultWithError:error]) {
        self.resultMethod(nil);
    } else {
        self.resultMethod([FlutterError errorWithCode:exceptionTip message:[[DynamsoftToolsManager manager] getErrorMsgWithError:error] details:nil]);
    }
}

- (void)barcodeReaderGetRuntimeSettings:(id)arguments
{
    NSError *error = nil;
    iPublicRuntimeSettings *runtimeSettings = [[DynamsoftSDKManager manager].barcodeReader getRuntimeSettings:&error];
    
    if ([[DynamsoftToolsManager manager] verifyOperationResultWithError:error]) {
        self.resultMethod([[DynamsoftConvertManager manager] wrapRuntimeSettingsToJson:runtimeSettings]);
    } else {
        self.resultMethod([FlutterError errorWithCode:exceptionTip message:[[DynamsoftToolsManager manager] getErrorMsgWithError:error] details:nil]);
    }
}

- (void)barcodeReaderUpdateRuntimeSettingsFromTemplate:(id)arguments
{
    EnumPresetTemplate presetTemple = [[DynamsoftConvertManager manager] analyzePresetTemplateFromJson:arguments];

    [[DynamsoftSDKManager manager].barcodeReader updateRuntimeSettings:presetTemple];
    self.resultMethod(nil);
}

- (void)barcodeReaderUpdateRuntimeSettingsFromJson:(id)arguments
{
    NSString *jsonString = [arguments valueForKey:@"jsonString"];
    NSError *error = nil;
    [[DynamsoftSDKManager manager].barcodeReader initRuntimeSettingsWithString:jsonString conflictMode:EnumConflictModeOverwrite error:&error];
    
    if ([[DynamsoftToolsManager manager] verifyOperationResultWithError:error]) {
        self.resultMethod(nil);
    } else {
        self.resultMethod([FlutterError errorWithCode:exceptionTip message:[[DynamsoftToolsManager manager] getErrorMsgWithError:error] details:nil]);
    }
}

- (void)barcodeReaderResetRuntimeSettings:(id)arguments
{
    NSError *error = nil;
    [[DynamsoftSDKManager manager].barcodeReader resetRuntimeSettings:&error];
    
    if ([[DynamsoftToolsManager manager] verifyOperationResultWithError:error]) {
        self.resultMethod(nil);
    } else {
        self.resultMethod([FlutterError errorWithCode:exceptionTip message:[[DynamsoftToolsManager manager] getErrorMsgWithError:error] details:nil]);
    }
}

- (void)barcodeReaderOutputRuntimeSettingsToString:(id)arguments
{
    NSError *error = nil;
    NSString *settingsString = [[DynamsoftSDKManager manager].barcodeReader outputSettingsToString:@"" error:&error];
    
    if ([[DynamsoftToolsManager manager] verifyOperationResultWithError:error]) {
        self.resultMethod([[DynamsoftToolsManager manager] stringIsEmptyOrNull:settingsString] ? @"" : settingsString);
    } else {
        self.resultMethod([FlutterError errorWithCode:exceptionTip message:[[DynamsoftToolsManager manager] getErrorMsgWithError:error] details:nil]);
    }
}

- (void)barcodeReader_decodeFile:(id)arguments {
    NSString *filePath = [arguments valueForKey:@"flutterAssetsPath"];
    NSError *error = nil;
    NSArray<iTextResult *> *results = [[DynamsoftSDKManager manager].barcodeReader decodeFileWithName:filePath error:&error];
    if ([[DynamsoftToolsManager manager] verifyOperationResultWithError:error]) {
        self.resultMethod([[DynamsoftConvertManager manager] wrapResultsToJson:results]);
    } else {
        self.resultMethod([FlutterError errorWithCode:exceptionTip message:[[DynamsoftToolsManager manager] getErrorMsgWithError:error] details:nil]);
    }
}

- (void)barcodeReader_enableResultVerification:(id)arguments {
    BOOL isEnable = [arguments boolValue];
    [DynamsoftSDKManager manager].barcodeReader.enableResultVerification = isEnable;
    self.resultMethod(nil);
}

- (void)barcodeReader_setModeArgument:(id)arguments {
    NSString *modesName = [arguments valueForKey:@"modesName"];
    NSInteger index = [[arguments valueForKey:@"index"] integerValue];
    NSString *argumentName = [arguments valueForKey:@"argumentName"];
    NSString *argumentValue = [arguments valueForKey:@"argumentValue"];
    
    NSError *error = nil;
    [[DynamsoftSDKManager manager].barcodeReader setModeArgument:modesName index:index argumentName:argumentName argumentValue:argumentValue error:&error];
    if ([[DynamsoftToolsManager manager] verifyOperationResultWithError:error]) {
        self.resultMethod(nil);
    } else {
        self.resultMethod([FlutterError errorWithCode:exceptionTip message:[[DynamsoftToolsManager manager] getErrorMsgWithError:error] details:nil]);
    }
}

- (void)barcodeReader_getModeArgument:(id)arguments {
    NSString *modesName = [arguments valueForKey:@"modesName"];
    NSInteger index = [[arguments valueForKey:@"index"] integerValue];
    NSString *argumentName = [arguments valueForKey:@"argumentName"];
    
    NSError *error = nil;
    NSString *argumentValue =  [[DynamsoftSDKManager manager].barcodeReader getModeArgument:modesName index:index argumentName:argumentName error:&error];
    if ([[DynamsoftToolsManager manager] verifyOperationResultWithError:error]) {
        self.resultMethod(argumentValue);
    } else {
        self.resultMethod([FlutterError errorWithCode:exceptionTip message:[[DynamsoftToolsManager manager] getErrorMsgWithError:error] details:nil]);
    }
}


//MARK: DCE methods

- (void)cameraEnhancer_createInstance:(id)arguments {
    
    [DynamsoftSDKManager manager].cameraEnhancer = [[DynamsoftCameraEnhancer alloc] init];
    
    if ([DynamsoftSDKManager manager].dceCameraView != nil) {
        [DynamsoftSDKManager manager].cameraEnhancer.dceCameraView = [DynamsoftSDKManager manager].dceCameraView;
    }
    self.resultMethod(nil);
}

- (void)cameraEnhancerDispose:(id)arguments
{
    self.captureView = nil;
    [[DynamsoftSDKManager manager].barcodeReader stopScanning];
    [[DynamsoftSDKManager manager].cameraEnhancer close];
    [DynamsoftSDKManager manager].cameraEnhancer = nil;
   
    self.resultMethod(nil);
}

- (void)cameraEnhancer_setScanRegion:(id)arguments
{
    id scanRegion = [arguments valueForKey:@"scanRegion"] == [NSNull null] ? nil : [[DynamsoftConvertManager manager] analyzeiRegionDefinitionFromJson:arguments];
   
    NSError *error = nil;
    [[DynamsoftSDKManager manager].cameraEnhancer setScanRegion:scanRegion error:&error];
    
    if ([[DynamsoftToolsManager manager] verifyOperationResultWithError:error]) {
        self.resultMethod(nil);
    } else {
        self.resultMethod([FlutterError errorWithCode:exceptionTip message:[[DynamsoftToolsManager manager] getErrorMsgWithError:error] details:nil]);
    }
}

- (void)cameraEnhancer_setScanRegionVisible:(id)arguments
{
    BOOL isVisible = [[arguments valueForKey:@"isVisible"] boolValue];
    [[DynamsoftSDKManager manager].cameraEnhancer setScanRegionVisible:isVisible];
    
    self.resultMethod(nil);
}

- (void)cameraEnhancer_setOverlayVisible:(id)arguments
{
    BOOL isVisible = [[arguments valueForKey:@"isVisible"] boolValue];
    [DynamsoftSDKManager manager].dceCameraView.overlayVisible = isVisible;
    
    self.resultMethod(nil);
}

- (void)cameraEnhancer_openCamera:(id)arguments {
    if ([DynamsoftSDKManager manager].cameraEnhancer != nil) {
        [[DynamsoftSDKManager manager].cameraEnhancer open];
    }
    self.resultMethod(nil);
}

- (void)cameraEnhancer_closeCamera:(id)arguments {
    if ([DynamsoftSDKManager manager].cameraEnhancer != nil) {
        [[DynamsoftSDKManager manager].cameraEnhancer close];
    }
    self.resultMethod(nil);
}

- (void)cameraEnhancer_selectCamera:(id)arguments {
    NSInteger cameraPosition = [arguments integerValue];
    EnumCameraPosition cameraType = cameraPosition == 0 ? EnumCameraPositionBack : EnumCameraPositionFront;
    NSError *error = nil;
    [[DynamsoftSDKManager manager].cameraEnhancer selectCameraWithPosition: cameraType error:&error];
    self.resultMethod(nil);
}

- (void)cameraEnhancer_turnOnTorch:(id)arguments {
    [[DynamsoftSDKManager manager].cameraEnhancer turnOnTorch];
    self.resultMethod(nil);
}

- (void)cameraEnhancer_turnOffTorch:(id)arguments {
    [[DynamsoftSDKManager manager].cameraEnhancer turnOffTorch];
    self.resultMethod(nil);
}

- (void)cameraView_torchButton:(id)arguments {
    BOOL torchIsVisible = YES;
    CGRect torchRect = CGRectMake(25, 100, 45, 45);
    UIImage *torchOnImage = nil;
    UIImage *torchOffImage = nil;
    
    if (![[arguments valueForKey:@"rect"] isEqual:[NSNull null]] && [arguments valueForKey:@"rect"] != nil) {
        torchRect = [[DynamsoftConvertManager manager] analyzeCustomTorchButtonFrameFromJson:arguments torchDefaultRect:torchRect];
    }
    
    if (![[arguments valueForKey:@"torchOnImage"] isEqual:[NSNull null]] && [arguments valueForKey:@"torchOnImage"] != nil) {
        NSString *key = [self.registrar lookupKeyForAsset:[arguments valueForKey:@"torchOnImage"]];
        NSString *path = [[NSBundle mainBundle] pathForResource:key ofType:nil];
        torchOnImage = [UIImage imageWithContentsOfFile:path];
    }

    if (![[arguments valueForKey:@"torchOffImage"] isEqual:[NSNull null]] && [arguments valueForKey:@"torchOffImage"] != nil) {
        NSString *key = [self.registrar lookupKeyForAsset:[arguments valueForKey:@"torchOffImage"]];
        NSString *path = [[NSBundle mainBundle] pathForResource:key ofType:nil];
        torchOffImage = [UIImage imageWithContentsOfFile:path];
    }
    
    if (![[arguments valueForKey:@"visible"] isEqual:[NSNull null]] && [arguments valueForKey:@"visible"] != nil) {
        torchIsVisible = [[arguments valueForKey:@"visible"] boolValue];
    }
    
    [[DynamsoftSDKManager manager].dceCameraView setTorchButton:torchRect torchOnImage:torchOnImage torchOffImage:torchOffImage];
    [DynamsoftSDKManager manager].dceCameraView.torchButtonVisible = torchIsVisible;
    self.resultMethod(nil);
}

//MARK: Application lifecycle
- (void)navigationDidPopNext
{
    if ([DynamsoftSDKManager manager].cameraEnhancer != nil) {
        [[DynamsoftSDKManager manager].cameraEnhancer open];
    }
    
    self.resultMethod(nil);
}

- (void)navigationDidPushNext
{
    if ([DynamsoftSDKManager manager].cameraEnhancer != nil) {
        [[DynamsoftSDKManager manager].cameraEnhancer close];
    }
    
    self.resultMethod(nil);
}


@end
