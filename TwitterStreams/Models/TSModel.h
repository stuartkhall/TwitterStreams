//
//  TSModel.h
//  TwitterStreams
//
//  Created by Stuart Hall on 6/03/12.
//  Copyright (c) 2012 Filter Squad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSModel : NSObject

- (id)initWithDictionary:(NSDictionary*)dictionary;

@property (nonatomic, retain) NSDictionary* dictionary;

@end
