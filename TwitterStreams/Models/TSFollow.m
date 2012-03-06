//
//  TSFollow.m
//  TwitterStreams
//
//  Created by Stuart Hall on 6/03/12.
//  Copyright (c) 2012 Filter Squad. All rights reserved.
//

#import "TSFollow.h"

@implementation TSFollow

- (TSUser*)source {
    return [[[TSUser alloc] initWithDictionary:[self.dictionary objectForKey:@"source"]] autorelease];
}

- (TSUser*)target {
    return [[[TSUser alloc] initWithDictionary:[self.dictionary objectForKey:@"target"]] autorelease];
}

@end
