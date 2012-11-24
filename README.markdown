OMAlertView
===========

`OMAlertView` extents `UIAlertView` to allow completion blocks for each button

I've added some Class methods to make writing simple alerts into your code pleasant.

Examples
--------

Basic alert with only one completion block for OK button

    [OMAlertView showCancelOkAlertWithTitle:@"Basic Alert" 
                                    message:@"This is the basic alert with ok cancel buttons"    
                            completionBlock:^{
                                                NSLog(@"You pressed Ok");
                                            }];

Single Ok Button

    [OMAlertView showOkAlertWithTitle:@"Single Button" message:@"single button alert" completionBlock:^{
        NSLog(@"Single Button Pressed");
    }];
   
Or you can do it the long way and define each button and block

    OMAlertView *alertView = [OMAlertView alertViewWithTitle:@"Custom Buttons" message:@"and custom completion blocks"];

    [alertView addButtonWithTitle:@"A" andCompletionBlock:^{
        NSLog(@"Pressed A Button");
    }];

    [alertView addButtonWithTitle:@"B" andCompletionBlock:^{
        NSLog(@"Pressed B Button");
    }];

    [alertView addButtonWithTitle:@"C" andCompletionBlock:^{
        NSLog(@"Pressed C Button");
    }];

    [alertView show];
