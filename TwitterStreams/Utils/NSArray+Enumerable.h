//
//  NSArray+Enumerable.h
//
//  Created by Stuart Hall on 7/01/12.
//
//  All credit to http://blog.walkingsmarts.com/implementing-ruby-style-iterators-for-nsarray/
//

@interface NSArray (Enumerable)

- (NSArray *)each:(void (^)(id obj))block;
- (NSArray *)eachWithIndex:(void (^)(id obj, int index))block;
- (NSArray *)map:(id (^)(id obj))block;

@end
