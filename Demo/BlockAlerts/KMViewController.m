//
//  KMViewController.m
//  BlockAlerts
//
//  Created by Kim Hunter on 7/12/11.
//  Copyright (c) 2011 None. All rights reserved.
//

#import "KMViewController.h"
#import "OMAlertView.h"

@implementation KMViewController

#pragma mark - View lifecycle

- (IBAction)basicAlert:(id)sender
{
    
    [OMAlertView showCancelOkAlertWithTitle:@"Basic Alert"
                                    message:@"This is the basic alert with ok cancel buttons"
                            completionBlock:^{
        NSLog(@"You pressed Ok %@", sender);
    }];
}

- (IBAction)singleButtonAlert:(id)sender
{
    [OMAlertView showOkAlertWithTitle:@"Single Button" message:@"this is a single button alert" completionBlock:^{
        NSLog(@"Single Button Pressed");
    }];
}

- (IBAction)customButtons:(id)sender 
{
    OMAlertView *av = [OMAlertView alertViewWithTitle:@"Custom Buttons" message:@"and custom completion blocks"];
    [av addButtonWithTitle:@"A" andCompletionBlock:^{
        NSLog(@"Pressed A Button %@", sender); // test block is copied correctly
    }];
    [av addButtonWithTitle:@"B" andCompletionBlock:^{
        NSLog(@"Pressed B Button");
    }];
    [av addButtonWithTitle:@"C" andCompletionBlock:^{
        NSLog(@"Pressed C Button");
    }];
    av.performBlockOn = OMAlertViewDidDismiss;
    [av show];

}

- (IBAction)causeARunLoop:(id)sender {
    NSLog(@"%@", sender);
}
@end


