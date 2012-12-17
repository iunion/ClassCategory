#import "UIView+InnerShadow.h"
#import "UIView+Size.h"
#import "UIColor+Category.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (InnerShadow)

// sourced from http://stackoverflow.com/questions/4431292/inner-shadow-effect-on-uiview-layer

// In your drawRect: method... for Ios4
/*
 - (void)drawRect:(CGRect)rect
 {
 [self drawInnerShadowInRect:rect fillColor:[UIColor colorWithHex:0x252525]];
 }
 */

- (void)drawInnerShadowInRect:(CGRect)rect radius:(CGFloat)radius fillColor:(UIColor *)fillColor;
{
    CGRect bounds = [self bounds];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat outsideOffset = 20.f;
    
    CGMutablePathRef visiblePath = CGPathCreateMutable();
    CGPathMoveToPoint(visiblePath, NULL, bounds.size.width-radius, bounds.size.height);
    CGPathAddArc(visiblePath, NULL, bounds.size.width-radius, radius, radius, 0.5f*M_PI, 1.5f*M_PI, YES);
    CGPathAddLineToPoint(visiblePath, NULL, radius, 0.f);
    CGPathAddArc(visiblePath, NULL, radius, radius, radius, 1.5f*M_PI, 0.5f*M_PI, YES);
    CGPathAddLineToPoint(visiblePath, NULL, bounds.size.width-radius, bounds.size.height);
    CGPathCloseSubpath(visiblePath);
    
    [fillColor setFill];
    CGContextAddPath(context, visiblePath);
    CGContextFillPath(context);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, -outsideOffset, -outsideOffset);
    CGPathAddLineToPoint(path, NULL, bounds.size.width+outsideOffset, -outsideOffset);
    CGPathAddLineToPoint(path, NULL, bounds.size.width+outsideOffset, bounds.size.height+outsideOffset);
    CGPathAddLineToPoint(path, NULL, -outsideOffset, bounds.size.height+outsideOffset);
    
    CGPathAddPath(path, NULL, visiblePath);
    CGPathCloseSubpath(path);
    
    CGContextAddPath(context, visiblePath); 
    CGContextClip(context);         
    
    UIColor * shadowColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.6f];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 4.0f), 8.0f, [shadowColor CGColor]);
    [shadowColor setFill];   
    
    CGContextSaveGState(context);   
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    
    CGPathRelease(path);    
    CGPathRelease(visiblePath);     
    CGContextRestoreGState(context);
}

- (void)drawInnerShadowInRect:(CGRect)rect fillColor:(UIColor *)fillColor
{
    [self drawInnerShadowInRect:rect radius:(0.5f * CGRectGetHeight(rect)) fillColor:fillColor];
}

@end


@implementation UIView (Shadow)

- (void)addShadow
{
    CGFloat radius;
    
    CGFloat w = self.width;
    CGFloat h = self.height;
    
    radius = MIN(w, h)/12;
    
    [self addShadow:1 Radius:radius BorderColor:nil ShadowColor:nil];
}

- (void)addShadow:(NSInteger)borderWidth Radius:(CGFloat)radius BorderColor:(UIColor *)borderColor ShadowColor:(UIColor *)shadowColor
{
    [self addShadow:borderWidth Radius:radius BorderColor:borderColor ShadowColor:shadowColor Offset:CGSizeMake(1, 1) Opacity:0.3];
}

- (void)addShadow:(NSInteger)borderWidth Radius:(CGFloat)radius BorderColor:(UIColor *)borderColor ShadowColor:(UIColor *)shadowColor Offset:(CGSize)offset Opacity:(float)opacity
{
    self.layer.borderWidth  = borderWidth;
    self.layer.cornerRadius = radius;
    if (borderColor == nil)
    {
        self.layer.borderColor = [[UIColor colorWithHex:0x999999] CGColor];
    }
    else
    {
        self.layer.borderColor = borderColor.CGColor;
    }
    [self.layer setShadowOffset:offset];
    [self.layer setShadowOpacity:opacity];
    [self.layer setShadowColor:[UIColor blackColor].CGColor];
    if (shadowColor == nil)
    {
        [self.layer setShadowColor:[UIColor blackColor].CGColor];
    }
    else
    {
        [self.layer setShadowColor:shadowColor.CGColor];
    }
}

