#import "NSDictionary+Category.h"
#import "ARCHelper.h"

@implementation NSDictionary (wiCategory)

- (long long)longForKey:(NSString *)key
{
    long long value = 0;
    
    id object = [self objectForKey:key];
    if ([object isValided] && ([object isKindOfClass:[NSValue class]] || [object isKindOfClass:[NSString class]]))
    {
        value = [object longLongValue];
    }
    
    return value;
}

- (NSInteger)intForKey:(NSString *)key
{
    NSInteger value = 0;
    
    id object = [self objectForKey:key];
    if ([object isValided] && ([object isKindOfClass:[NSValue class]] || [object isKindOfClass:[NSString class]]))
    {
        value = [object integerValue];
    }
    
    return value;
}

- (BOOL)boolForKey:(NSString *)key
{
    BOOL value = NO;
    
    id object = [self objectForKey:key];
    if ([object isValided] && ([object isKindOfClass:[NSValue class]] || [object isKindOfClass:[NSString class]]))
    {
        value = [object boolValue];
    }
    
    return value;
}

- (float)floatForKey:(NSString *)key
{
    float value = 0.0f;
    
    id object = [self objectForKey:key];
    if ([object isValided] && ([object isKindOfClass:[NSValue class]] || [object isKindOfClass:[NSString class]]))
    {
        value = [object floatValue];
    }
    
    return value;
}

- (double)doubleForKey:(NSString *)key
{
    double value = 0.0f;
    
    id object = [self objectForKey:key];
    if ([object isValided] && ([object isKindOfClass:[NSValue class]] || [object isKindOfClass:[NSString class]]))
    {
        value = [object doubleValue];
    }
    
    return value;
}

- (NSString *)stringForKey:(NSString *)key
{
    NSString *value = nil;
    
    id object = [self objectForKey:key];
    if ([object isValided] && [object isKindOfClass:[NSString class]])
    {
        value = object;
    }
    else if([object isValided] && [object isKindOfClass:[NSNumber class]])
    {
        value = [object stringValue];
    }
    
    return value;
}

- (NSString *)stringForKey:(NSString *)key defaultString:(NSString *)defaultString
{
    NSString *value = [self stringForKey:key];
    
    if (!value)
    {
        return defaultString;
    }
    
    return value;
}

- (CGPoint)pointForKey:(NSString *)key
{
    CGPoint point = CGPointZero;
    NSDictionary *dictionary = [self valueForKey:key];
    
    if ([dictionary isValided] && [dictionary isKindOfClass:[NSDictionary class]])
    {
        BOOL success = CGPointMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)dictionary, &point);
        if (success)
            return point;
        else
            return CGPointZero;
    }
    
    return CGPointZero;
}

- (CGSize)sizeForKey:(NSString *)key
{
  CGSize size = CGSizeZero;
  NSDictionary *dictionary = [self valueForKey:key];
    
    if ([dictionary isValided] && [dictionary isKindOfClass:[NSDictionary class]])
    {
  BOOL success = CGSizeMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)dictionary, &size);
        if (success)
            return size;
        else 
            return CGSizeZero;
    }
    
    return CGSizeZero;
}

- (CGRect)rectForKey:(NSString *)key
{
    CGRect rect = CGRectZero;
    NSDictionary *dictionary = [self valueForKey:key];
    
    if ([dictionary isValided] && [dictionary isKindOfClass:[NSDictionary class]])
    {
        BOOL success = CGRectMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)dictionary, &rect);
        if (success)
            return rect;
        else
            return CGRectZero;
    }
    
    return CGRectZero;
}

- (NSArray *)arrayForKey:(NSString *)key
{
    NSArray *value = nil;
    
    id object = [self objectForKey:key];
    if ([object isValided] && [object isKindOfClass:[NSArray class]])
    {
        value = object;
    }
    
    return value;
}

- (NSDictionary *)dictionaryForKey:(NSString *)key
{
    NSDictionary *value = nil;
    
    id object = [self objectForKey:key];
    if ([object isValided] && [object isKindOfClass:[NSDictionary class]])
    {
        value = object;
    }
    
    return value;
}

- (BOOL)containsObjectForKey:(id)key
{
    return [[self allKeys] containsObject:key];
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
            [anObject ah_release];
        } else if ([anObject respondsToSelector:@selector(mutableCopyWithZone:)]) {
            anObject = [anObject mutableCopyWithZone:nil];
            [newDictionary setObject:anObject forKey:aKey];
            [anObject ah_release];
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
    CFDictionaryRef dictionary = CGPointCreateDictionaryRepresentation(value);
    NSDictionary *pointDict = [NSDictionary dictionaryWithDictionary:
                               (__bridge NSDictionary *)dictionary]; // autoreleased
    CFRelease(dictionary);
    
    [self setValue:pointDict forKey:key];
}

- (void)setSize:(CGSize)value forKey:(NSString *)key
{
    CFDictionaryRef dictionary = CGSizeCreateDictionaryRepresentation(value);
    NSDictionary *sizeDict = [NSDictionary dictionaryWithDictionary:
                               (__bridge NSDictionary *)dictionary]; // autoreleased
    CFRelease(dictionary);
    
    [self setValue:sizeDict forKey:key];
}

- (void)setRect:(CGRect)value forKey:(NSString *)key
{
    CFDictionaryRef dictionary = CGRectCreateDictionaryRepresentation(value);
    NSDictionary *rectDict = [NSDictionary dictionaryWithDictionary:
                              (__bridge NSDictionary *)dictionary]; // autoreleased
    CFRelease(dictionary);
    
    [self setValue:rectDict forKey:key];
}

@end
