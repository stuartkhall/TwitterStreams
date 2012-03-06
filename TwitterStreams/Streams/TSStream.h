//
//  TSStream.h
//
//  Created by Stuart Hall on 6/03/12.
//  Copyright (c) 2012 Filter Squad. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TSStream;
@class ACAccount;

@protocol TSStreamDelegate <NSObject>

@optional

- (void)streamDidReceiveMessage:(TSStream*)stream json:(id)json;
- (void)streamDidReceiveInvalidJson:(TSStream*)stream message:(NSString*)message;
- (void)streamDidTimeout:(TSStream*)stream;
- (void)streamDidFailConnection:(TSStream*)stream;

@end

@interface TSStream : NSObject

- (id)initWithEndpoint:(NSString*)endpoint
         andParameters:(NSDictionary*)parameters
            andAccount:(ACAccount*)account
           andDelegate:(id<TSStreamDelegate>)delegate;

- (void)start;
- (void)stop;

@end
