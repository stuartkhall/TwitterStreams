//
//  TSModelParser.m
//  TwitterStreams
//
//  Created by Stuart Hall on 6/03/12.
//  Copyright (c) 2012 Stuart Hall. All rights reserved.
//

#import "TSModelParser.h"

@implementation TSModelParser

static dispatch_queue_t model_processing_queue;
static dispatch_queue_t operation_processing_queue() {
    if (model_processing_queue == NULL)
        model_processing_queue = dispatch_queue_create("com.filtersquad.tsmodelparser.processing", 0);
    return model_processing_queue;
}

+ (void)parseJson:(id)json
          friends:(TSModelParserFriendsList)friends
            tweet:(TSModelParserTweet)tweet
      deleteTweet:(TSModelParserTweet)deleteTweet
           follow:(TSModelParserFollow)follow
         favorite:(TSModelParserFavorite)favorite
       unfavorite:(TSModelParserFavorite)unfavorite
      unsupported:(TSModelParserUnsupported)unsupported {
    dispatch_async(operation_processing_queue(), ^(void) {
        if ([json isKindOfClass:[NSDictionary class]]) {
            if ([json objectForKey:@"friends"]) {
                TSFriendsList* model = [[[TSFriendsList alloc] initWithDictionary:json] autorelease];
                dispatch_async(dispatch_get_main_queue(), ^{
                    friends(model);
                });
            }
            else if ([json objectForKey:@"source"] && [json objectForKey:@"text"]) {
                TSTweet* model = [[[TSTweet alloc] initWithDictionary:json] autorelease];
                dispatch_async(dispatch_get_main_queue(), ^{
                    tweet(model);
                });
            }    
            else if ([json objectForKey:@"delete"]) {
                TSTweet* model = [[[TSTweet alloc] initWithDictionary:[json objectForKey:@"status"]] autorelease];
                dispatch_async(dispatch_get_main_queue(), ^{
                    deleteTweet(model);
                });
            }  
            else if ([json objectForKey:@"event"] && [[json objectForKey:@"event"] isEqualToString:@"follow"]) {
                TSFollow* model = [[[TSFollow alloc] initWithDictionary:json] autorelease];
                dispatch_async(dispatch_get_main_queue(), ^{
                    follow(model);
                });
            }  
            else if ([json objectForKey:@"event"] && [[json objectForKey:@"event"] isEqualToString:@"favorite"]) {
                TSFavorite* model = [[[TSFavorite alloc] initWithDictionary:json] autorelease];
                dispatch_async(dispatch_get_main_queue(), ^{
                    favorite(model);
                });
            }
            else if ([json objectForKey:@"event"] && [[json objectForKey:@"event"] isEqualToString:@"unfavorite"]) {
                TSFavorite* model = [[[TSFavorite alloc] initWithDictionary:json] autorelease];
                dispatch_async(dispatch_get_main_queue(), ^{
                    unfavorite(model);
                });
            }
            else {
                // Unknown
                dispatch_async(dispatch_get_main_queue(), ^{
                    unsupported(json);
                });
            }
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                unsupported(json);
            });
        }
    }); 
}

@end
