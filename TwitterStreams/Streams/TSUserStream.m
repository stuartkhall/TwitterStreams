//
//  TSUserStream.m
//  TwitterStreams
//
//  Created by Stuart Hall on 6/03/12.
//  Copyright (c) 2012 Filter Squad. All rights reserved.
//

#import "TSUserStream.h"

@implementation TSUserStream

- (id)initWithAccount:(ACAccount*)account
          andDelegate:(id<TSStreamDelegate>)delegate
        andAllReplies:(BOOL)allReplies
     andAllFollowings:(BOOL)allFollowing {
    NSMutableDictionary* parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       allFollowing ? @"followings" : @"user", @"with",
                                       nil];
    if (allReplies)
        [parameters setObject:@"all" forKey:@"replies"];
    
    return [super initWithEndpoint:@"https://userstream.twitter.com/2/user.json"
                     andParameters:parameters
                        andAccount:account
                       andDelegate:delegate];
}

@end
