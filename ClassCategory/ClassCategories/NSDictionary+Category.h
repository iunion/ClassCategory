
#import <Foundation/Foundation.h>

@interface NSDictionary (Category)

- (long long)longForKey:(NSString *)key;
- (NSInteger)intForKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key;
- (float)floatForKey:(NSString *)key;
- (double)doubleForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key defaultString:(NSString *)defaultString;

- (CGPoint)pointForKey:(NSString *)key;
- (CGSize)sizeForKey:(NSString *)key;
- (CGRect)rectForKey:(NSString *)key;

- (NSArray *)arrayForKey:(NSString *)key;
- (NSDictionary *)dictionaryForKey:(NSString *)key;

- (BOOL)containsObjectForKey:(id)key;

@end

@interface NSDictionary (DeepMutableCopy)

- (NSMutableDictionary *)deepMutableCopy;

@end

@interface NSMutableDictionary (bbCategory)

- (void)setInt:(NSInteger)value forKey:(NSString *)key;
- (void)setBool:(BOOL)value forKey:(NSString *)key;
- (void)setFloat:(float)value forKey:(NSString *)key;
- (void)setDouble:(double)value forKey:(NSString *)key;
- (void)setString:(NSString *)value forKey:(NSString *)key;

- (void)setPoint:(CGPoint)value forKey:(NSString *)key;
- (void)setSize:(CGSize)value forKey:(NSString *)key;
- (void)setRect:(CGRect)value forKey:(NSString *)key;

@end
