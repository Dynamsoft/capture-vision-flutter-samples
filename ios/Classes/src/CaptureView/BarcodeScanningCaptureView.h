
#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import <DynamsoftCameraEnhancer/DynamsoftCameraEnhancer.h>
#import "DynamsoftCameraView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BarcodeScanningCaptureView : NSObject<FlutterPlatformView>


@property (nonatomic, strong) DynamsoftCameraView *cameraView;

- (void)createViewWithArguments:(id)arguments;

@end

NS_ASSUME_NONNULL_END