- (void)addCurveShadow
{
    [self addCurveShadowWithColor:nil];
}

- (void)addCurveShadowWithColor:(UIColor *)color
{
	self.layer.shadowOpacity = 0.4;
	self.layer.shadowRadius = 1.5;
	self.layer.shadowOffset = CGSizeMake(0, 0);
	
	UIBezierPath *path = [UIBezierPath bezierPath];
	
	CGPoint p1 = CGPointMake(0.0, 0.0+self.frame.size.height);
	CGPoint p2 = CGPointMake(0.0+self.frame.size.width, p1.y);
	CGPoint c1 = CGPointMake((p1.x+p2.x)/4 , p1.y+6.0);
	CGPoint c2 = CGPointMake(c1.x*3, c1.y);		
	
	[path moveToPoint:p1];
	[path addCurveToPoint:p2 controlPoint1:c1 controlPoint2:c2];
    
    if (color != nil)
    {
        self.layer.shadowColor = [color CGColor];
    }
    
	self.layer.shadowPath = path.CGPath;
}

- (void)addGrayGradientShadow
{
    [self addGrayGradientShadowWithColor:nil];
}

- (void)addGrayGradientShadowWithColor:(UIColor *)color
{
	// 0.8 is a good feeling shadowOpacity
	self.layer.shadowOpacity = 0.4;
	
	// The Width and the Height of the shadow rect
	CGFloat rectWidth = 6.0;
	CGFloat rectHeight = self.frame.size.height;
	
	// Creat the path of the shadow
	CGMutablePathRef shadowPath = CGPathCreateMutable();
	// Move to the (0, 0) point
	CGPathMoveToPoint(shadowPath, NULL, 0.0, 0.0);
	// Add the Left and right rect
	CGPathAddRect(shadowPath, NULL, CGRectMake(0.0-rectWidth, 0.0, rectWidth, rectHeight));
	CGPathAddRect(shadowPath, NULL, CGRectMake(self.frame.size.width, 0.0, rectWidth, rectHeight));
	
	self.layer.shadowPath = shadowPath;
	CGPathRelease(shadowPath);
	// Since the default color of the shadow is black, we do not need to set it now
    if (color != nil)
    {
        self.layer.shadowColor = [color CGColor];
    }
	
	self.layer.shadowOffset = CGSizeMake(0, 0);
	// This is very important, the shadowRadius decides the feel of the shadow
	self.layer.shadowRadius = 10.0;
}

- (void)addMovingShadow
{
    static float step = 0.0;
	if (step > 20.0)
    {
		step = 0.0;
	}
	
	self.layer.shadowOpacity = 0.4;
	self.layer.shadowRadius = 1.5;
	self.layer.shadowOffset = CGSizeMake(0, 0);
	
	UIBezierPath *path = [UIBezierPath bezierPath];
	
	CGPoint p1 = CGPointMake(0.0, 0.0+self.frame.size.height);
	CGPoint p2 = CGPointMake(0.0+self.frame.size.width, p1.y);
	CGPoint c1 = CGPointMake((p1.x+p2.x)/4 , p1.y+step);
	CGPoint c2 = CGPointMake(c1.x*3, c1.y);		
	
	[path moveToPoint:p1];
	[path addCurveToPoint:p2 controlPoint1:c1 controlPoint2:c2];
	
	self.layer.shadowPath = path.CGPath;
	step += 0.1;
	[self performSelector:@selector(addMovingShadow) withObject:nil afterDelay:1.0/30.0];
}


@end