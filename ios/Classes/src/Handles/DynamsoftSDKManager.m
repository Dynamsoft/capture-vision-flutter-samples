//
//  DynamsoftSDKManager.m
//  dbr_test_plugin
//
//  Created by dynamsoft on 2022/2/21.
//

#import "DynamsoftSDKManager.h"
#import "DynamsoftToolsManager.h"

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
    if (self.dbrLicenseVerificationCallback) {
        self.dbrLicenseVerificationCallback(isSuccess, error);
    }
}

//MARK: DBRTextResultListener
- (void)textResultCallback:(NSInteger)frameId imageData:(iImageData *)imageData results:(NSArray<iTextResult *> *)results
{
    if (results.count > 0) {
        
        if (self.barcodeTextResultCallBack) {
            self.barcodeTextResultCallBack(results);
        }

    }
}

@end
