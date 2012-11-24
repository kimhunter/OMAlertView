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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)basicAlert:(id)sender
{
    
    [OMAlertView showCancelOkAlertWithTitle:@"Basic Alert"
                                    message:@"This is the basic alert with ok cancel buttons"
                            completionBlock:[[^{
        NSLog(@"You pressed Ok %@", sender);
    } copy] autorelease]];
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
        NSLog(@"Pressed A Button");
    }];
    [av addButtonWithTitle:@"B" andCompletionBlock:^{
        NSLog(@"Pressed B Button");
    }];
    [av addButtonWithTitle:@"C" andCompletionBlock:^{
        NSLog(@"Pressed C Button");
    }];
    av.alertViewCancel = [[^{
        NSLog(@"%@", sender);
    } copy] autorelease];
    [av show];

}

- (IBAction)causeARunLoop:(id)sender {
    NSLog(@"%@", sender);
}
@end


