//
//  TSUrl.m
//  TwitterStreams
//
//  Created by Stuart Hall on 7/03/12.
//  Copyright (c) 2012 Filter Squad. All rights reserved.
//

#import "TSUrl.h"

@implementation TSUrl

- (NSString*)url {
    return [self.dictionary objectForKey:@"url"];
}

- (NSString*)displayUrl {
    return [self.dictionary objectForKey:@"display_url"];
}

- (NSString*)expandedUrl {
    return [self.dictionary objectForKey:@"expanded_url"];
}

- (NSArray*)indicies {  
    return [self.dictionary objectForKey:@"indicies"];
}

@end
