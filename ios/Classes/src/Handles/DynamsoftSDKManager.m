
#import "DynamsoftSDKManager.h"
#import "DynamsoftToolsManager.h"
#import "DynamsoftConvertManager.h"

@implementation DCECameraViewSetting

- (void)clearAllArguments {
    self.overlayVisibleArguments = nil;
    self.torchButtonArguments = nil;
}

- (void)configureArguments {
    if (self.overlayVisibleArguments != nil) {
        id arguments = self.overlayVisibleArguments;
        BOOL isVisible = [[arguments valueForKey:@"isVisible"] boolValue];
        [DynamsoftSDKManager manager].dceCameraView.overlayVisible = isVisible;
    }
    
    if (self.torchButtonArguments != nil) {
        id arguments = self.overlayVisibleArguments;
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
    }
}

@end

@interface DynamsoftSDKManager ()<DBRLicenseVerificationListener>

@end

@implementation DynamsoftSDKManager

+ (DynamsoftSDKManager *)manager
{
    static DynamsoftSDKManager *sdkManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sdkManager = [super allocWithZone:NULL];
    });
    return sdkManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [DynamsoftSDKManager manager];
}

- (id)copyWithZone:(NSZone *)zone
{
    return [DynamsoftSDKManager manager];
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return [DynamsoftSDKManager manager];
}

//MARK: Methods

- (void)barcodeReaderInitLicense:(NSString *)license
{
    [DynamsoftBarcodeReader initLicense:license verificationDelegate:self];
}


//MARK: DBRLicenseVerificationListener
- (void)DBRLicenseVerificationCallback:(bool)isSuccess error:(NSError *)error{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.dbrLicenseVerificationCallback) {
            self.dbrLicenseVerificationCallback(isSuccess, error);
        }
    });
}

//MARK: DBRTextResultListener
- (void)textResultCallback:(NSInteger)frameId imageData:(iImageData *)imageData results:(NSArray<iTextResult *> *)results
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.barcodeTextResultCallBack) {
            self.barcodeTextResultCallBack(results);
        }
    });
}

@end
