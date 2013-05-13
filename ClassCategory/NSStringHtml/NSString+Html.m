//
//  NSString+Html.m
//  NSString
//
//  Created by DJ on 12-9-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSString+Html.h"
#import <Foundation/NSObjCRuntime.h>
#import "RegexKitLite.h"

@implementation NSString (url)

+ (NSString *) stringWithBaseurl:(NSString *)baseurl path:(NSString *)path queryParameters:(NSDictionary *)params
{
    NSMutableString *str = [NSMutableString stringWithCapacity:0];
	if (path) {
		[str appendString:path];
	}
    
    if (params) {
        NSUInteger i;
        NSArray *names = [params allKeys];
        for (i = 0; i < [names count]; i++) {
            if (i == 0) {
                [str appendString:@"?"];
            } else if (i > 0) {
                [str appendString:@"&"];
            }
            NSString *name = [names objectAtIndex:i];
			NSString *value =[params objectForKey:name];
            //NSLog(@"name:%@, value:%@",name,value);
            [str appendString:[NSString stringWithFormat:@"%@=%@", 
							   name, [value URLEncodedString]]];
        }
    }
    
    return [NSString stringWithFormat:@"%@/%@", baseurl, str];
}

- (NSString *) URLEncodedString
{
	NSString *result =
        (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                     NULL,
                                                                     (__bridge CFStringRef)self,
                                                                     NULL,
                                                                     (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                     kCFStringEncodingUTF8 );
#if __has_feature(objc_arc)
    return result;
#else
    return [result autorelease];
#endif
}

- (NSString *) URLDecodedString
{
    NSString *result =
        (__bridge NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                                                                                     kCFAllocatorDefault,
                                                                                     (__bridge CFStringRef)self,
                                                                                     CFSTR(""),
                                                                                     kCFStringEncodingUTF8);
        
#if __has_feature(objc_arc)
    return result;
#else
    return [result autorelease];
#endif
}


- (NSString *) encodeAsURIComponent
{
	const char *p = [self UTF8String];
	NSMutableString* result = [NSMutableString string];
	
	for (;*p ;p++)
    {
		unsigned char c = *p;
		if (('0' <= c && c <= '9') || ('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z') || c == '-' || c == '_')
        {
			[result appendFormat:@"%c", c];
		}
        else
        {
			[result appendFormat:@"%%%02X", c];
		}
	}
    
	return result;
}

@end


@implementation NSString (html)

+ (NSString *)transFormString:(NSString *)originalStr
{
    NSString *str = [originalStr transToHtml];
    
    return str;
}

- (NSString *)transToHtml
{
    return [self transToHtmlWith:NSstringCheckHTML_DefaultType];
}

- (NSString *)transToHtmlWith:(int)checkingType
{
    NSString *str = [self stringByReplacingOccurrencesOfString :@"\r\n" withString:@"<br>"];
    str = [str stringByReplacingOccurrencesOfString :@"\r" withString:@"<br>"];
    
    NSMutableString *mutableContent = [NSMutableString stringWithFormat:@"%@", str];
    
    // 链接处理
    if (checkingType & NSStringCheckingHtmlTypeHttp)
    {
        [mutableContent replaceOccurrencesOfRegex:NSSTRINGCHECKINGHTML_LINK_MATCH_STRING withString:NSSTRINGCHECKINGHTML_LINK_REPLACE_STRING];
    }
    // @符号处理
    if (checkingType & NSStringCheckingHtmlTypeUser)
    {
        [mutableContent replaceOccurrencesOfRegex:NSSTRINGCHECKINGHTML_USER_MATCH_STRING withString:NSSTRINGCHECKINGHTML_USER_REPLACE_STRING];
    }
    // #...#数据处理
    if (checkingType & NSStringCheckingHtmlTypeTopic)
    {
        [mutableContent replaceOccurrencesOfRegex:NSSTRINGCHECKINGHTML_WEIBOTOPIC_MATCH_STRING withString:NSSTRINGCHECKINGHTML_WEIBOTOPIC_REPLACE_STRING];
    }
    
    // 表情处理开始
    if (checkingType & NSStringCheckingHtmlTypeEmoji)
    {
        NSString *emotDir = [NSString stringWithFormat:@"%@/emoji",[[NSBundle mainBundle] resourcePath]];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSArray *array_emoji = [mutableContent componentsMatchedByRegex:NSSTRINGCHECKINGHTML_EMOTIONS_MATCH_STRING];
        for(NSString *match in array_emoji)
        {
            BOOL bfind = NO;
            NSString *emotName = [[match stringByReplacingOccurrencesOfString:@"[" withString:@""] stringByReplacingOccurrencesOfString:@"]" withString:@""];
            NSString *path = [emotDir stringByAppendingPathComponent:emotName];        
            NSString *imagepath = [path stringByAppendingString:@".png"];
            
            if ([fileManager fileExistsAtPath:imagepath])
            {
                bfind = YES;
            }
            else
            {
                imagepath = [path stringByAppendingString:@".jpg"];
                if ([fileManager fileExistsAtPath:imagepath])
                {
                    bfind = YES;
                }
                else
                {
                    imagepath = [path stringByAppendingString:@".gif"];
                    if ([fileManager fileExistsAtPath:imagepath])
                    {
                        bfind = YES;
                    }
                }
            }
            
            if (bfind)
            {
                [mutableContent replaceOccurrencesOfRegex:[NSString stringWithFormat:@"\\[%@\\]", emotName] withString:[NSString stringWithFormat:@"<img src=\"file://%@\" />", imagepath]];
            }
        }
    }
    // 表情处理结束
    
    //返回转义后的字符串
    return mutableContent;
}

@end
