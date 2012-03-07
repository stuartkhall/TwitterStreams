//
//  NSArray+Enumerable.m
//
//  Created by Stuart Hall on 7/01/12.
//

#import "NSArray+Enumerable.h"

@implementation NSArray (Enumerable)

- (NSArray *)each:(void (^)(id obj))block {
    for (id item in self) {
        block(item);
    };
    return self;
}

- (NSArray *)eachWithIndex:(void (^)(id obj, int index))block {
    int index = 0;
    for (id item in self) {
        block(item, index);
        index++;
    };
    return self;
}

- (NSArray *)map:(id (^)(id obj))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    for (id item in self) {
        [array addObject:block(item)];
    };
    
    return [NSArray arrayWithArray:array];
}

@end
