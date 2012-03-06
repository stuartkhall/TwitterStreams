//
//  TSTweet.m
//  TwitterStreams
//
//  Created by Stuart Hall on 6/03/12.
//  Copyright (c) 2012 Filter Squad. All rights reserved.
//

#import "TSTweet.h"

@interface TSTweet()
@property (nonatomic, retain) TSUser* cachedUser;
@end

@implementation TSTweet

@synthesize cachedUser=_cachedUser;

- (void)dealloc {
    self.cachedUser = nil;
    [super dealloc];
}

- (NSString*)text {
    return [self.dictionary objectForKey:@"text"];
}

- (TSUser*)user {
    if (!self.cachedUser)
        self.cachedUser = [[[TSUser alloc] initWithDictionary:[self.dictionary objectForKey:@"user"]] autorelease];
    
    return self.cachedUser;
}

@end
