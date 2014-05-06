//
//  NSData+Category.h
//
//
//  Created by qq on 12-6-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (CRC)

+ (long)getFileCRC:(NSString *)path;
- (long)getCRC;

- (void)logWithType:(NSInteger)type;

@end


@interface NSData (Base64)

+ (id)dataWithBase64EncodedString:(NSString *)string; // Padding '=' characters are optional. Whitespace is ignored.
- (NSString *)base64Encoding;

@end


@interface NSData (Category)

- (NSInteger)getImageType;

@end


@interface NSData (RSHexDump)

- (NSString *)description;

// startOffset may be negative, indicating offset from end of data
- (NSString *)descriptionFromOffset:(NSInteger)startOffset;
- (NSString *)descriptionFromOffset:(NSInteger)startOffset limitingToByteCount:(NSUInteger)maxBytes;

@end
