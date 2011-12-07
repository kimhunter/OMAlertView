//
//  OMAlertView.m
//  BlockAlerts
//
//  Created by Kim Hunter on 7/12/11.
//  Copyright (c) 2011 None. All rights reserved.
//

#import "OMAlertView.h"

@implementation OMAlertView

@synthesize didPresentAlertViewBlock = _didPresentAlertViewBlock;
@synthesize willPresentAlertViewBlock = _willPresentAlertViewBlock;

- (void)dealloc
{
    [buttonBlocks release];
    self.didPresentAlertViewBlock = nil;
    self.willPresentAlertViewBlock = nil;
    self.delegate = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        buttonBlocks = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+ (id)alertView
{
    return [[[self alloc] init] autorelease];
}

+ (id)alertViewWithTitle:(NSString *)title message:(NSString *)message
{
    OMAlertView *alertView = [self alertView];
    [alertView setTitle:title];
    [alertView setMessage:message];
    return alertView;
}

+ (void)showCancelOkAlertWithTitle:(NSString *)title message:(NSString *)message completionBlock:(OMAlertViewBlock)completionBlock
{
    OMAlertView *alertView = [self alertViewWithTitle:title message:message];
    [alertView addButtonWithTitle:NSLocalizedString(@"Cancel", @"Cancel")];
    [alertView addButtonWithTitle:NSLocalizedString(@"OK", @"OK") andCompletionBlock:completionBlock];
    [alertView setCancelButtonIndex:0];
    [alertView show];
}

+ (void)showOkAlertWithTitle:(NSString *)title message:(NSString *)message completionBlock:(OMAlertViewBlock)completionBlock
{
    OMAlertView *alertView = [self alertViewWithTitle:title message:message];
    [alertView addButtonWithTitle:NSLocalizedString(@"OK", @"OK") andCompletionBlock:completionBlock];
    [alertView show];
}

- (void)addButtonWithTitle:(NSString *)aTitle andCompletionBlock:(OMAlertViewBlock)completionBlock
{
    NSAssert(aTitle, @"Title shouldn't be nil");
    NSAssert(![buttonBlocks objectForKey:aTitle], @"button title already exists");
    [self addButtonWithTitle:aTitle];
    [buttonBlocks setObject:completionBlock forKey:aTitle];
}
- (void)show
{
    // Only set the delegate if it hasn't been done already
    if (self.delegate == nil)
    {
        self.delegate = self;
    }
    [super show];
}

#pragma mark -
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *clickedButtonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    OMAlertViewBlock completionBlock = nil;
    
    if (clickedButtonTitle && (completionBlock = [buttonBlocks objectForKey:clickedButtonTitle]))
    {
        completionBlock();
    }
}

- (void)willPresentAlertView:(UIAlertView *)alertView
{
    if (_willPresentAlertViewBlock) _willPresentAlertViewBlock();
}
- (void)didPresentAlertView:(UIAlertView *)alertView
{
    if(_didPresentAlertViewBlock) _didPresentAlertViewBlock();
}
@end
