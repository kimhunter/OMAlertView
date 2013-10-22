//
//  OMAlertView.m
//  BlockAlerts
//
//  Created by Kim Hunter on 7/12/11.
//  Copyright (c) 2011 None. All rights reserved.
//

#import "OMAlertView.h"

@interface OMAlertView ()
@property (nonatomic, retain) NSMutableDictionary *buttonBlocks;
@end

@implementation OMAlertView

#if !__has_feature(objc_arc)
- (void)dealloc
{
    self.delegate = nil;
    self.buttonBlocks = nil;
    self.didPresentAlertViewBlock = nil;
    self.willPresentAlertViewBlock = nil;
    [super dealloc];
}
#endif

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _buttonBlocks = [[NSMutableDictionary alloc] init];
        _performBlockOn = OMAlertViewClicked;
    }
    return self;
}

+ (instancetype)alertView
{
#if __has_feature(objc_arc)
    return [[self alloc] init];
#else
    return [[[self alloc] init] autorelease];
#endif
}

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message
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
    NSAssert(![_buttonBlocks objectForKey:aTitle], @"button title already exists");
    [self addButtonWithTitle:aTitle];
    [_buttonBlocks setObject:completionBlock forKey:aTitle];
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

- (void)alertView:(UIAlertView *)alertView buttonIndex:(NSInteger)buttonIndex performBlockOn:(OMAlertViewPerformOnEvent)calledBy
{
    if (calledBy == self.performBlockOn)
    {
        NSString *clickedButtonTitle = [alertView buttonTitleAtIndex:buttonIndex];
        OMAlertViewBlock completionBlock = nil;
        
        if (clickedButtonTitle && (completionBlock = [_buttonBlocks objectForKey:clickedButtonTitle]))
        {
            completionBlock();
        }
    }
}

#pragma mark -
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self alertView:alertView buttonIndex:buttonIndex performBlockOn:OMAlertViewClicked];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self alertView:alertView buttonIndex:buttonIndex performBlockOn:OMAlertViewWillDismiss];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self alertView:alertView buttonIndex:buttonIndex performBlockOn:OMAlertViewDidDismiss];
}

- (void)willPresentAlertView:(UIAlertView *)alertView
{
    if (_willPresentAlertViewBlock)
    {
        _willPresentAlertViewBlock();
    }
}

- (void)didPresentAlertView:(UIAlertView *)alertView
{
    if(_didPresentAlertViewBlock)
    {
        _didPresentAlertViewBlock();
    }
}
@end
