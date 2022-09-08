
#import "DynamsoftConvertManager.h"

@implementation DynamsoftConvertManager

+ (DynamsoftConvertManager *)manager
{
    static DynamsoftConvertManager *convertManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        convertManager = [super allocWithZone:NULL];
    });
    return convertManager;
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [DynamsoftConvertManager manager];
}

- (id)copyWithZone:(NSZone *)zone
{
    return [DynamsoftConvertManager manager];
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return [DynamsoftConvertManager manager];
}

//MARK: FromJson

- (iPublicRuntimeSettings *)aynlyzeRuntimeSettingsFromJson:(id)jsonData
{
    NSDictionary *settings = [jsonData valueForKey:@"runtimeSettings"];
    iPublicRuntimeSettings *publicRuntimeSettings = [[DynamsoftSDKManager manager].barcodeReader getRuntimeSettings:nil];
    publicRuntimeSettings.barcodeFormatIds = [[settings valueForKey:@"barcodeFormatIds"] intValue];
    publicRuntimeSettings.barcodeFormatIds_2 = [[settings valueForKey:@"barcodeFormatIds_2"] intValue];
    publicRuntimeSettings.expectedBarcodesCount = [[settings valueForKey:@"expectedBarcodeCount"] intValue];
    publicRuntimeSettings.timeout = [[settings valueForKey:@"timeout"] intValue];
    publicRuntimeSettings.minBarcodeTextLength = [[settings valueForKey:@"minBarcodeTextLength"] intValue];
    publicRuntimeSettings.minResultConfidence = [[settings valueForKey:@"minResultConfidence"] intValue];
    
    return publicRuntimeSettings;
}

- (EnumPresetTemplate)aynlyzePresetTemplateFromJson:(id)jsonData
{
    NSString *presetTemplate = [jsonData valueForKey:@"presetTemplate"];
    EnumPresetTemplate enumPresetTemplate = EnumPresetTemplateDefault;
    if ([presetTemplate isEqualToString:@"default"]) {
        enumPresetTemplate = EnumPresetTemplateDefault;
    } else if ([presetTemplate isEqualToString:@"videoSingleBarcode"]) {
        enumPresetTemplate = EnumPresetTemplateVideoSingleBarcode;
    } else if ([presetTemplate isEqualToString:@"videoSpeedFirst"]) {
        enumPresetTemplate = EnumPresetTemplateVideoSpeedFirst;
    } else if ([presetTemplate isEqualToString:@"videoReadRateFirst"]) {
        enumPresetTemplate = EnumPresetTemplateVideoReadRateFirst;
    } else if ([presetTemplate isEqualToString:@"imageSpeedFirst"]) {
        enumPresetTemplate = EnumPresetTemplateImageSpeedFirst;
    } else if ([presetTemplate isEqualToString:@"imageReadRateFirst"]) {
        enumPresetTemplate = EnumPresetTemplateImageReadRateFirst;
    } else if ([presetTemplate isEqualToString:@"imageDefault"]) {
        enumPresetTemplate = EnumPresetTemplateImageDefault;
    }
    return enumPresetTemplate;
}

/// Convert json to iRegionDefinition
- (iRegionDefinition *)aynlyzeiRegionDefinitionFromJson:(id)jsonData
{
    NSDictionary *scanRegionDic = [jsonData valueForKey:@"scanRegion"];
    NSInteger regionTop = [[scanRegionDic valueForKey:@"regionTop"] integerValue];
    NSInteger regionBottom = [[scanRegionDic valueForKey:@"regionBottom"] integerValue];
    NSInteger regionLeft = [[scanRegionDic valueForKey:@"regionLeft"] integerValue];
    NSInteger regionRight = [[scanRegionDic valueForKey:@"regionRight"] integerValue];
    bool regionMeasuredByPercentage = [[scanRegionDic valueForKey:@"regionMeasuredByPercentage"] boolValue];
    iRegionDefinition *regionDefiniton = [[iRegionDefinition alloc] init];
    regionDefiniton.regionTop = regionTop;
    regionDefiniton.regionBottom = regionBottom;
    regionDefiniton.regionLeft = regionLeft;
    regionDefiniton.regionRight = regionRight;
    regionDefiniton.regionMeasuredByPercentage = regionMeasuredByPercentage;
    return  regionDefiniton;
}

- (CGRect)aynlyzeCustomTorchButtonFrameFromJson:(id)jsonData
                               torchDefaultRect:(CGRect)torchDefaultRect {
    NSDictionary *customButtonDic = [jsonData valueForKey:@"rect"];
    CGFloat x = [[customButtonDic valueForKey:@"x"] floatValue];
    CGFloat y = [[customButtonDic valueForKey:@"y"] floatValue];
    CGFloat width = [[customButtonDic valueForKey:@"width"] floatValue];
    CGFloat height = [[customButtonDic valueForKey:@"height"] floatValue];
    return CGRectMake(x, y, width <= torchDefaultRect.size.width ? width : torchDefaultRect.size.width, height <= torchDefaultRect.size.height ? height : torchDefaultRect.size.height);
}

//MARK: ToJson

- (NSArray *)wrapResultsToJson:(NSArray<iTextResult *> *)results
{
    NSMutableArray *jsonArray = [NSMutableArray array];
    for (iTextResult *textResult in results) {
        NSString *barcodeFormatString = @"";
        if (textResult.barcodeFormat_2 != 0) {
            barcodeFormatString = textResult.barcodeFormatString_2;
        } else {
            barcodeFormatString = textResult.barcodeFormatString;
        }
        
        NSMutableArray *locationPoints = [NSMutableArray array];
        for (NSValue *resultPoint in textResult.localizationResult.resultPoints) {
            CGPoint point = [resultPoint CGPointValue];
            [locationPoints addObject:@{@"x":@((int)point.x),
                                        @"y":@((int)point.y)
                                      }];
        }

        [jsonArray addObject:@{@"barcodeText":textResult.barcodeText,
                               @"barcodeFormatString":barcodeFormatString,
                               @"barcodeBytesString":[textResult.barcodeBytes base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed],
                               @"barcodeLocation":@{@"angle":@(textResult.localizationResult.angle),
                                                    @"location":@{@"pointsList":locationPoints}
                               }
                             }];
        
    }
    
    return jsonArray;
}

- (NSDictionary *)wrapRuntimeSettingsToJson:(iPublicRuntimeSettings *)runtimeSettings
{
    return @{@"barcodeFormatIds":@(runtimeSettings.barcodeFormatIds),
             @"barcodeFormatIds_2":@(runtimeSettings.barcodeFormatIds_2),
             @"expectedBarcodeCount":@(runtimeSettings.expectedBarcodesCount),
             @"timeout":@(runtimeSettings.timeout),
             @"minBarcodeTextLength":@(runtimeSettings.minBarcodeTextLength),
             @"minResultConfidence":@(runtimeSettings.minResultConfidence)
    };
}

@end
