#import <UIKit/UIKit.h>

@interface UIView (InnerShadow)

- (void)drawInnerShadowInRect:(CGRect)rect fillColor:(UIColor *)fillColor;
- (void)drawInnerShadowInRect:(CGRect)rect radius:(CGFloat)radius fillColor:(UIColor *)fillColor;

@end

@interface UIView (Shadow)

- (void) addShadow;
- (void) addShadow:(NSInteger)borderWidth Radius:(CGFloat)radius BorderColor:(UIColor *)borderColor ShadowColor:(UIColor *)shadowColor;

- (void) addCurveShadow;
- (void) addCurveShadowWithColor:(UIColor *)color;

- (void) addGrayGradientShadow;
- (void) addGrayGradientShadowWithColor:(UIColor *)color;

-(void) addMovingShadow;

@end
