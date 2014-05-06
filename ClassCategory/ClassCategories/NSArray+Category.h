//
//  NSArray+NSArray_Category.h
//  
//
//  Created by mac on 13-12-18.
//  Copyright (c) 2013年 babytree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Category)

- (NSArray *)arrayBySortingStrings;

- (id)firstObject;

@end


@interface NSMutableArray (Category)

- (void)moveObjectToTop:(NSUInteger)index;

- (void)moveObjectFromIndex:(NSUInteger)oldIndex toIndex:(NSUInteger)newIndex;

- (NSMutableArray *)removeFirstObject;

@end
