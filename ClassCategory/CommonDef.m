//
//  wiAppDelegate.m
//  wiIos
//
//  Created by xuanwenchao on 11-12-22.
//  Copyright (c) 2011年 Waptech (Beijing) Information Technologies, Ltd. All rights reserved.
//
#import "CommonDef.h"


void DummyLog(NSString *format, ...)
{

}

NSString *getDocumentsDirectoryWithFileName(NSString *fileName)
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

void SetLogFile(NSString *fileName)
{
    NSString *outputFile = getDocumentsDirectoryWithFileName(fileName);
    const char *pp = [outputFile fileSystemRepresentation];
    freopen(pp , "a", stderr);
}

void DeleteLogFile(NSString *fileName)
{
    NSError *error;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *outputFile = getDocumentsDirectoryWithFileName(fileName);
    
    [fileMgr removeItemAtPath:outputFile error:&error];
}

float getScreenWidth(void)
{
    return [[UIScreen mainScreen] applicationFrame].size.width;
}

float getScreenHeight(void)
{
    return [[UIScreen mainScreen] applicationFrame].size.height;
}

// 获取版本号
NSString *getAppStringVersion(void)
{
    NSString *versionStr = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    return versionStr;
}

NSString *getAppBuildStringVersion(void)
{
    NSString *versionStr = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    return versionStr;
}

BOOL stringIsEmpty(NSString *str)
{
    //  || [str isEqualToString:@"(null)"]
    if (str == nil || str.length == 0 || [str isEqualToString:@""])
    {
        return YES;
    }
    
    return NO;
}

