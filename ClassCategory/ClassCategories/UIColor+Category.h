//
//  wiUIColor.h
//  wiIos
//
//  Created by qq on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor (Hex)
+ (UIColor *) colorWithHexString:(NSString *)stringToConvert;

+ (id) colorWithHex:(unsigned int)hex;
+ (id) colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha;

+ (id) randomColor;

@end



@interface UIColor (UIColor_Expanded)
@property (nonatomic, readonly) CGColorSpaceModel colorSpaceModel;
@property (nonatomic, readonly) BOOL canProvideRGBComponents;

// With the exception of -alpha, these properties will function
// correctly only if this color is an RGB or white color.
// In these cases, canProvideRGBComponents returns YES.
@property (nonatomic, readonly) CGFloat red;
@property (nonatomic, readonly) CGFloat green;
@property (nonatomic, readonly) CGFloat blue;
@property (nonatomic, readonly) CGFloat white;
@property (nonatomic, readonly) CGFloat hue;
@property (nonatomic, readonly) CGFloat saturation;
@property (nonatomic, readonly) CGFloat brightness;
@property (nonatomic, readonly) CGFloat alpha;
@property (nonatomic, readonly) CGFloat luminance;
@property (nonatomic, readonly) UInt32 rgbHex;

- (NSString *) colorSpaceString;
- (NSArray *) arrayFromRGBAComponents;

// Bulk access to RGB and HSB components of the color
// HSB components are converted from the RGB components
- (BOOL) red:(CGFloat *)r green:(CGFloat *)g blue:(CGFloat *)b alpha:(CGFloat *)a;
- (BOOL) hue:(CGFloat *)h saturation:(CGFloat *)s brightness:(CGFloat *)b alpha:(CGFloat *)a;

// Return a grey-scale representation of the color
- (UIColor *) colorByLuminanceMapping;

// Arithmetic operations on the color
- (UIColor *) colorByMultiplyingByRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (UIColor *) colorByAddingRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (UIColor *) colorByLighteningToRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (UIColor *) colorByDarkeningToRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

- (UIColor *) colorByMultiplyingBy:(CGFloat)f;
- (UIColor *) colorByAdding:(CGFloat)f;
- (UIColor *) colorByLighteningTo:(CGFloat)f;
- (UIColor *) colorByDarkeningTo:(CGFloat)f;

- (UIColor *) colorByMultiplyingByColor:(UIColor *)color;
- (UIColor *) colorByAddingColor:(UIColor *)color;
- (UIColor *) colorByLighteningToColor:(UIColor *)color;
- (UIColor *) colorByDarkeningToColor:(UIColor *)color;

// Related colors
- (UIColor *) contrastingColor; // A good contrasting color: will be either black or white
- (UIColor *) complementaryColor; // A complementary color that should look good with this color
- (NSArray*) triadicColors; // Two colors that should look good with this color
- (NSArray*) analogousColorsWithStepAngle:(CGFloat)stepAngle pairCount:(int)pairs; // Multiple pairs of colors

// String representations of the color
- (NSString *) stringFromColor;
- (NSString *) hexStringFromColor;

// Low level conversions between RGB and HSL spaces
+ (void) hue:(CGFloat)h saturation:(CGFloat)s brightness:(CGFloat)v toRed:(CGFloat *)r green:(CGFloat *)g blue:(CGFloat *)b;
+ (void) red:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b toHue:(CGFloat *)h saturation:(CGFloat *)s brightness:(CGFloat *)v;

@end


@interface UIColor (FlatColors)

+ (UIColor *)flatRedColor;
+ (UIColor *)flatDarkRedColor;

+ (UIColor *)flatGreenColor;
+ (UIColor *)flatDarkGreenColor;

+ (UIColor *)flatBlueColor;
+ (UIColor *)flatDarkBlueColor;

+ (UIColor *)flatTealColor;
+ (UIColor *)flatDarkTealColor;

+ (UIColor *)flatPurpleColor;
+ (UIColor *)flatDarkPurpleColor;

+ (UIColor *)flatBlackColor;
+ (UIColor *)flatDarkBlackColor;

+ (UIColor *)flatYellowColor;
+ (UIColor *)flatDarkYellowColor;

+ (UIColor *)flatOrangeColor;
+ (UIColor *)flatDarkOrangeColor;

+ (UIColor *)flatWhiteColor;
+ (UIColor *)flatDarkWhiteColor;

+ (UIColor *)flatGrayColor;
+ (UIColor *)flatDarkGrayColor;

+ (UIColor *)randomFlatColor;
+ (UIColor *)randomFlatLightColor;
+ (UIColor *)randomFlatDarkColor;

@end
