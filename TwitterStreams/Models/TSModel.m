//
//  TSModel.m
//  TwitterStreams
//
//  Created by Stuart Hall on 6/03/12.
//  Copyright (c) 2012 Filter Squad. All rights reserved.
//

#import "TSModel.h"

@implementation TSModel

@synthesize dictionary=_dictionary;

- (id)initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    if (self) {
        self.dictionary = dictionary;
    }
    return self;
}

- (void)dealloc {
    self.dictionary = nil;
    
    [super dealloc];
}

@end
