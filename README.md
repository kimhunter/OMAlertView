OMAlertView
===========

`OMAlertView` extents `UIAlertView` to allow completion blocks for each button

This isn't new its based on a previous repo I wrote KMAlertView which handles the blocks differently,
but this is also based on another library I've seen where the blocks are added with the button title
which seems to make for easier reading.

I've added some Class methods to make writing simple alerts into your code pleasant.

Examples
--------

Basic alert with only one completion block for OK button

```objc
    [OMAlertView showCancelOkAlertWithTitle:@"Basic Alert" 
                                    message:@"This is the basic alert with ok cancel buttons"    
                            completionBlock:^{
                                                NSLog(@"You pressed Ok");
                                            }];
```

Single Ok Button

```objc                                                 
    [OMAlertView showOkAlertWithTitle:@"Single Button" message:@"single button alert" completionBlock:^{
        NSLog(@"Single Button Pressed");
    }];
```
   
Or you can do it the long way and define each button and block

```objc    
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
                                                      
```
