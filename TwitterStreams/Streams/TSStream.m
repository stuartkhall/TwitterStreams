//
//  TSStream.m
//
//  Created by Stuart Hall on 6/03/12.
//  Copyright (c) 2012 Stuart Hall. All rights reserved.
//

#import "TSStream.h"
#import "JSONKit.h"

#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>

@interface TSStream ()

@property (nonatomic, retain) NSURLConnection* connection;
@property (nonatomic, retain) NSTimer* keepAliveTimer;
@property (nonatomic, assign) id<TSStreamDelegate> delegate;
@property (nonatomic, retain) ACAccount* account;
@property (nonatomic, retain) NSMutableDictionary* parameters;
@property (nonatomic, retain) NSString* endpoint;

@end

@implementation TSStream

@synthesize connection=_connection;
@synthesize keepAliveTimer=_keepAliveTimer;
@synthesize delegate=_delegate;
@synthesize account=_account;
@synthesize parameters=_parameters;
@synthesize endpoint=_endpoint;

- (void)dealloc {
    [self.connection cancel];
    self.connection = nil;
    
    [self.keepAliveTimer invalidate];
    self.keepAliveTimer = nil;
    
    self.account = nil;
    self.parameters = nil;
    self.endpoint = nil;
    
    [super dealloc];
}

- (id)initWithEndpoint:(NSString*)endpoint
         andParameters:(NSDictionary*)parameters
            andAccount:(ACAccount*)account
           andDelegate:(id<TSStreamDelegate>)delegate {
    self = [super init];
    if (self) {
        // Save the parameters
        self.delegate = delegate;
        self.account = account;
        self.endpoint = endpoint;
        
        // Use length delimited so we can count the bytes
        self.parameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
        [self.parameters setObject:@"length" forKey:@"delimited"];
    }
    return self;
}

#pragma mark - Public methods

- (void)start {
    // Our actually request
    TWRequest *request = [[TWRequest alloc]
                          initWithURL:[NSURL URLWithString:self.endpoint]
                          parameters:self.parameters
                          requestMethod:TWRequestMethodPOST];
    
    // Set the current account for authentication, or even just rate limit
    [request setAccount:self.account];
    
    // Use the signed request to start a connection
    self.connection = [NSURLConnection connectionWithRequest:request.signedURLRequest
                                                    delegate:self];
    
    // Start the keepalive timer and connection
    [self resetKeepalive];
    [self.connection start];
    
    [request release];
}

- (void)stop {
    [self.connection cancel];
    self.connection = nil;
}

#pragma mark - Keep Alive

- (void)resetKeepalive {
    [self.keepAliveTimer invalidate];
    self.keepAliveTimer = [NSTimer scheduledTimerWithTimeInterval:40 
                                                           target:self 
                                                         selector:@selector(onTimeout)
                                                         userInfo:nil
                                                          repeats:NO];
}

- (void)onTimeout {
    // Timeout
    [self stop];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(streamDidTimeout:)])
        [self.delegate streamDidTimeout:self];
    
    // Try and restart
    [self start];
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    int bytesExpected = 0;
    NSMutableString* message = nil;
    
    NSString* response = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    for (NSString* part in [response componentsSeparatedByString:@"\r\n"]) {
        int length = [part intValue];
        if (length > 0) {
            // New message
            message = [NSMutableString string];
            bytesExpected = length;
        }
        else if (bytesExpected > 0 && message) {
            if (message.length < bytesExpected) {
                // Append the data
                [message appendString:part];
                
                if (message.length < bytesExpected) {
                    // Newline counts
                    [message appendString:@"\r\n"];
                }
                
                if (message.length == bytesExpected) {
                    // Success!
                    id json = [message objectFromJSONString];
                    
                    // Alert the delegate
                    if (json) { 
                        if (self.delegate && [self.delegate respondsToSelector:@selector(streamDidReceiveMessage:json:)])
                            [self.delegate streamDidReceiveMessage:self json:json];
                        [self resetKeepalive];
                    }
                    else  {
                        if (self.delegate && [self.delegate respondsToSelector:@selector(streamDidReceiveInvalidJson:message:)])
                            [self.delegate streamDidReceiveInvalidJson:self message:message];
                    }
                    
                    // Reset
                    message = nil;
                    bytesExpected = 0;
                }
            }
        }
        else {
            // Keep alive
            [self resetKeepalive];
        }
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(streamDidFailConnection:)])
        [self.delegate streamDidFailConnection:self];

}

@end
