//
//  NSArray+NSArray_Category.m
//  
//
//  Created by mac on 13-12-18.
//  Copyright (c) 2013年 babytree. All rights reserved.
//

#import "NSArray+Category.h"

@implementation NSArray (Category)

- (NSArray *)arrayBySortingStrings
{
	NSMutableArray *sort = [NSMutableArray arrayWithArray:self];
	for (id eachitem in self)
    {
		if (![eachitem isKindOfClass:[NSString class]])
        {
            [sort removeObject:eachitem];
        }
    }
    
	return [sort sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (id)firstObject
{
    if ([self count] == 0)
        return nil;
    
    return [self objectAtIndex:0];
}

@end


#pragma mark -
#pragma mark NSMutableArray

@implementation NSMutableArray (Category)

- (void)moveObjectToTop:(NSUInteger)index
{
    [self moveObjectFromIndex:index toIndex:0];
}

- (void)moveObjectFromIndex:(NSUInteger)oldIndex toIndex:(NSUInteger)newIndex
{
    if (oldIndex == newIndex)
    {
		return;
    }
    
    if (oldIndex >= self.count || newIndex >= self.count)
    {
        return;
    }
    
	id item = [self objectAtIndex:oldIndex];
    [self removeObjectAtIndex:oldIndex];
    [self insertObject:item atIndex:newIndex];
}

- (NSMutableArray *)removeFirstObject
{
	[self removeObjectAtIndex:0];
    
	return self;
}

@end
