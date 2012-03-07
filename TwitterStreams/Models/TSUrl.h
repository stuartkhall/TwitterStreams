//
//  TSUrl.h
//  TwitterStreams
//
//  Created by Stuart Hall on 7/03/12.
//  Copyright (c) 2012 Filter Squad. All rights reserved.
//

#import "TSModel.h"

@interface TSUrl : TSModel

- (NSString*)url;
- (NSString*)displayUrl;
- (NSString*)expandedUrl;
- (NSArray*)indicies;

@end
