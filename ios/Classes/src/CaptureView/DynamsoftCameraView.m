//
//  DynamsoftCameraView.m
//  dynamsoft_capture_vision
//
//  Created by dynamsoft on 2022/3/29.
//

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
    self.dceView = [DCECameraView cameraWithFrame:CGRectMake(0, 0, cameraWidth, cameraHeight)];
    [self addSubview:self.dceView];

    [DynamsoftSDKManager manager].cameraEnhancer = [[DynamsoftCameraEnhancer alloc] initWithView:self.dceView];

    [[DynamsoftSDKManager manager].cameraEnhancer open];
    
}


@end
