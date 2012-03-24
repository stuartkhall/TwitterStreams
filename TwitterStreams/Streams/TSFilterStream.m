//
//  TSFilterStream.m
//  TwitterStreams
//
//  Created by Stuart Hall on 6/03/12.
//  Copyright (c) 2012 Stuart Hall. All rights reserved.
//

#import "TSFilterStream.h"

@implementation TSFilterStream

- (id)initWithAccount:(ACAccount*)account
          andDelegate:(id<TSStreamDelegate>)delegate
          andKeywords:(NSArray*)keywords {
    NSMutableDictionary* parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       [keywords componentsJoinedByString:@","], @"track",
                                       nil];
    
    return [super initWithEndpoint:@"https://stream.twitter.com/1/statuses/filter.json"
                     andParameters:parameters
                        andAccount:account
                       andDelegate:delegate];
}

@end
