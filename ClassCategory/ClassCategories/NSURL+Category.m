//
//  NSURL+Category.h
//  NSURL
//
//  Created by DJ on 12-9-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
// -fno-objc-arc

#import "NSURL+Category.h"

@implementation NSURL (Category)

- (NSUInteger)length
{
	return [[self absoluteString] length];
}

- (NSString *)queryArgumentForKey:(NSString *)key withDelimiter:(NSString *)delimiter
{
	for (NSString *obj in [[self query] componentsSeparatedByString:delimiter]) {
		NSArray *keyAndValue = [obj componentsSeparatedByString:@"="];
		
		if (([keyAndValue count] >= 2) && ([[keyAndValue objectAtIndex:0] caseInsensitiveCompare:key] == NSOrderedSame)) {
			return [keyAndValue objectAtIndex:1];
		}
	}
	
	return nil;
}

- (NSString *)queryArgumentForKey:(NSString *)key
{
	NSString		*delimiter;
	
	// The arguments in query strings can be delimited with a semicolon (';') or an ampersand ('&'). Since it's not
	// likely a single URL would use both types of delimeters, we'll attempt to pick one and use it.
	if ([[self query] rangeOfString:@";"].location != NSNotFound) {
		delimiter = @";";
	} else {
		// Assume '&' by default, since that's more common
		delimiter = @"&";
	}
	
	return [self queryArgumentForKey:key withDelimiter:delimiter];
}

+ (NSString *)decode:(NSString *)s
{
	if (!s) return nil;
	return [NSMakeCollectable(CFURLCreateStringByReplacingPercentEscapes(NULL, (CFStringRef)s, CFSTR(""))) autorelease];
}

+ (NSString *)encode:(NSString *)s
{
	// Characters to maybe leave unescaped? CFSTR("~!@#$&*()=:/,;?+'")
	return [NSMakeCollectable(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)s, CFSTR("#"), CFSTR("%^{}[]\"\\"), kCFStringEncodingUTF8)) autorelease];
}

+ (NSString *)encodeComponent:(NSString *)s
{
	// Characters to maybe leave unescaped? CFSTR("~!*()'")
    return [NSMakeCollectable(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)s, NULL, CFSTR("@#$%^&{}[]=:/,;?+\"\\"), kCFStringEncodingUTF8)) autorelease];
}

+ (NSString *)escapeAll:(NSString *)s
{
	// Characters to escape: @#$%^&{}[]=:/,;?+"\~!*()'
    return [NSMakeCollectable(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)s, NULL, CFSTR("@#$%^&{}[]=:/,;?+\"\\~!*()'"), kCFStringEncodingUTF8)) autorelease];
}

- (NSMutableURLRequest *)addHTTPRequestHeaderInfo
{
    if (!self)
    {
        return nil;
    }
    
    NSMutableURLRequest *mutableRequest = [[[NSMutableURLRequest alloc] initWithURL:self] autorelease];
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *versionNum = [infoDict stringForKey:@"CFBundleVersion"];
    NSString *appName = [infoDict stringForKey:@"CFBundleExecutable"];
    
    [mutableRequest addValue:appName forHTTPHeaderField:@"babytree-app-id"];
    [mutableRequest addValue:@"ios" forHTTPHeaderField:@"babytree-client-type"];
    [mutableRequest addValue:versionNum forHTTPHeaderField:@"babytree-app-version"];
    
    NSLog(@"%@", mutableRequest.allHTTPHeaderFields);
    
    return mutableRequest;
}


// http://vgable.com/blog/2009/04/22/nsurl-isequal-gotcha/
- (BOOL) isEqualToURL:(NSURL*)otherURL
{
	return [[self absoluteURL] isEqual:[otherURL absoluteURL]] ||
    ([self isFileURL] && [otherURL isFileURL] && [[self path] isEqual:[otherURL path]]);
}


@end
