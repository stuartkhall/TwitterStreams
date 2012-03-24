//
//  TSHashtag.m
//  TwitterStreams
//
//  Created by Stuart Hall on 7/03/12.
//  Copyright (c) 2012 Stuart Hall. All rights reserved.
//

#import "TSHashtag.h"

@implementation TSHashtag

- (NSString*)text {
    return [self.dictionary objectForKey:@"text"];
}

- (NSArray*)indicies {  
    return [self.dictionary objectForKey:@"indicies"];
}

@end
