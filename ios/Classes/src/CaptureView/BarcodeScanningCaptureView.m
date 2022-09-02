
#import "BarcodeScanningCaptureView.h"

@implementation BarcodeScanningCaptureView

- (UIView *)view
{
    return self.cameraView;
}

- (void)createViewWithArguments:(id)arguments
{
    double cameraWidth = [[arguments valueForKey:@"cameraWidth"] doubleValue];
    double cameraHeight = [[arguments valueForKey:@"cameraHeight"] doubleValue];
    
    self.cameraView = [[DynamsoftCameraView alloc] initWithFrame:CGRectMake(0, 0, cameraWidth, cameraHeight) withArguments:arguments];
}

@end
