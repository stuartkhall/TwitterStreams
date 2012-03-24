//
//  TSUserStream.h
//  TwitterStreams
//
//  Created by Stuart Hall on 6/03/12.
//  Copyright (c) 2012 Stuart Hall. All rights reserved.
//

#import "TSStream.h"

@interface TSUserStream : TSStream

/*! 
 @method    initWithAccount:andDelegate:andAllReplies:andAllFollowings:
 
 @abstract
 Initialises and starts a stream
 
 @param 
 account    The authenticated account. 
 
 @param 
 delegate   The delegate. 
 
 @param 
 allReplies YES for all replies, NO for mutual followings. [see here](https://dev.twitter.com/docs/streaming-api/user-streams)
 
 @param 
 andAllFollowings   YES for all following, NO for only the authenticated user. [see here](https://dev.twitter.com/docs/streaming-api/user-streams) 
 */
- (id)initWithAccount:(ACAccount*)account
          andDelegate:(id<TSStreamDelegate>)delegate
        andAllReplies:(BOOL)allReplies
     andAllFollowings:(BOOL)allFollowing;

@end
