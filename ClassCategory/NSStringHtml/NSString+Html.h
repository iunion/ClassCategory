//
//  NSString+Html.h
//  NSString
//
//  Created by DJ on 12-9-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define NSSTRINGCHECKINGHTML_LINK_MATCH_STRING          @"(http://o1.cn/[a-zA-Z0-9]+)"
#define NSSTRINGCHECKINGHTML_LINK_MATCH_STRING          @"(http://o1.cn/[a-zA-Z0-9]+/[a-zA-Z0-9]+)"
#define NSSTRINGCHECKINGHTML_LINK_REPLACE_STRING        @"<a href=\"$1\" target=\"_blank\">$1</a>"

#define NSSTRINGCHECKINGHTML_USER_MATCH_STRING          @"(@)([\\x{4e00}-\\x{9fa5}A-Za-z0-9_\\-]+)"
#define NSSTRINGCHECKINGHTML_USER_REPLACE_STRING        @"<a href='wixun://user?username=$2'>$1$2</a> "

#define NSSTRINGCHECKINGHTML_WEIBOTOPIC_MATCH_STRING    @"#(.+?)#"
#define NSSTRINGCHECKINGHTML_WEIBOTOPIC_REPLACE_STRING  @"<a href=\"http://weibo.com/k/$1\" target=\"_blank\">#$1#</a>"

#define NSSTRINGCHECKINGHTML_EMOTIONS_MATCH_STRING      @"\\[(.+?)\\]"

enum {
    NSStringCheckingHtmlTypeHttp            = 1ULL << 0,        // http连接
    NSStringCheckingHtmlTypeUser            = 1ULL << 1,        // @用户
    NSStringCheckingHtmlTypeEmoji           = 1ULL << 2,        // [表情]
    NSStringCheckingHtmlTypeTopic           = 1ULL << 3,        // #微博话题#
};
typedef int NSStringCheckingHtmlType;

#define NSstringCheckHTML_DefaultType (NSStringCheckingHtmlTypeHttp | NSStringCheckingHtmlTypeUser | NSStringCheckingHtmlTypeEmoji)

@interface NSString (url)

+ (NSString *) stringWithBaseurl:(NSString *)baseurl path:(NSString *)path queryParameters:(NSDictionary *)params;

- (NSString *) URLEncodedString;
- (NSString *) encodeAsURIComponent;
- (NSString *) URLDecodedString;

@end


@interface NSString (html)

+ (NSString *)transFormString:(NSString *)originalStr;

- (NSString *)transToHtml;
- (NSString *)transToHtmlWith:(int)checkingType;

@end
