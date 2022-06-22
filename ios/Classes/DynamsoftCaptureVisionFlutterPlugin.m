#import "DynamsoftCaptureVisionFlutterPlugin.h"
#import "src/DynamsoftCaptureVisionFactory.h"
#import "src/common.h"

@interface DynamsoftCaptureVisionFlutterPlugin ()

@property (nonatomic, strong) DynamsoftCaptureVisionFactory *dynamsoftFactory;

@end

@implementation DynamsoftCaptureVisionFlutterPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
        methodChannelWithName:methodChannel_Identifier
              binaryMessenger:[registrar messenger]];
      
    // dynamsoft facotry
    DynamsoftCaptureVisionFactory *dynamsoftFactory = [[DynamsoftCaptureVisionFactory alloc] initWithFlutterChannel:channel binaryMessenger:registrar];
    
    DynamsoftCaptureVisionFlutterPlugin* instance = [[DynamsoftCaptureVisionFlutterPlugin alloc] initWithCaptureFactory:dynamsoftFactory];
    [registrar addMethodCallDelegate:instance channel:channel];
   
    [registrar registerViewFactory:dynamsoftFactory withId:platformFactory_identifier];
}

- (instancetype)initWithCaptureFactory:(DynamsoftCaptureVisionFactory *)dynamsoftFactory
{
    self = [super init];
    if (self) {
        self.dynamsoftFactory = dynamsoftFactory;
    }
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    
    [self.dynamsoftFactory handleMethodCall:call result:result];
}

@end
