//  Copyright (c) 2011, Kevin O'Neill
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  * Redistributions of source code must retain the above copyright
//   notice, this list of conditions and the following disclaimer.
//
//  * Redistributions in binary form must reproduce the above copyright
//   notice, this list of conditions and the following disclaimer in the
//   documentation and/or other materials provided with the distribution.
//
//  * Neither the name UsefulBits nor the names of its contributors may be used
//   to endorse or promote products derived from this software without specific
//   prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
//  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "UIView+Positioning.h"
#import "UIView+Size.h"

@implementation UIView (Positioning)

- (void)centerInRect:(CGRect)rect
{
    [self setCenter:CGPointMake(floorf(CGRectGetMidX(rect)) + ((int)floorf([self width]) % 2 ? .5 : 0) , floorf(CGRectGetMidY(rect)) + ((int)floorf([self height]) % 2 ? .5 : 0))];
}

- (void)centerInRect:(CGRect)rect leftOffset:(CGFloat)left
{
    [self setCenter:CGPointMake(left + floorf(CGRectGetMidX(rect)) + ((int)floorf([self width]) % 2 ? .5 : 0) , floorf(CGRectGetMidY(rect)) + ((int)floorf([self height]) % 2 ? .5 : 0))];
}

- (void)centerInRect:(CGRect)rect topOffset:(CGFloat)top
{
    [self setCenter:CGPointMake(floorf(CGRectGetMidX(rect)) + ((int)floorf([self width]) % 2 ? .5 : 0) , top + floorf(CGRectGetMidY(rect)) + ((int)floorf([self height]) % 2 ? .5 : 0))];
}

- (void)centerVerticallyInRect:(CGRect)rect
{
    [self setCenter:CGPointMake([self center].x, floorf(CGRectGetMidY(rect)) + ((int)floorf([self height]) % 2 ? .5 : 0))];
}

- (void)centerVerticallyInRect:(CGRect)rect left:(CGFloat)left
{
//    [self setCenter:CGPointMake(left + [self center].x, floorf(CGRectGetMidY(rect)) + ((int)floorf([self height]) % 2 ? .5 : 0))];
    
    [self centerVerticallyInRect:rect];
    self.left = left;
}

- (void)centerHorizontallyInRect:(CGRect)rect
{
    [self setCenter:CGPointMake(floorf(CGRectGetMidX(rect)) + ((int)floorf([self width]) % 2 ? .5 : 0), [self center].y)];
}

- (void)centerHorizontallyInRect:(CGRect)rect top:(CGFloat)top
{
//    [self setCenter:CGPointMake(floorf(CGRectGetMidX(rect)) + ((int)floorf([self width]) % 2 ? .5 : 0), top + ((int)floorf([self height]) % 2 ? .5 : 0))];
    
    [self centerHorizontallyInRect:rect];
    self.top = top;
}

- (void)centerInSuperView
{
    [self centerInRect:[[self superview] bounds]];
}

- (void)centerInSuperViewWithLeftOffset:(CGFloat)left
{
    [self centerInRect:[[self superview] bounds] leftOffset:left];
}

- (void)centerInSuperViewWithTopOffset:(CGFloat)top
{
    [self centerInRect:[[self superview] bounds] topOffset:top];
}

- (void)centerVerticallyInSuperView
{
    [self centerVerticallyInRect:[[self superview] bounds]];
}

- (void)centerVerticallyInSuperViewWithLeft:(CGFloat)left
{
    [self centerVerticallyInRect:[[self superview] bounds] left:left];
}

- (void)centerHorizontallyInSuperView
{
    [self centerHorizontallyInRect:[[self superview] bounds]];
}

- (void)centerHorizontallyInSuperViewWithTop:(CGFloat)top
{
    [self centerHorizontallyInRect:[[self superview] bounds] top:top];
}

- (void)centerHorizontallyBelow:(UIView *)view padding:(CGFloat)padding
{
    // for now, could use screen relative positions.
    NSAssert([self superview] == [view superview], @"views must have the same parent");
    
    [self setCenter:CGPointMake([view center].x,
                                floorf(padding + CGRectGetMaxY([view frame]) + ([self height] / 2)))];
}

- (void)centerHorizontallyBelow:(UIView *)view
{
    [self centerHorizontallyBelow:view padding:0];
}

@end


@implementation UIView (wiSubview)
- (void) addSubviewToBack:(UIView*)view
{
    [self addSubview:view];
    [self sendSubviewToBack:view];
}

- (UIViewController*)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) 
    {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (NSInteger)subviewIndex
{
    if (self.superview == nil)
    {
        return NSNotFound;
    }
    
    return [self.superview.subviews indexOfObject:self];
}

- (UIView *)superviewWithClass:(Class)aClass
{
    return [self superviewWithClass:aClass strict:NO];
}

- (UIView *)superviewWithClass:(Class)aClass strict:(BOOL)strict
{
    UIView *view = self.superview;
    
    while(view) {
        if(strict && [view isMemberOfClass:aClass])
        {
            break;
        }
        else if(!strict && [view isKindOfClass:aClass])
        {
            break;
        }
        else
        {
            view = view.superview;
        }
    }
    
    return view;
}

- (UIView*)descendantOrSelfWithClass:(Class)aClass
{
    return [self descendantOrSelfWithClass:aClass strict:NO];
}

- (UIView *)descendantOrSelfWithClass:(Class)aClass strict:(BOOL)strict
{
    if (strict && [self isMemberOfClass:aClass])
    {
        return self;
    }
    else if (!strict && [self isKindOfClass:aClass])
    {
        return self;
    }
    
    for (UIView* child in self.subviews)
    {
        UIView* viewWithClass = [child descendantOrSelfWithClass:aClass strict:strict];
        
        if (viewWithClass != nil)
        {
            return viewWithClass;
        }
    }
    
    return nil;
}

- (void)removeAllSubviews
{
    while (self.subviews.count > 0)
    {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (void)bringToFront
{
    [self.superview bringSubviewToFront:self];
}

- (void)sendToBack
{
    [self.superview sendSubviewToBack:self];
}

- (void)bringOneLevelUp
{
    NSInteger currentIndex = self.subviewIndex;
    [self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex+1];
}

- (void)sendOneLevelDown
{
    NSInteger currentIndex = self.subviewIndex;
    [self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex-1];
}

- (BOOL)isInFront
{
    return (self.superview.subviews.lastObject == self);
}

- (BOOL)isAtBack
{
    return ([self.superview.subviews objectAtIndex:0] == self);
}

- (void)swapDepthsWithView:(UIView*)swapView
{
    [self.superview exchangeSubviewAtIndex:self.subviewIndex withSubviewAtIndex:swapView.subviewIndex];
}

@end


#pragma mark -
#pragma mark UIView + TTUICommon

@implementation UIView (TTUICommon)


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIViewController *)viewController
{
    for (UIView *next = [self superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    
    return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView *)descendantOrSelfWithClass:(Class)cls
{
    if ([self isKindOfClass:cls])
    {
        return self;
    }
    
    for (UIView *child in self.subviews)
    {
        UIView *it = [child descendantOrSelfWithClass:cls];
        if (it)
        {
            return it;
        }
    }
    
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView *)ancestorOrSelfWithClass:(Class)cls
{
    if ([self isKindOfClass:cls])
    {
        return self;
    }
    else if (self.superview)
    {
        return [self.superview ancestorOrSelfWithClass:cls];
    }
    else
    {
        return nil;
    }
}

@end
