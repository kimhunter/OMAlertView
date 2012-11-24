//
//  OMAlertView.h
//  BlockAlerts
//
//  Created by Kim Hunter on 7/12/11.
//  Copyright (c) 2011 None. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    OMAlertViewBlockClicked,
    OMAlertViewBlockWillDismiss,
    OMAlertViewBlockDidDismiss
} OMAlertPerformBlockOnEvent;

typedef void (^OMAlertViewBlock)(void);

@interface OMAlertView : UIAlertView<UIAlertViewDelegate>
{
    NSMutableDictionary *_buttonBlocks;
}

@property (nonatomic, copy) OMAlertViewBlock willPresentAlertViewBlock;
@property (nonatomic, copy) OMAlertViewBlock didPresentAlertViewBlock;

/** run button blocks on at the time specified by this */
@property (nonatomic, assign) OMAlertPerformBlockOnEvent performBlockOn;
+ (id)alertView;
+ (id)alertViewWithTitle:(NSString *)title message:(NSString *)message;
+ (void)showCancelOkAlertWithTitle:(NSString *)title message:(NSString *)message completionBlock:(OMAlertViewBlock)completionBlock;
+ (void)showOkAlertWithTitle:(NSString *)title message:(NSString *)message completionBlock:(OMAlertViewBlock)completionBlock;

- (void)addButtonWithTitle:(NSString *)aTitle andCompletionBlock:(OMAlertViewBlock)completionBlock;

@end
