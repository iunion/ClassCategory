//
//  NSStringHelper.h
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

enum {
	NSTruncateStringPositionStart=0,
	NSTruncateStringPositionMiddle,
	NSTruncateStringPositionEnd
}; typedef NSInteger NSTruncateStringPosition;

@interface NSString (Helper)

/**
 * Determines if the string contains only whitespace and newlines.
 */
- (BOOL)isWhitespaceAndNewlines;

/**
 * Determines if the string is empty or contains only whitespace.
 */
- (BOOL)isEmptyOrWhitespace;

/*
 * Checks to see if the string contains the given string, case insenstive
 */
- (BOOL)containsString:(NSString *)string;

/*
 * Checks to see if the string contains the given string while allowing you to define the compare options
 */
- (BOOL)containsString:(NSString *)string options:(NSStringCompareOptions)options;

/*
 * Returns the long value of the string
 */
- (long)longValue;
- (long long)longLongValue;
- (unsigned long long)unsignedLongLongValue;

/*
 * Truncate string to length
 */
- (NSString *)stringByTruncatingToLength:(NSInteger)length;
- (NSString *)stringByTruncatingToLength:(NSInteger)length direction:(NSTruncateStringPosition)truncateFrom;
- (NSString *)stringByTruncatingToLength:(NSInteger)length direction:(NSTruncateStringPosition)truncateFrom withEllipsisString:(NSString *)ellipsis;

// added by PS
- (NSString *)stringByReplacingString:(NSString *)searchString withString:(NSString *)newString;


@end
