//
//  NSStringHelper.m
//  CocoaHelpers
//
//  Created by Shaun Harrison on 10/14/08.
//  Copyright (c) 2008-2009 enormego
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "NSStringHelper.h"
#import <CommonCrypto/CommonDigest.h>
#import "ARCHelper.h"

NSInteger const GGCharacterIsNotADigit = 10;

@implementation NSString (Helper)


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isWhitespaceAndNewlines {
    NSCharacterSet* whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![whitespace characterIsMember:c]) {
            return NO;
        }
    }
    return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isEmptyOrWhitespace {
    return !self.length ||
    ![self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length;
}


- (BOOL)containsString:(NSString *)string {
	return [self containsString:string options:NSCaseInsensitiveSearch];
}

- (BOOL)containsString:(NSString *)string options:(NSStringCompareOptions)options {
	return [self rangeOfString:string options:options].location == NSNotFound ? NO : YES;
}

#pragma mark -
#pragma mark Long conversions

- (long)longValue {
	return (long)[self longLongValue];
}

- (long long)longLongValue {
	NSScanner* scanner = [NSScanner scannerWithString:self];
	long long valueToGet;
	if([scanner scanLongLong:&valueToGet] == YES) {
		return valueToGet;
	} else {
		return 0;
	}
}

/*
 * Contact info@enormego.com if you're the author and we'll update this comment to reflect credit
 */

- (unsigned)digitValue:(unichar)c {

	if ((c>47)&&(c<58)) {
        return (c-48);
	}

	return GGCharacterIsNotADigit;
}

- (unsigned long long)unsignedLongLongValue {
	NSUInteger n = [self length];
	unsigned long long v,a;
	unsigned small_a, j;

	v=0;
	for (j=0;j<n;j++) {
		unichar c=[self characterAtIndex:j];
		small_a=[self digitValue:c];
		if (small_a==GGCharacterIsNotADigit) continue;
		a=(unsigned long long)small_a;
		v=(10*v)+a;
	}

	return v;

}


#pragma mark -
#pragma mark Truncation

/*
 * Contact info@enormego.com if you're the author and we'll update this comment to reflect credit
 */

- (NSString *)stringByTruncatingToLength:(NSInteger)length {
	return [self stringByTruncatingToLength:length direction:NSTruncateStringPositionEnd];
}

- (NSString *)stringByTruncatingToLength:(NSInteger)length direction:(NSTruncateStringPosition)truncateFrom {
	return [self stringByTruncatingToLength:length direction:truncateFrom withEllipsisString:@"..."];
}

- (NSString *)stringByTruncatingToLength:(NSInteger)length direction:(NSTruncateStringPosition)truncateFrom withEllipsisString:(NSString *)ellipsis {
	NSMutableString *result = [[NSMutableString alloc] initWithString:self];
	NSString *immutableResult;

	if([result length] <= length) {
		[result ah_release];
		return self;
	}

	NSUInteger charactersEachSide = length / 2;

	NSString * first;
	NSString * last;

	switch(truncateFrom) {
		case NSTruncateStringPositionStart:
			[result insertString:ellipsis atIndex:[result length] - length + [ellipsis length] ];
			immutableResult = [result substringFromIndex:[result length] - length];
			[result ah_release];
			return immutableResult;
            
		case NSTruncateStringPositionMiddle:
			first = [result substringToIndex:charactersEachSide - [ellipsis length]+1];
			last = [result substringFromIndex:[result length] - charactersEachSide];
			immutableResult = [[NSArray arrayWithObjects:first, last, NULL] componentsJoinedByString:ellipsis];
			[result ah_release];
			return immutableResult;
            
		default:
		case NSTruncateStringPositionEnd:
			[result insertString:ellipsis atIndex:length - [ellipsis length]];
			immutableResult = [result substringToIndex:length];
			[result ah_release];
			return immutableResult;
	}
}


// replaces string with new string, returns new var
- (NSString *)stringByReplacingString:(NSString *)searchString withString:(NSString *)newString {
    NSMutableString *mutable = [NSMutableString stringWithString:self];
    [mutable replaceOccurrencesOfString:searchString withString:newString options:NSCaseInsensitiveSearch range:NSMakeRange(0, [self length])];
    return [NSString stringWithString:mutable];
}


@end
