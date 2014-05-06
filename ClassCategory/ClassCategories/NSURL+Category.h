//
//  NSURL+Category.h
//  NSURL
//
//  Created by DJ on 12-9-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


/*!
 * Provides some additional functionality when working with \c NSURL objects.
 */
@interface NSURL (Category)

/**
 * @brief The length of the URL.
 *
 * @return The length (number of characters) of the absolute URL.
 */
@property (readonly, nonatomic) NSUInteger length;

/*!
 * @brief Returns the argument for the specified key in the query string component of
 * the URL.
 *
 * The search is case-sensitive, and the caller is responsible for removing any
 * percent escapes, as well as "+" escapes, too.
 *
 * @param key The key whose value should be located and returned.
 * @return The argument for the specified key, or \c nil if the key could not
 *   be found in the query string.
 */
- (NSString *)queryArgumentForKey:(NSString *)key;
- (NSString *)queryArgumentForKey:(NSString *)key withDelimiter:(NSString *)delimiter;

/*!
 Decode URL string.
 
 @param s String to decode
 @result Decoded URL string
 */
+ (NSString *)decode:(NSString *)s;
/*!
 Encode URL string.
 
 "~!@#$%^&*(){}[]=:/,;?+'\"\\" => ~!@#$%25%5E&*()%7B%7D%5B%5D=:/,;?+'%22%5C
 
 Doesn't encode: ~!@#$&*()=:/,;?+'
 
 Does encode: %^{}[]"\
 
 Should be the same as javascript's encodeURI().
 See http://xkr.us/articles/javascript/encode-compare/
 
 @param s String to escape
 @result Encode string
 */
+ (NSString *)encode:(NSString *)s;

/*!
 Encode URL string (for escaping URL key/value params).
 
 "~!@#$%^&*(){}[]=:/,;?+'\"\\" => ~!%40%23%24%25%5E%26*()%7B%7D%5B%5D%3D%3A%2F%2C%3B%3F%2B'%22%5C
 
 Doesn't encode: ~!*()'
 
 Does encode: @#$%^&{}[]=:/,;?+"\
 
 Should be the same as javascript's encodeURIComponent().
 See http://xkr.us/articles/javascript/encode-compare/
 
 @param s String to encode
 @result Encoded string
 */
+ (NSString *)encodeComponent:(NSString *)s;

/*!
 Encode URL string.
 
 Encodes: @#$%^&{}[]=:/,;?+"\~!*()'
 
 @param s String to encode
 @result Encoded string
 */
+ (NSString *)escapeAll:(NSString *)s;


- (NSMutableURLRequest *)addHTTPRequestHeaderInfo;


- (BOOL) isEqualToURL:(NSURL*)otherURL;

@end
