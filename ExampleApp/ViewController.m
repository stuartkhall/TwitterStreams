//
//  ViewController.m
//  TwitterStreams
//
//  Created by Stuart Hall on 6/03/12.
//  Copyright (c) 2012 Filter Squad. All rights reserved.
//

#import "ViewController.h"

#import "TSUserStream.h"
#import "TSFilterStream.h"

#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>

@interface ViewController ()

@property (nonatomic, retain) ACAccountStore* accountStore;
@property (nonatomic, retain) NSArray* accounts;
@property (nonatomic, retain) ACAccount* account;

@property (nonatomic, retain) TSStream* stream;

@end

@implementation ViewController

@synthesize accountStore=_accountStore;
@synthesize accounts=_accounts;
@synthesize account=_account;
@synthesize stream=_stream;

- (void)dealloc {
    self.accountStore = nil;
    self.accounts = nil;
    self.account = nil;
    self.stream = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Get access to their accounts
    self.accountStore = [[[ACAccountStore alloc] init] autorelease];
    ACAccountType *accountTypeTwitter = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [self.accountStore requestAccessToAccountsWithType:accountTypeTwitter
                            withCompletionHandler:^(BOOL granted, NSError *error) {
                                if (granted && !error) {
                                    dispatch_sync(dispatch_get_main_queue(), ^{
                                        self.accounts = [self.accountStore accountsWithAccountType:accountTypeTwitter];
                                        if (self.accounts.count == 0) {
                                            [[[[UIAlertView alloc] initWithTitle:nil
                                                                         message:@"Please add a Twitter account in the Settings app"
                                                                        delegate:nil
                                                               cancelButtonTitle:@"OK"
                                                               otherButtonTitles:nil] autorelease] show];
                                        }
                                        else {
                                            // Let them select the account they want to use
                                            UIActionSheet* sheet = [[[UIActionSheet alloc] initWithTitle:@"Select your Twitter account:"
                                                                                                delegate:self
                                                                                       cancelButtonTitle:nil
                                                                                  destructiveButtonTitle:nil
                                                                                       otherButtonTitles:nil] autorelease];
                                            
                                            for (ACAccount* account in self.accounts) {
                                                [sheet addButtonWithTitle:account.accountDescription];
                                            }
                                            
                                            sheet.tag = 0;
                                            
                                            [sheet showInView:self.view];
                                        }
                                    });
                                }
                                else {
                                    dispatch_sync(dispatch_get_main_queue(), ^{
                                        NSString* message = [NSString stringWithFormat:@"Error getting access to accounts : %@", [error localizedDescription]];
                                        [[[[UIAlertView alloc] initWithTitle:nil
                                                                     message:message
                                                                    delegate:nil
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil] autorelease] show];
                                    });
                                }
                            }];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (actionSheet.tag) {
        case 0: {
            if (buttonIndex < self.accounts.count) {
                self.account = [self.accounts objectAtIndex:buttonIndex];
                
                // Stream options
                UIActionSheet* sheet = [[[UIActionSheet alloc] initWithTitle:@"Select stream type:"
                                                                    delegate:self 
                                                           cancelButtonTitle:nil
                                                      destructiveButtonTitle:nil
                                                           otherButtonTitles:@"User stream", @"Filter stream", nil] autorelease];
                sheet.tag = 1;
                [sheet showInView:self.view];
            }
        }
            break; 
            
        case 1: {
            self.stream = nil;
            
            // Create a stream of the selected types
            switch (buttonIndex) {
                case 0: {
                    self.stream = [[[TSUserStream alloc] initWithAccount:self.account
                                                             andDelegate:self
                                                           andAllReplies:YES
                                                        andAllFollowings:YES] autorelease];
                }
                    break;
                    
                case 1: {
                    self.stream = [[[TSFilterStream alloc] initWithAccount:self.account
                                                                     andDelegate:self
                                                                     andKeywords:[NSArray arrayWithObjects:@"stuartkhall", @"discovr", nil]] autorelease];

                }
                    break;
            }
            
            if (self.stream)
                [self.stream start];

        }
            break;
    }
}

#pragma mark - TSStreamDelegate

- (void)streamDidReceiveMessage:(TSStream*)stream json:(id)json {
    NSLog(@"%@", json);
}

- (void)streamDidReceiveInvalidJson:(TSStream*)stream message:(NSString*)message {
    NSLog(@"--\r\nInvalid JSON!!\r\n--");
}

- (void)streamDidTimeout:(TSStream*)stream {
    NSLog(@"--\r\nStream timeout!!\r\n--");
}

- (void)streamDidFailConnection:(TSStream *)stream {
    NSLog(@"--\r\nStream failed connection!!\r\n--");
    
    // Hack to just restart it, you'll want to handle this nicer :)
    [self.stream performSelector:@selector(start) withObject:nil afterDelay:10];
}

@end
