//
//  TSFilterStream.h
//  TwitterStreams
//
//  Created by Stuart Hall on 6/03/12.
//  Copyright (c) 2012 Filter Squad. All rights reserved.
//

#import "TSStream.h"

@interface TSFilterStream : TSStream

/*! 
 @method    initWithAccount:andDelegate:andKeywords:
 
 @abstract
 Initialises and starts a stream
 
 @param 
 account    The authenticated account. 
 
 @param 
 delegate   The delegate. 
 
 @param 
 keywords   Keywords to filter on
 
 */
- (id)initWithAccount:(ACAccount*)account
          andDelegate:(id<TSStreamDelegate>)delegate
          andKeywords:(NSArray*)keywords;

@end
