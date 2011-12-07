//
//  OMAlertView.h
//  BlockAlerts
//
//  Created by Kim Hunter on 7/12/11.
//  Copyright (c) 2011 None. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^OMAlertButtonCompletionBlock)(void);

@interface OMAlertView : UIAlertView<UIAlertViewDelegate>
{
    NSMutableDictionary *buttonBlocks;
}

- (void)addButtonWithTitle:(NSString *)aTitle andCompletionBlock:(OMAlertButtonCompletionBlock)completionBlock;
+ (void)showCancelOkAlertWithTitle:(NSString *)title message:(NSString *)message completionBlock:(OMAlertButtonCompletionBlock)completionBlock;



@end
