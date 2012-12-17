//
//  NSURL+Category.h
//  NSURL
//
//  Created by DJ on 12-9-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSURL+Category.h"

@implementation NSURL (wiCategory)

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

@end
