//
//  TSModelParser.h
//  TwitterStreams
//
//  Created by Stuart Hall on 6/03/12.
//  Copyright (c) 2012 Filter Squad. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TSFriendsList.h"
#import "TSTweet.h"

typedef void(^TSModelParserFriendsList)(TSFriendsList* model);
typedef void(^TSModelParserTweet)(TSTweet* model);
typedef void(^TSModelParserUnsupported)(id json);

@interface TSModelParser : NSObject

+ (void)parseJson:(id)json
          friends:(TSModelParserFriendsList)friends
            tweet:(TSModelParserTweet)tweet
      unsupported:(TSModelParserUnsupported)unsupported;
 
@end
