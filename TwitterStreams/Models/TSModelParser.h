//
//  TSModelParser.h
//  TwitterStreams
//
//  Created by Stuart Hall on 6/03/12.
//  Copyright (c) 2012 Stuart Hall. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TSFriendsList.h"
#import "TSTweet.h"
#import "TSFollow.h"
#import "TSFavorite.h"

typedef void(^TSModelParserFriendsList)(TSFriendsList* model);
typedef void(^TSModelParserTweet)(TSTweet* model);
typedef void(^TSModelParserFollow)(TSFollow* model);
typedef void(^TSModelParserFavorite)(TSFavorite* model);
typedef void(^TSModelParserUnsupported)(id json);

@interface TSModelParser : NSObject

+ (void)parseJson:(id)json
          friends:(TSModelParserFriendsList)friends
            tweet:(TSModelParserTweet)tweet
      deleteTweet:(TSModelParserTweet)deleteTweet
           follow:(TSModelParserFollow)follow
         favorite:(TSModelParserFavorite)favorite
       unfavorite:(TSModelParserFavorite)unfavorite
      unsupported:(TSModelParserUnsupported)unsupported;
 
@end
