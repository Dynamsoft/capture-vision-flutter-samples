
#import "DynamsoftCameraView.h"

@implementation DynamsoftCameraView

- (instancetype)initWithFrame:(CGRect)frame withArguments:(id)arguments
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUIWithArguments:arguments];
    }
    return self;
}

- (void)setupUIWithArguments:(id)arguments
{
    double cameraWidth = [[arguments valueForKey:@"cameraWidth"] doubleValue];
    double cameraHeight = [[arguments valueForKey:@"cameraHeight"] doubleValue];
    
    [DynamsoftSDKManager manager].dceCameraView = [DCECameraView cameraWithFrame:CGRectMake(0, 0, cameraWidth, cameraHeight)];
    self.dceView = [DynamsoftSDKManager manager].dceCameraView;
    [self addSubview:self.dceView];
    
    if ([DynamsoftSDKManager manager].cameraEnhancer != nil) {
        [[DynamsoftSDKManager manager].cameraEnhancer close];
        [DynamsoftSDKManager manager].cameraEnhancer.dceCameraView = [DynamsoftSDKManager manager].dceCameraView;
    }
}

- (void)layoutSubviews {
    self.dceView.frame = self.bounds;
}

@end
