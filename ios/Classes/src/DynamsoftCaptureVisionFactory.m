//
//  DynamsoftCaptureVisionFactory.m
//  dynamsoft_capture_vision
//
//  Created by dynamsoft on 2022/3/28.
//

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
        
        // stream
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
        [DynamsoftSDKManager manager].barcodeTextResultCallBack = ^(NSArray<iTextResult *> * _Nonnull results) {
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
    }

    // DCE
    else if ([cameraEnhancer_dispose isEqualToString:call.method]) {
        [self cameraEnhancerDispose:call.arguments];
    } else if ([cameraEnhancer_setScanRegion isEqualToString:call.method]) {
        [self cameraEnhancer_setScanRegion:call.arguments];
    } else if ([cameraEnhancer_setScanRegionVisible isEqualToString:call.method]) {
        [self cameraEnhancer_setScanRegionVisible:call.arguments];
    } else if ([cameraEnhancer_setOverlayVisible isEqualToString:call.method]) {
        [self cameraEnhancer_setOverlayVisible:call.arguments];
    } else if ([cameraEnhancer_openCamera isEqualToString:call.method]) {
        [self cameraEnhancer_openCamera:call.method];
    } else if ([cameraEnhancer_closeCamera isEqualToString:call.method]) {
        [self cameraEnhancer_closeCamera:call.method];
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
    
    if ([DynamsoftSDKManager manager].cameraEnhancer != nil && [DynamsoftSDKManager manager].barcodeReaderLinkCameraEnhancerIsFinished == false) {
        
        [DynamsoftSDKManager manager].barcodeReaderLinkCameraEnhancerIsFinished = true;
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
    iPublicRuntimeSettings *runtimeSettings = [[DynamsoftConvertManager manager] aynlyzeRuntimeSettingsFromJson:arguments];

    NSError *error = nil;
    [[DynamsoftSDKManager manager].barcodeReader updateRuntimeSettings:runtimeSettings error:&error];
    
    if ([[DynamsoftToolsManager manager] vertifyOperationResultWithError:error]) {
        self.resultMethod(nil);
    } else {
        self.resultMethod([FlutterError errorWithCode:exceptionTip message:[[DynamsoftToolsManager manager] getErrorMsgWithError:error] details:nil]);
    }
    
}

- (void)barcodeReaderGetRuntimeSettings:(id)arguments
{
    NSError *error = nil;
    iPublicRuntimeSettings *runtimeSettings = [[DynamsoftSDKManager manager].barcodeReader getRuntimeSettings:&error];
    
    if ([[DynamsoftToolsManager manager] vertifyOperationResultWithError:error]) {
        self.resultMethod([[DynamsoftConvertManager manager] wrapRuntimeSettingsToJson:runtimeSettings]);
    } else {
        self.resultMethod([FlutterError errorWithCode:exceptionTip message:[[DynamsoftToolsManager manager] getErrorMsgWithError:error] details:nil]);
    }
}

- (void)barcodeReaderUpdateRuntimeSettingsFromTemplate:(id)arguments
{
    EnumPresetTemplate presetTemple = [[DynamsoftConvertManager manager] aynlyzePresetTemplateFromJson:arguments];

    [[DynamsoftSDKManager manager].barcodeReader updateRuntimeSettings:presetTemple];
    self.resultMethod(nil);
}

- (void)barcodeReaderUpdateRuntimeSettingsFromJson:(id)arguments
{
    NSString *jsonString = [arguments valueForKey:@"jsonString"];
    NSError *error = nil;
    [[DynamsoftSDKManager manager].barcodeReader initRuntimeSettingsWithString:jsonString conflictMode:EnumConflictModeOverwrite error:&error];
    
    if ([[DynamsoftToolsManager manager] vertifyOperationResultWithError:error]) {
        self.resultMethod(nil);
    } else {
        self.resultMethod([FlutterError errorWithCode:exceptionTip message:[[DynamsoftToolsManager manager] getErrorMsgWithError:error] details:nil]);
    }
}

- (void)barcodeReaderResetRuntimeSettings:(id)arguments
{
    NSError *error = nil;
    [[DynamsoftSDKManager manager].barcodeReader resetRuntimeSettings:&error];
    
    if ([[DynamsoftToolsManager manager] vertifyOperationResultWithError:error]) {
        self.resultMethod(nil);
    } else {
        self.resultMethod([FlutterError errorWithCode:exceptionTip message:[[DynamsoftToolsManager manager] getErrorMsgWithError:error] details:nil]);
    }
}

- (void)barcodeReaderOutputRuntimeSettingsToString:(id)arguments
{
    NSError *error = nil;
    NSString *settingsString = [[DynamsoftSDKManager manager].barcodeReader outputSettingsToString:@"" error:&error];
    
    if ([[DynamsoftToolsManager manager] vertifyOperationResultWithError:error]) {
        self.resultMethod([[DynamsoftToolsManager manager] stringIsEmptyOrNull:settingsString] ? @"" : settingsString);
    } else {
        self.resultMethod([FlutterError errorWithCode:exceptionTip message:[[DynamsoftToolsManager manager] getErrorMsgWithError:error] details:nil]);
    }
}


//MARK: DCE methods
- (void)cameraEnhancerDispose:(id)arguments
{
    self.captureView = nil;
    [DynamsoftSDKManager manager].barcodeReaderLinkCameraEnhancerIsFinished = false;
    [[DynamsoftSDKManager manager].barcodeReader stopScanning];
    [[DynamsoftSDKManager manager].cameraEnhancer close];
    [DynamsoftSDKManager manager].cameraEnhancer = nil;
   
    self.resultMethod(nil);
}

- (void)cameraEnhancer_setScanRegion:(id)arguments
{

    id scanRegion = [arguments valueForKey:@"scanRegion"] == [NSNull null] ? nil : [[DynamsoftConvertManager manager] aynlyzeiRegionDefinitionFromJson:arguments];
   
    NSError *error = nil;
    [[DynamsoftSDKManager manager].cameraEnhancer setScanRegion:scanRegion error:&error];
    
    if ([[DynamsoftToolsManager manager] vertifyOperationResultWithError:error]) {
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
    self.captureView.cameraView.dceView.overlayVisible = isVisible;
    
    self.resultMethod(nil);
}

- (void)cameraEnhancer_openCamera:(id)arguments {
    if ([DynamsoftSDKManager manager].cameraEnhancer != nil && [DynamsoftSDKManager manager].barcodeReaderLinkCameraEnhancerIsFinished == true) {
        [[DynamsoftSDKManager manager].cameraEnhancer open];
    }
    self.resultMethod(nil);
}

- (void)cameraEnhancer_closeCamera:(id)arguments {
    if ([DynamsoftSDKManager manager].cameraEnhancer != nil && [DynamsoftSDKManager manager].barcodeReaderLinkCameraEnhancerIsFinished == true) {
        [[DynamsoftSDKManager manager].cameraEnhancer close];
    }
    self.resultMethod(nil);
}

//MARK: Application lifecycle
- (void)navigationDidPopNext
{
    if ([DynamsoftSDKManager manager].cameraEnhancer != nil && [DynamsoftSDKManager manager].barcodeReaderLinkCameraEnhancerIsFinished == true) {
        [[DynamsoftSDKManager manager].cameraEnhancer open];
    }
    
    self.resultMethod(nil);
}

- (void)navigationDidPushNext
{
    if ([DynamsoftSDKManager manager].cameraEnhancer != nil && [DynamsoftSDKManager manager].barcodeReaderLinkCameraEnhancerIsFinished == true) {
        [[DynamsoftSDKManager manager].cameraEnhancer close];
    }
    
    self.resultMethod(nil);
}


@end
