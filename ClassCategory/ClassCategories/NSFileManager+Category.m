//
//  GHNSFileManager+Utils.m
//
//  Created by Gabe on 3/23/08.
//  Copyright 2008 Gabriel Handford
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "NSFileManager+Category.h"
#import "NSString+Category.h"


@implementation NSFileManager (Category)

+ (NSNumber *)fileSize:(NSString *)filePath error:(NSError **)error
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDir;
    if ([fileManager fileExistsAtPath:filePath isDirectory:&isDir] && !isDir) {
        NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:filePath error:error];
        if (fileAttributes)
            return [fileAttributes objectForKey:NSFileSize];
    }
    return nil;
}

+ (BOOL)isDirectory:(NSString *)filePath
{
    BOOL isDir;
    return ([[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDir] && isDir);
}

+ (BOOL)exist:(NSString *)filePath
{
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

+ (NSString *)temporaryFile:(NSString *)appendPath deleteIfExists:(BOOL)deleteIfExists error:(NSError **)error
{
    NSString *tmpFile = NSTemporaryDirectory();
    if (appendPath) tmpFile = [tmpFile stringByAppendingPathComponent:appendPath];
    if (deleteIfExists && [self exist:tmpFile])
    {
        [[NSFileManager defaultManager] removeItemAtPath:tmpFile error:error];
    }
    return tmpFile;
}

+ (BOOL)ensureDirectoryExists:(NSString *)directory created:(BOOL *)created error:(NSError **)error
{
    *created = NO;
    
	if (![self exist:directory])
    {
		BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:error];
		if (success && created) *created = YES;
		return success;
	}
    else if (![self isDirectory:directory])
    {
//		if (error) *error = [NSError gh_errorWithDomain:@"GHNSFileManager" code:-1 localizedDescription:@"Path exists but is not a directory"];
		return NO;
	}
    else
    {
		// Path existed and was a directory
		return YES;
	}
}

+ (NSString *)uniquePathWithNumber:(NSString *)path
{
    NSInteger index = 1;
    NSString *uniquePath = path;
    NSString *prefixPath = nil, *pathExtension = nil;
    
    while([self exist:uniquePath])
    {
        if (!prefixPath) prefixPath = [path stringByDeletingPathExtension];
        if (!pathExtension) pathExtension = [path getFullFileExtension];
        uniquePath = [NSString stringWithFormat:@"%@-%ld%@", prefixPath, (long)index, pathExtension];
        index++;
    }
    return uniquePath;
}

+ (NSString *)pathToResource:(NSString *)path
{
    if (!path) return nil;
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:path];
}


+ (NSString *) pathForItemNamed: (NSString *) fname inFolder: (NSString *) path
{
    NSString *file;
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:path];
    while ((file = [dirEnum nextObject]))
        if ([[file lastPathComponent] isEqualToString:fname])
            return [path stringByAppendingPathComponent:file];
    return nil;
}

+ (NSString *) pathForDocumentNamed: (NSString *) fname
{
    return [NSFileManager pathForItemNamed:fname inFolder:[NSString documentsPath]];
}

+ (NSString *) pathForBundleDocumentNamed: (NSString *) fname
{
    return [NSFileManager pathForItemNamed:fname inFolder:[NSString bundlePath]];
}

+ (NSArray *) filesInFolder: (NSString *) path
{
    NSString *file;
    NSMutableArray *results = [NSMutableArray array];
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:path];
    while ((file = [dirEnum nextObject]))
    {
        BOOL isDir;
        [[NSFileManager defaultManager] fileExistsAtPath:[path stringByAppendingPathComponent:file] isDirectory: &isDir];
        if (!isDir) [results addObject:file];
    }
    return results;
}

// Case insensitive compare, with deep enumeration
+ (NSArray *) pathsForItemsMatchingExtension: (NSString *) ext inFolder: (NSString *) path
{
    NSString *file;
    NSMutableArray *results = [NSMutableArray array];
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:path];
    while ((file = [dirEnum nextObject]))
        if ([[file pathExtension] caseInsensitiveCompare:ext] == NSOrderedSame)
            [results addObject:[path stringByAppendingPathComponent:file]];
    return results;
}

+ (NSArray *) pathsForDocumentsMatchingExtension: (NSString *) ext
{
    return [NSFileManager pathsForItemsMatchingExtension:ext inFolder:[NSString documentsPath]];
}

// Case insensitive compare
+ (NSArray *) pathsForBundleDocumentsMatchingExtension: (NSString *) ext
{
    return [NSFileManager pathsForItemsMatchingExtension:ext inFolder:[NSString bundlePath]];
}
@end
