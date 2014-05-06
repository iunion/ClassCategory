//
//  CommonMacros.h
//  lama
//
//  Created by mac on 13-12-18.
//  Copyright (c) 2013年 babytree. All rights reserved.
//

#ifndef _CommonMacros_h
#define _CommonMacros_h


#pragma mark - Device macro

#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#ifndef IOS_VERSION
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#endif


#pragma mark - data change macro

#define DEGREES_TO_RADIANS(x)       ((x) * (M_PI / 180.0))

//RGB color macro
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//RGB color macro with alpha
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]


#pragma mark - UI macro

#define UI_NAVIGATION_BAR_DEFAULTHEIGHT 44
#define UI_NAVIGATION_BAR_HEIGHT        44
#define UI_NAVIGATION_BAR_HEIGHT_GAP    4
#define UI_TOOL_BAR_HEIGHT              44
#define UI_TAB_BAR_HEIGHT               49
#define UI_STATUS_BAR_HEIGHT            20
#define UI_SCREEN_WIDTH                 ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)
#define UI_MAINSCREEN_HEIGHT            (UI_SCREEN_HEIGHT - UI_STATUS_BAR_HEIGHT)
#define UI_MAINSCREEN_HEIGHT_ROTATE     (UI_SCREEN_WIDTH - UI_STATUS_BAR_HEIGHT)
#define UI_WHOLE_SCREEN_FRAME           CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)
#define UI_WHOLE_SCREEN_FRAME_ROTATE    CGRectMake(0, 0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH)
#define UI_MAIN_VIEW_FRAME              CGRectMake(0, UI_STATUS_BAR_HEIGHT, UI_SCREEN_WIDTH, UI_MAINSCREEN_HEIGHT)
#define UI_MAIN_VIEW_FRAME_ROTATE       CGRectMake(0, UI_STATUS_BAR_HEIGHT, UI_SCREEN_HEIGHT, UI_MAINSCREEN_HEIGHT_ROTATE)


#pragma mark - Default define
// 动画默认时长
#define DEFAULT_DELAY_TIME (0.25f)
// 等待默认时长
#define PROGRESSBOX_DEFAULT_HIDE_DELAY  (1.0f)

#define TIMEZONE_BEIJING [NSTimeZone timeZoneWithName:@"Asia/Shanghai"]


#pragma mark - color config

#define UI_DEFAULT_BGCOLOR [UIColor colorWithHex:0xFF6699]


#endif
