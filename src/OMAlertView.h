/*
 
 OMAlertView.h
 Created by Kim Hunter on 7/12/11.

 Copyright (c) 2011 Kim Hunter
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
*/

#import <UIKit/UIKit.h>

typedef enum {
    OMAlertViewBlockClicked,
    OMAlertViewBlockWillDismiss,
    OMAlertViewBlockDidDismiss
} OMAlertPerformBlockOnEvent;

/** 
    OMAlertViewBlock
    is a simple void^(void) block type
 */
typedef void (^OMAlertViewBlock)(void);

/** OMAlertView extents UIAlertView to allow completion blocks for each button */
@interface OMAlertView : UIAlertView<UIAlertViewDelegate>
{
    NSMutableDictionary *_buttonBlocks;
}

/** @name Properties */

/** run this block on UIAlertViewDelegate callback willPresentAlertView: */
@property (nonatomic, copy) OMAlertViewBlock willPresentAlertViewBlock;

/** run this block on UIAlertViewDelegate callback willPresentAlertView: */
@property (nonatomic, copy) OMAlertViewBlock didPresentAlertViewBlock;

/** run button blocks on at the time specified by this */
@property (nonatomic, assign) OMAlertPerformBlockOnEvent performBlockOn;

#pragma mark - Class Methods

/** @name Creating an OMAlertView */
/** a brand new shiny OMAlertView, same as calling alloc/init/autorelease */
+ (id)alertView;

/** a brand new shiny OMAlertView with title and message
    @param title title for the alert view
    @param message message for the alert view
    @return an OMAlertView that is not shown
 */
+ (id)alertViewWithTitle:(NSString *)title message:(NSString *)message;

#pragma mark Displaying
/** @name Displaying a simple alert */

/** Show an AlertView with Cancel and OK buttons
 
    OK button will be localized 
 
    @param title title for the alert view
    @param message message for the alert view
    @param completionBlock block to perform on selection of Ok button
 */
+ (void)showCancelOkAlertWithTitle:(NSString *)title message:(NSString *)message completionBlock:(OMAlertViewBlock)completionBlock;

/** Show an AlertView with just an OK button
 
    Cancel and OK buttons Will be localized
 
    @param title title for the alert view
    @param message message for the alert view
    @param completionBlock block to perform on selection of Ok button
 */
+ (void)showOkAlertWithTitle:(NSString *)title message:(NSString *)message completionBlock:(OMAlertViewBlock)completionBlock;

#pragma mark - Instance Methods

/** Show the view */
- (void)show;

/** @name Adding buttons to an alert */

/** Add a button with a block to perfom on its selection
 
    @param aTitle the buttons text
    @param completionBlock block to perform on selection
    @warning Identically named buttons are not supported
 */
- (void)addButtonWithTitle:(NSString *)aTitle andCompletionBlock:(OMAlertViewBlock)completionBlock;

@end
