//
//  NSData+Category.h
//  wiIos
//
//  Created by qq on 12-6-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (wiCRC)

+ (long)getFileCRC:(NSString *)path;
- (long)getDataCRC;

- (void)printWithType:(NSInteger)type;

@end

@interface NSData (Base64)

+ (id)dataWithBase64EncodedString:(NSString *)string; // Padding '=' characters are optional. Whitespace is ignored.
- (NSString *)base64Encoding;

@end