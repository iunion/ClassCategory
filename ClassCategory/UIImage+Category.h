//
//  UIImageAdditions.h
//  Created by Devin Ross on 7/25/09.
//
/*
 
 tapku.com || http://github.com/devinross/tapkulibrary
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import <UIKit/UIKit.h>

#define ROUNDEDRECT_PERCENTAGE 10

@interface UIImage (wiCategory)

// 圆角
+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;
+ (id)createRoundedRectImage:(UIImage*)image radius:(NSInteger)r;

// 裁剪图片
- (UIImage *) imageCroppedToRect:(CGRect)rect;
// 裁减正方形区域
- (UIImage *) squareImage;

// 画水印
// 图片水印
- (UIImage *) imageWithWaterMask:(UIImage*)mask inRect:(CGRect)rect;
// 文字水印
- (UIImage *) imageWithStringWaterMark:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font;
- (UIImage *) imageWithStringWaterMark:(NSString *)markString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font;


// 蒙板
- (void) drawInRect:(CGRect)rect withImageMask:(UIImage*)mask;
- (void) drawMaskedColorInRect:(CGRect)rect withColor:(UIColor*)color;

// 保存图像文件
- (BOOL) writeImageToFileAtPath:(NSString*)aPath;
-(UIImage *)resizeImage:(CGRect)rect;

// 图像旋转(角度)
- (UIImage *) imageRotatedByDegrees:(CGFloat)degrees;

@end


@interface UIImage (Border)

- (UIImage *) imageWithColoredBorder:(NSUInteger)borderThickness borderColor:(UIColor *)color withShadow:(BOOL)withShadow;
- (UIImage *) imageWithTransparentBorder:(NSUInteger)thickness;

@end
