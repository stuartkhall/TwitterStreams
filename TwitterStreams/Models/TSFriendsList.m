//
//  TSFriendsList.m
//  TwitterStreams
//
//  Created by Stuart Hall on 6/03/12.
//  Copyright (c) 2012 Stuart Hall. All rights reserved.
//

#import "TSFriendsList.h"

@implementation TSFriendsList

- (NSArray*)friendsIds {
    return [self.dictionary objectForKey:@"friends"];
}

@end
