//
//  wiNSString+MD5HexDigest.h
//  wiIos
//
//  Created by qq on 12-1-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>

@interface NSString (wiCategory)
// 删除空白字符
+ (NSString *) stringTrim:(NSString *)str;
+ (NSString *) stringTrimEnd:(NSString *)str;
+ (NSString *) stringTrimStart:(NSString *)str;
+ (NSString *) string:(NSString *)str appendRandom:(NSInteger)ram;

+ (NSString *)getCGFormattedFileSize:(long long)size;


// MD5
- (NSString *) md5HexDigest32;
- (NSString *) md5HexDigest16;

// 获取文件名
- (NSString *) getFileName;
// 获取路径
- (NSString *) getFilePath;
// 图片完整地址
//- (NSString *) getLogoImageName:(NSString *)addStr;
//- (NSString *) getContentPreViewImageName;
//- (NSString *) getContentArtworkImageName;

// 判断Email
- (BOOL) isEmail;
// 校验用户密码  
- (BOOL) isUserPasswd;
// 校验验证码  
- (BOOL) isVerifyCode;
// 校验手机号
- (BOOL) isPhoneNum;

// 编码
+ (NSString *) encodeDES:(NSString*)plainText key:(NSString*)key;
// 解码
+ (NSString *) decodeDES:(NSString*)plainText key:(NSString*)key;


//判断是否为整形
- (BOOL) isPureInt;
//判断是否为浮点形
- (BOOL) isPureFloat;

//解析文本，根据文本信息分析出哪些是表情，哪些是文字
-(void) getImageRange:(NSMutableArray *)array;


- (NSString *)changeToUnicode6String;
- (NSString *)changeToSoftBankString;

- (BOOL)isVideoNotMp4;

// 检查链接
- (NSTextCheckingResult*)checkLinkWithType:(NSTextCheckingTypes)type;
// 返回链接URL结果
- (NSURL*)extendedURLWithType:(NSTextCheckingTypes)type;

- (NSArray *)computeLinksWithType:(NSTextCheckingTypes)type;

@end
