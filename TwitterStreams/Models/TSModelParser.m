//
//  TSModelParser.m
//  TwitterStreams
//
//  Created by Stuart Hall on 6/03/12.
//  Copyright (c) 2012 Filter Squad. All rights reserved.
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
