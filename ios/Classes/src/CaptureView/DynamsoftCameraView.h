//
//  DynamsoftCameraView.h
//  dynamsoft_capture_vision
//
//  Created by dynamsoft on 2022/3/29.
//

#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>
#import <DynamsoftCameraEnhancer/DynamsoftCameraEnhancer.h>
#import "DynamsoftSDKManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface DynamsoftCameraView : UIView

@property (nonatomic, strong) DCECameraView *dceView;

- (instancetype)initWithFrame:(CGRect)frame withArguments:(id)arguments;

@end

NS_ASSUME_NONNULL_END
