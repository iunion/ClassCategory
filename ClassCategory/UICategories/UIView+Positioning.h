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

#import <UIKit/UIKit.h>

@interface UIView (Positioning)

- (void)centerInRect:(CGRect)rect;
- (void)centerInRect:(CGRect)rect leftOffset:(CGFloat)left;
- (void)centerInRect:(CGRect)rect topOffset:(CGFloat)top;
- (void)centerVerticallyInRect:(CGRect)rect;
- (void)centerVerticallyInRect:(CGRect)rect left:(CGFloat)left;
- (void)centerHorizontallyInRect:(CGRect)rect;
- (void)centerHorizontallyInRect:(CGRect)rect top:(CGFloat)top;

- (void)centerInSuperView;
- (void)centerInSuperViewWithLeftOffset:(CGFloat)left;
- (void)centerInSuperViewWithTopOffset:(CGFloat)top;
- (void)centerVerticallyInSuperView;
- (void)centerVerticallyInSuperViewWithLeft:(CGFloat)left;
- (void)centerHorizontallyInSuperView;
- (void)centerHorizontallyInSuperViewWithTop:(CGFloat)top;

- (void)centerHorizontallyBelow:(UIView *)view padding:(CGFloat)padding;
- (void)centerHorizontallyBelow:(UIView *)view;

@end

@interface UIView (wiSubview)

/**
 * The view controller whose view contains this view.
 */
@property (nonatomic, readonly) UIViewController *viewController;
@property (nonatomic, readonly) NSInteger subviewIndex;

- (void)addSubviewToBack:(UIView*)view;

- (UIView *)superviewWithClass:(Class)aClass; // strict:NO
- (UIView *)superviewWithClass:(Class)aClass strict:(BOOL)strict;

- (UIView *)descendantOrSelfWithClass:(Class)aClass; // strict:NO
- (UIView *)descendantOrSelfWithClass:(Class)aClass strict:(BOOL)strict;

- (void)removeAllSubviews;

- (void)bringToFront;
- (void)sendToBack;

- (void)bringOneLevelUp;
- (void)sendOneLevelDown;

- (BOOL)isInFront;
- (BOOL)isAtBack;

- (void)swapDepthsWithView:(UIView*)swapView;


// view searching

- (UIView *)viewMatchingPredicate:(NSPredicate *)predicate;
- (UIView *)viewWithTag:(NSInteger)tag ofClass:(Class)viewClass;
- (UIView *)viewOfClass:(Class)viewClass;
- (NSArray *)viewsMatchingPredicate:(NSPredicate *)predicate;
- (NSArray *)viewsWithTag:(NSInteger)tag;
- (NSArray *)viewsWithTag:(NSInteger)tag ofClass:(Class)viewClass;
- (NSArray *)viewsOfClass:(Class)viewClass;

- (UIView *)firstSuperviewMatchingPredicate:(NSPredicate *)predicate;
- (UIView *)firstSuperviewOfClass:(Class)viewClass;
- (UIView *)firstSuperviewWithTag:(NSInteger)tag;
- (UIView *)firstSuperviewWithTag:(NSInteger)tag ofClass:(Class)viewClass;

- (BOOL)viewOrAnySuperviewMatchesPredicate:(NSPredicate *)predicate;
- (BOOL)viewOrAnySuperviewIsKindOfClass:(Class)viewClass;
- (BOOL)isSuperviewOfView:(UIView *)view;
- (BOOL)isSubviewOfView:(UIView *)view;

- (UIViewController *)firstViewController;
- (UIView *)firstResponder;


@end

@interface UIView (TTUICommon)

/**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 */
- (UIView *)descendantOrSelfWithClass:(Class)cls;

/**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 */
- (UIView *)ancestorOrSelfWithClass:(Class)cls;

@end
