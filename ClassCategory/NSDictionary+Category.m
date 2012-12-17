#import "NSDictionary+Category.h"
#import "ARCHelper.h"

@implementation NSDictionary (wiCategory)

- (NSInteger)intForKey:(NSString *)key
{
    NSInteger value = [[self objectForKey:key] intValue];
    
    return value;
}

- (BOOL)boolForKey:(NSString *)key
{
    BOOL value = [[self objectForKey:key] boolValue];
    
    return value;
}

- (float)floatForKey:(NSString *)key
{
    float value = [[self objectForKey:key] floatValue];
    
    return value;
}

- (NSString *)stringForKey:(NSString *)key
{
    NSString *value = [self objectForKey:key];
    
    return value;
}

- (CGPoint)pointForKey:(NSString *)key
{
  CGPoint point = CGPointZero;
  NSDictionary *dictionary = [self valueForKey:key];
  BOOL success = CGPointMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)dictionary, &point);
  if (success) return point;
  else return CGPointZero;
}

- (CGSize)sizeForKey:(NSString *)key
{
  CGSize size = CGSizeZero;
  NSDictionary *dictionary = [self valueForKey:key];
  BOOL success = CGSizeMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)dictionary, &size);
  if (success) return size;
  else return CGSizeZero;
}

- (CGRect)rectForKey:(NSString *)key
{
  CGRect rect = CGRectZero;
  NSDictionary *dictionary = [self valueForKey:key];
  BOOL success = CGRectMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)dictionary, &rect);
  if (success) return rect;
  else return CGRectZero;
}

@end


@implementation NSDictionary (DeepMutableCopy)


- (NSMutableDictionary *)deepMutableCopy;
{
    NSMutableDictionary *newDictionary;
    NSEnumerator *keyEnumerator;
    id anObject;
    id aKey;
	
    newDictionary = [self mutableCopy];
    // Run through the new dictionary and replace any objects that respond to -deepMutableCopy or -mutableCopy with copies.
    keyEnumerator = [[newDictionary allKeys] objectEnumerator];
    while ((aKey = [keyEnumerator nextObject])) {
        anObject = [newDictionary objectForKey:aKey];
        if ([anObject respondsToSelector:@selector(deepMutableCopy)]) {
            anObject = [anObject deepMutableCopy];
            [newDictionary setObject:anObject forKey:aKey];
            [anObject release];
        } else if ([anObject respondsToSelector:@selector(mutableCopyWithZone:)]) {
            anObject = [anObject mutableCopyWithZone:nil];
            [newDictionary setObject:anObject forKey:aKey];
            [anObject release];
        } else {
			[newDictionary setObject:anObject forKey:aKey];
		}
    }
	
    return newDictionary;
}

@end


@implementation NSMutableDictionary (wiCategory)

- (void)setInt:(NSInteger)value forKey:(NSString *)key
{
    NSNumber *number = [NSNumber numberWithInt:value];
    [self setObject:number forKey:key];    
}

- (void)setBool:(BOOL)value forKey:(NSString *)key
{
    NSNumber *number = [NSNumber numberWithBool:value];
    [self setObject:number forKey:key];    
}

- (void)setFloat:(float)value forKey:(NSString *)key
{
    NSNumber *number = [NSNumber numberWithFloat:value];
    [self setObject:number forKey:key];
}

- (void)setDouble:(double)value forKey:(NSString *)key
{
    NSNumber *number = [NSNumber numberWithDouble:value];
    [self setObject:number forKey:key];
}

- (void)setString:(NSString *)value forKey:(NSString *)key
{
    [self setObject:value forKey:key];
}

- (void)setPoint:(CGPoint)value forKey:(NSString *)key
{
  NSDictionary *dictionary = (__bridge NSDictionary *)CGPointCreateDictionaryRepresentation(value);
  [self setValue:dictionary forKey:key];
  [dictionary release]; dictionary = nil;
}

- (void)setSize:(CGSize)value forKey:(NSString *)key
{
  NSDictionary *dictionary = (__bridge NSDictionary *)CGSizeCreateDictionaryRepresentation(value);
  [self setValue:dictionary forKey:key];
  [dictionary release]; dictionary = nil;
}

- (void)setRect:(CGRect)value forKey:(NSString *)key
{
  NSDictionary *dictionary = (__bridge NSDictionary *)CGRectCreateDictionaryRepresentation(value);
  [self setValue:dictionary forKey:key];
  [dictionary release]; dictionary = nil;
}

@end
