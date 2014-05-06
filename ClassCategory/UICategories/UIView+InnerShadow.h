#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (RoundedRect)
- (void) roundedRect:(CGFloat)radius;
- (void) roundedRect:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
@end

@interface UIView (InnerShadow)

- (void) drawInnerShadowInRect:(CGRect)rect fillColor:(UIColor *)fillColor;
- (void) drawInnerShadowInRect:(CGRect)rect radius:(CGFloat)radius fillColor:(UIColor *)fillColor;

@end

@interface UIView (Shadow)

- (void) addShadow;
- (void) addShadow:(NSInteger)borderWidth Radius:(CGFloat)radius BorderColor:(UIColor *)borderColor ShadowColor:(UIColor *)shadowColor;
- (void) addShadow:(NSInteger)borderWidth Radius:(CGFloat)radius BorderColor:(UIColor *)borderColor ShadowColor:(UIColor *)shadowColor Offset:(CGSize)offset Opacity:(float)opacity;

- (void) addCurveShadow;
- (void) addCurveShadowWithColor:(UIColor *)color;

- (void) addGrayGradientShadow;
- (void) addGrayGradientShadowWithColor:(UIColor *)color;

- (void) addMovingShadow;

@end


@interface UIView (Screenshot)
- (UIImage *)screenshot;
- (UIImage *)screenshotWithRect:(CGRect)rect;
@end

