//
//  UIView+Animation.h
//  lama
//
//  Created by mac on 14-5-4.
//  Copyright (c) 2014年 babytree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)

// Moves
- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;
- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method;
- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack;
- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(id)delegate callback:(SEL)method;

// Transforms
- (void)rotate:(int)degrees secs:(float)secs delegate:(id)delegate callback:(SEL)method;
- (void)scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method;
- (void)spinClockwise:(float)secs;
- (void)spinCounterClockwise:(float)secs;

// Transitions
- (void)curlDown:(float)secs;
- (void)curlUpAndAway:(float)secs;
- (void)drainAway:(float)secs;

// Effects
- (void)changeAlpha:(float)newAlpha secs:(float)secs;


@end
