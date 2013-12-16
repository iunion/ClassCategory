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

- (NSString *)trim;
- (NSString *)trimSpace;

+ (NSString *)getCGFormattedFileSize:(long long)size;

// 过滤头像Url
- (NSString *)getValidHeadImageUrl;

// MD5
- (NSString *) md5HexDigest32;
- (NSString *) md5HexDigest16;

// 获取文件名
- (NSString *) getFileName;
// 获取路径
- (NSString *) getFilePath;

// 从bit转化为KB、MB、GB
+ (NSString *)storeString:(NSInteger)bsize;

/*!
 Path extension with . or "" as before.
 
 "spliff.tiff" => ".tiff"
 "spliff" => ""
 
 @result Full path extension with .
 */
- (NSString *) getFullFileExtension;
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
// 一个汉字当两个字符 长度的计算
- (int) lengthByUnicode;
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

- (NSString *)escapeHTML;

@end


/*!
 Utilities for URL encoding/decoding.
 */
@interface NSString (URL)

/*!
 Decode URL encoded string.
 @see NSURL#gh_decode:
 */
- (NSString *)URLDecode;

/*!
 Encode URL string.
 
 "~!@#$%^&*(){}[]=:/,;?+'\"\\" => ~!@#$%25%5E&*()%7B%7D%5B%5D=:/,;?+'%22%5C
 
 Doesn't encode: ~!@#$&*()=:/,;?+'
 
 Does encode: %^{}[]"\
 
 Should be the same as javascript's encodeURI().
 See http://xkr.us/articles/javascript/encode-compare/
 
 @see NSURL#gh_encode:
 */
- (NSString *)URLEncode;

/*!
 Encode URL string (for escaping URL key/value params).
 
 "~!@#$%^&*(){}[]=:/,;?+'\"\\" => ~!%40%23%24%25%5E%26*()%7B%7D%5B%5D%3D%3A%2F%2C%3B%3F%2B'%22%5C
 
 Doesn't encode: ~!*()'
 
 Does encode: @#$%^&{}[]=:/,;?+"\
 
 Should be the same as javascript's encodeURIComponent().
 See http://xkr.us/articles/javascript/encode-compare/
 
 @see NSURL#gh_encodeComponent
 */
- (NSString *)URLEncodeComponent;

/*!
 Encode URL string (all characters).
 
 Encodes: @#$%^&{}[]=:/,;?+"\~!*()'
 
 @see NSURL#gh_escapeAll
 */
- (NSString *)URLEscapeAll;


@end


@interface NSString (Emoji)

// 是否全是表情
- (BOOL)isAllEmojis;
- (BOOL)isAllEmojisAndSpace;

// 是否有表情
- (BOOL)isContainsEmojis;

// 是否表情，只对一个字符
- (BOOL)isEmoji;

- (NSArray *)disassembleEmojis;
- (NSString *)parameterEmojis;

@end


/**
 A collection of useful additions for `NSString` to deal with paths.
 */

@interface NSString (paths)

/**-------------------------------------------------------------------------------------
 @name Getting Standard Paths
 ---------------------------------------------------------------------------------------
 */

/** Determines the path to the Library/Caches folder in the current application's sandbox.
 
 The return value is cached on the first call.
 
 @return The path to the app's Caches folder.
 */
+ (NSString *)cachesPath;


/** Determines the path to the Documents folder in the current application's sandbox.
 
 The return value is cached on the first call.
 
 @return The path to the app's Documents folder.
 */
+ (NSString *)documentsPath;

+ (NSString *)libraryPath;
+ (NSString *)bundlePath;

/**-------------------------------------------------------------------------------------
 @name Getting Temporary Paths
 ---------------------------------------------------------------------------------------
 */

/** Determines the path for temporary files in the current application's sandbox.
 
 The return value is cached on the first call. This value is different in Simulator than on the actual device. In Simulator you get a reference to /tmp wheras on iOS devices it is a special folder inside the application folder.
 
 @return The path to the app's folder for temporary files.
 */
+ (NSString *)temporaryPath;


/** Creates a unique filename that can be used for one temporary file or folder.
 
 The returned string is different on every call. It is created by combining the result from temporaryPath with a unique UUID.
 
 @return The generated temporary path.
 */
+ (NSString *)pathForTemporaryFile;


/**-------------------------------------------------------------------------------------
 @name Working with Paths
 ---------------------------------------------------------------------------------------
 */

/** Appends or Increments a sequence number in brackets
 
 If the receiver already has a number suffix then it is incremented. If not then (1) is added.
 
 @return The incremented path
 */
- (NSString *)pathByIncrementingSequenceNumber;


/** Removes a sequence number in brackets
 
 If the receiver number suffix then it is removed. If not the receiver is returned.
 
 @return The modified path
 */
- (NSString *)pathByDeletingSequenceNumber;


@end
