
#import <Foundation/Foundation.h>
#import <DynamsoftBarcodeReader/DynamsoftBarcodeReader.h>
#import <DynamsoftCameraEnhancer/DynamsoftCameraEnhancer.h>
#import "DynamsoftSDKManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface DynamsoftConvertManager : NSObject<NSCopying, NSMutableCopying>

+ (DynamsoftConvertManager *)manager;

//MARK: FromJson

/// Convert json to iPublicRuntimeSettings.
- (iPublicRuntimeSettings *)aynlyzeRuntimeSettingsFromJson:(id)jsonData;

/// Convert json to EnumPresetTemplate.
- (EnumPresetTemplate)aynlyzePresetTemplateFromJson:(id)jsonData;

/// Convert json to iRegionDefinition.
- (iRegionDefinition *)aynlyzeiRegionDefinitionFromJson:(id)jsonData;

/// Convert json to custom torch button frame.
- (CGRect)aynlyzeCustomTorchButtonFrameFromJson:(id)jsonData
                               torchDefaultRect:(CGRect)torchDefaultRect;

//MARK: ToJson

/// Wrap textResults to Json.
- (NSArray *)wrapResultsToJson:(NSArray<iTextResult *> *)results;

/// Wrap iPublicRuntimeSettings to Json.
- (NSDictionary *)wrapRuntimeSettingsToJson:(iPublicRuntimeSettings *)runtimeSettings;

@end

NS_ASSUME_NONNULL_END
