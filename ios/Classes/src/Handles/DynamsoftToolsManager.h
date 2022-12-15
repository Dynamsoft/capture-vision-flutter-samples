
#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface DynamsoftToolsManager : NSObject<NSCopying, NSMutableCopying>

+ (DynamsoftToolsManager *)manager;

/// Get Top ViewController.
- (UIViewController *)viewControllerWithWindow:(UIWindow *_Nullable)window;

/// Verify the operation is success or failure.
- (BOOL)verifyOperationResultWithError:(NSError *)error;

- (NSString *)getErrorMsgWithError:(NSError *)error;

/// Checks if the string is empty
- (BOOL)stringIsEmptyOrNull:(NSString*)string;

@end

NS_ASSUME_NONNULL_END
