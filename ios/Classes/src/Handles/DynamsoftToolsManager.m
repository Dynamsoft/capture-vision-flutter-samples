//
//  DynamsoftToolsManager.m
//  dynamsoft_barcode_reader
//
//  Created by dynamsoft on 2022/3/1.
//

#import "DynamsoftToolsManager.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/Photos.h>
#import <PhotosUI/PHPhotoLibrary+PhotosUISupport.h>
#import <PhotosUI/PhotosUI.h>

@interface DynamsoftToolsManager ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@property (nonatomic, copy) void(^imagePickerCompletePickingBlock)(NSURL *imageUrl);
@property (nonatomic, copy) void(^imagePickerAuthorizationFailureBlock)(FlutterError *error);

@end

@implementation DynamsoftToolsManager

+ (DynamsoftToolsManager *)manager
{
    static DynamsoftToolsManager *toolsManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toolsManager = [super allocWithZone:NULL];
    });
    return toolsManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [DynamsoftToolsManager manager];
}

- (id)copyWithZone:(NSZone *)zone
{
    return [DynamsoftToolsManager manager];
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return [DynamsoftToolsManager manager];
}

//MARK: Methods

- (UIViewController *)viewControllerWithWindow:(UIWindow *_Nullable)window
{
  UIWindow *windowToUse = window;
  if (windowToUse == nil) {
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
      if (window.isKeyWindow) {
        windowToUse = window;
        break;
      }
    }
  }

  UIViewController *topController = windowToUse.rootViewController;
  while (topController.presentedViewController) {
    topController = topController.presentedViewController;
  }
  return topController;
}

- (BOOL)vertifyOperationResultWithError:(NSError *)error
{
    BOOL isSuccess = YES;
    if (error != nil) {
        NSString *msg = error.userInfo[NSUnderlyingErrorKey];
        
        if ([msg isEqualToString:@"Successful."]) {
            isSuccess = YES;
        } else {
            isSuccess = NO;
        }
        
    }
    return  isSuccess;
}

- (NSString *)getErrorMsgWithError:(NSError *)error
{
    NSString *errorString = @"";
    if (error != nil) {
        errorString = error.userInfo[NSUnderlyingErrorKey];
        
    }
    return errorString;
}

//MARK: String methods
/// Checks if the string is empty
- (BOOL)stringIsEmptyOrNull:(NSString*)string
{
    return ![self notEmptyOrNull:string];
}

/// Checks if the string is not empty
- (BOOL)notEmptyOrNull:(NSString*)string
{
    if ([string isKindOfClass:[NSNull class]])
        return NO;
    if ([string isEqual:[NSNull null]] || string==nil) {
        return NO;
    }
    if ([string isKindOfClass:[NSNumber class]]) {
        if (string != nil) {
            return YES;
        }
        return NO;
    }
    else {
        string = [self trimString:string];
        if ( [string isEqualToString:@"null"] || [string isEqualToString:@"(null)"] || [string isEqualToString:@" "]|| [string isEqualToString:@""] || [string isEqualToString:@"<null>"]) {
            return NO;
        }
        if (string != nil && string.length > 0) {
            return YES;
        }
        return NO;
    }
}

/// cropString
- (NSString*)trimString:(NSString*)str
{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
