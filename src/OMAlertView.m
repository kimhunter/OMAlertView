//
//  OMAlertView.m
//  BlockAlerts
//
//  Created by Kim Hunter on 7/12/11.
//  Copyright (c) 2011 None. All rights reserved.
//

#import "OMAlertView.h"

@implementation OMAlertView
- (void)dealloc
{
    [buttonBlocks release];
    self.delegate = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        buttonBlocks = [NSMutableDictionary new];
        self.delegate = self;
    }
    return self;
}

+ (id)alertView
{
    return [[[self alloc] init] autorelease];
}

+ (void)showCancelOkAlertWithTitle:(NSString *)title message:(NSString *)message completionBlock:(OMAlertButtonCompletionBlock)completionBlock
{
    OMAlertView *alertView = [[self alloc] init];
    [alertView setTitle:title];
    [alertView setMessage:message];
    [alertView addButtonWithTitle:NSLocalizedString(@"Cancel", @"Cancel")];
    [alertView addButtonWithTitle:NSLocalizedString(@"OK", @"OK") andCompletionBlock:completionBlock];
    [alertView setCancelButtonIndex:0];
    [alertView show];
    [alertView release];
}



- (void)addButtonWithTitle:(NSString *)aTitle andCompletionBlock:(OMAlertButtonCompletionBlock)completionBlock
{
    NSAssert(aTitle, @"Title shouldn't be nil");
    NSAssert(![buttonBlocks objectForKey:aTitle], @"button title already exists");
    [self addButtonWithTitle:aTitle];
    [buttonBlocks setObject:completionBlock forKey:aTitle];
    
    
}

#pragma mark -
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *clickedButtonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    
    OMAlertButtonCompletionBlock compBlock = [buttonBlocks objectForKey:clickedButtonTitle];
    if (compBlock)
    {
        compBlock();
    }
}



@end
