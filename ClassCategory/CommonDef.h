//
//  wiAppDelegate.h
//  wiIos
//
//  Created by xuanwenchao on 11-12-20.
//  Copyright (c) 2011年 Waptech (Beijing) Information Technologies, Ltd. All rights reserved.
//

#import "NSObject+Category.h"
#import "NSData+Category.h"
#import "NSDate+Category.h"
#import "NSDictionary+Category.h"
#import "NSString+Category.h"
#import "NSURL+Category.h"
#import "UIColor+Category.h"
#import "UIImage+Category.h"
#import "UIImageView+Category.h"
#import "UIView+InnerShadow.h"
#import "UIView+Positioning.h"
#import "UIView+Size.h"


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

#pragma mark - Debug log macro
#ifdef DEBUG

#define DDLOG(...) NSLog(__VA_ARGS__)
#define DDLOG_CURRENT_METHOD NSLog(@"%@-%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd))

#else

#define DDLOG(...) ;
#define DDLOG_CURRENT_METHOD ;

#endif

// 生产环境标识
#define COMMON_RUNFOR_DISTRIBUTION    0

// DEBUG开关
#ifndef __OPTIMIZE__
#define COMMON_DEBUG    1
#endif

// Log写入文件标识
#if (COMMON_DEBUG)
#define COMMON_LOGINFILE 0
#endif

#if (__OPTIMIZE__ ) //(__OPTIMIZE__ && (COMMON_RUNFOR_DISTRIBUTION == 0))
#define COMMON_DEBUG    0
#define COMMON_LOGINFILE 0
#endif


#pragma mark - UI macro

#define UI_NAVIGATION_BAR_HEIGHT        44
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
#define DEFAULT_DELAY_TIME (0.25)

void DummyLog(NSString *format, ...);
void SetLogFile(NSString *fileName);
void DeleteLogFile(NSString *fileName);

float getScreenWidth(void);
float getScreenHeight(void);

NSString *getAppStringVersion(void);
NSString *getAppBuildStringVersion(void);

