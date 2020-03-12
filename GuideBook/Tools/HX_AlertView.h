//
//  OINAlertView.h
//  AlertViewDemo
//
//  Created by wsl on 16/5/24.
//  Copyright © 2016年 wsl. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^HX_AlertViewBlock)(void);

typedef void (^HX_AlertViewStringBlock)(NSString*);

@interface HX_AlertView : UIView <UIAlertViewDelegate>
@property (nonatomic, strong)UITextField *textField;

/**
 Show a native UIAlertView with two buttons. The text and the title is custom, and is also custom the text of the buttons.
 @param title Title of the UIAlertView
 @param message Message of the UIAlertView
 @param cancelButtonTitle Text of the second button
 @param otherButtonTitles Text of the first button
 @param cancelButtonBlock Code to run if the user tap at the second button
 @param otherButtonBlock Code to run if the user tap at the first button
 @return The reference to the STAlertView
 */

- (id) initWithTitle:(NSString *)title
             message:(NSString *)message
       parentControl:(UIViewController *)control
   cancelButtonTitle:(NSString *)cancelButtonTitle
   otherButtonTitles:(NSString *)otherButtonTitles
   cancelButtonBlock:(HX_AlertViewBlock)cancelButtonBlock
    otherButtonBlock:(HX_AlertViewBlock)otherButtonBlock;


/**
 Show a native UIAlertView with two buttons and a UITextField. The text and the title is custom, and is also custom the text of the buttons and the UITextField value and placeholder.
 @param title Title of the UIAlertView
 @param message Message of the UIAlertView
 @param textFieldHint Text of the placeholder
 @param textFieldValue Initial text of the UITextField
 @param cancelButtonTitle Text of the second button
 @param otherButtonTitles Text of the first button
 @param cancelButtonBlock Code to run if the user tap at the second button
 @param otherButtonBlock Code to run if the user tap at the first button
 @return The reference to the STAlertView
 */
- (id) initWithTitle:(NSString *)title
             message:(NSString*)message
             parentControl:(UIViewController *)control
       textFieldHint:(NSString *)textFieldMessage
      textFieldValue:(NSString *)texttFieldValue
   cancelButtonTitle:(NSString *)cancelButtonTitle
   otherButtonTitles:(NSString *)otherButtonTitles
   cancelButtonBlock:(HX_AlertViewBlock)cancelButtonBlock
    otherButtonBlock:(HX_AlertViewStringBlock)otherButtonBlock;


- (void)showAlertInView;

@end
