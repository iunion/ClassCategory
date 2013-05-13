//
//  NSData+Category.m
//  wiIos
//
//  Created by qq on 12-6-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSData+Category.h"
#import "ARCHelper.h"

static NSMutableArray *g_CRC_Tables;

@implementation NSData (wiCRC)

+ (void)initCRCTables
{
    static BOOL hadInitCRCTables = NO;
    
    if (hadInitCRCTables)
    {
        return;
    }
    
    hadInitCRCTables = YES;
    
    g_CRC_Tables = [[NSMutableArray alloc] initWithCapacity:256];
    
    long ploy = 0xEDB88320;
    long crc;
    
    for (int i = 0; i <= 255; i ++)
    {
        crc = i;
        for (int j = 8; j >= 1; j --)
        {
            if ((crc &1) == 1)
            {
                crc = (crc >>1) ^ ploy;
            }
            else
            {
                crc = (crc >>1);
            }
        }
        [g_CRC_Tables addObject:[NSNumber numberWithLong: crc]];
    }
}

+ (long)getFileCRC:(NSString *)path
{
    long crc = 0xFFFFFFFF;
    
    [NSData initCRCTables];
    
    //创建文件管理器
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if (![fm fileExistsAtPath: path])
    {
        NSLog(@"文件不存在");
        return 0;
    }
    
    //得到文件大小
    NSError *error = nil;
    NSDictionary* dictFile = [fm attributesOfItemAtPath:path error:&error];
    if (error)
    {
        NSLog(@"GetFileSize error: %@", error);
        //break;
        return 0;
    }
    int len = [dictFile fileSize];
    //NSLog(@"file size=%d", nFileSize);
    
    NSFileHandle *inFile;    
    inFile = [NSFileHandle fileHandleForReadingAtPath:path];
    if (inFile == nil)
    {
        NSLog(@"open file for reading failed");
        return 0;
    }
    
    //设置当前偏移量
    [inFile seekToFileOffset:0];
    
    int bufferSize;
    int j;
    
    while (YES)
    {
        if (len <= 0)  break;
        if (len >= 10240) 
            bufferSize = 10240;
        else
            bufferSize = len;
        
        NSData *data = [inFile readDataOfLength: bufferSize];
        Byte *byteData = (Byte *)[data bytes];
        
        j = 0;
        while (j < bufferSize)
        {
            int iIndex = (crc ^ byteData[j]) & 0xFF;
            NSNumber *num = [g_CRC_Tables objectAtIndex:iIndex];
            crc = ((crc >> 8) & 0xFFFFFF) ^ [num unsignedLongValue];
            j++;
        }
        len -= bufferSize;
    }
    
    [inFile closeFile];
    
    NSLog(@"result = %lu", crc ^ 0xFFFFFFFF);
    
    return (crc ^ 0xFFFFFFFF);
}

- (long)getDataCRC
{
    long crc = 0xFFFFFFFF;
    
    [NSData initCRCTables];
    
    int bufferSize;
    int j;
    
    bufferSize = self.length;
    Byte *byteData = (Byte *)[self bytes];
    
    j = 0;
    
    while (j < bufferSize)
    {
        int iIndex = (crc ^ byteData[j]) & 0xFF;
        NSNumber *num = [g_CRC_Tables objectAtIndex:iIndex];
        crc = ((crc >> 8) & 0xFFFFFF) ^ [num unsignedLongValue];
        j++;
    }
    
    NSLog(@"result = %lu", crc ^ 0xFFFFFFFF);
    
    return (crc ^ 0xFFFFFFFF);
}


- (void)printWithType:(NSInteger)type
{
    int length = [self length];
	unsigned char aBuffer[length];
    
	[self getBytes:aBuffer length:length];
    
    NSString *formatStr = @"";
    for (int i=0; i<length; i++)
    {
        int num = aBuffer[i];
        if (type == 0)
        {
            formatStr = [formatStr stringByAppendingString:[NSString stringWithFormat:@"%02X ", num]];
        }
        else
        {
            formatStr = [formatStr stringByAppendingString:[NSString stringWithFormat:@"%d ", num]];
        }
    }
    
    NSLog(@"%@", formatStr);
}

@end



static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation NSData (Base64)

+ (id)dataWithBase64EncodedString:(NSString *)string;
{
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:nil];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL) // Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX) // Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1) // At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        // Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

- (NSString *)base64Encoding;
{
    if ([self length] == 0)
        return @"";
    
    char *characters = malloc((([self length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [self length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [self length])
            buffer[bufferLength++] = ((char *)[self bytes])[i++];
        
        // Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';	
    }
    
    return [[[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES] ah_autorelease];
}

@end

@implementation NSData (Category)
- (NSInteger)getImageType
{
    NSInteger Result = 0;
/*
    NSInteger head;

     if ([image length] <= 2)
    {
        return SDImageType_NONE;
    }
    
    [self getBytes:&head range:NSMakeRange(0, 2)];

    head = head & 0x0000FFFF;
    //NSLog(@"%d, %x", head, head);
    switch (head)
    {
        case 0x4D42:
            Result = SDImageType_BMP;
            break;

        case 0xD8FF:
            Result = SDImageType_JPEG;
            break;

        case 0x4947:
            Result = SDImageType_GIF;
            break;

        case 0x050A:
            Result = SDImageType_PCX;
            break;

        case 0x5089:
            Result = SDImageType_PNG;
            break;

        case 0x4238:
            Result = SDImageType_PSD;
            break;

        case 0xA659:
            Result = SDImageType_RAS;
            break;

        case 0xDA01:
            Result = SDImageType_SGI;
            break;

        case 0x4949:
            Result = SDImageType_TIFF;
            break;

        default:
            Result = SDImageType_NONE;
            break;
    }
*/    
    return Result;
}

- (BOOL)isGIF
{
    BOOL isGIF = NO;
    
    uint8_t c;
    [self getBytes:&c length:1];
    
    switch (c)
    {
        case 0x47:  // probably a GIF
            isGIF = YES;
            break;
            
        default:
            break;
    }
    
    return isGIF;
}
@end

