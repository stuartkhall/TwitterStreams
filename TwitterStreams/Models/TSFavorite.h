//
//  TSFavorite.h
//  TwitterStreams
//
//  Created by Stuart Hall on 6/03/12.
//  Copyright (c) 2012 Stuart Hall. All rights reserved.
//

#import "TSModel.h"
#import "TSUser.h"
#import "TSTweet.h"

@interface TSFavorite : TSModel

- (TSUser*)source;
- (TSUser*)target;
- (TSTweet*)tweet;

@end
