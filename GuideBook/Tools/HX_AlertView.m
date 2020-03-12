//
//  OINAlertView.m
//  AlertViewDemo
//
//  Created by wsl on 16/5/24.
//  Copyright © 2016年 wsl. All rights reserved.
//

#import "HX_AlertView.h"


typedef enum {
    OINAlertViewTypeNormal,
    OINAlertViewTypeTextField
} OINAlertViewType;


#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
@interface HX_AlertView()
{
    HX_AlertViewBlock cancelButtonBlock;
    HX_AlertViewBlock otherButtonBlock;
    
    HX_AlertViewStringBlock textFieldBlock;
    UIViewController *parentControl;
}
@property (nonatomic, strong) UIAlertView *alertView;
@property (nonatomic, strong) UIAlertController *alertControl;
@end

@implementation HX_AlertView


#pragma mark - private

//判断字符串是不是为空
- (BOOL )stringIsEmpty:(NSString *)aString {
    
    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }
    
    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    } else {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }
    
    return NO;
}

- (void)alertView:(UIAlertView *)theAlertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 && cancelButtonBlock)
        cancelButtonBlock();
    else if (buttonIndex == 1 && theAlertView.tag == OINAlertViewTypeNormal && otherButtonBlock)
        otherButtonBlock();
    else if (buttonIndex == 1 && theAlertView.tag == OINAlertViewTypeTextField && textFieldBlock)
        textFieldBlock([_alertView textFieldAtIndex:0].text);
//    _alertView = nil;
    
}

- (void)alertViewCancel:(UIAlertView *)theAlertView
{
    if (cancelButtonBlock)
        cancelButtonBlock();
//    _alertView = nil;
}


- (id) initWithTitle:(NSString*)title
             message:(NSString*)message
              parentControl:control
   cancelButtonTitle:(NSString *)cancelButtonTitle
   otherButtonTitles:(NSString *)otherButtonTitles
   cancelButtonBlock:(HX_AlertViewBlock)theCancelButtonBlock
    otherButtonBlock:(HX_AlertViewBlock)theOtherButtonBlock
{
    
    cancelButtonBlock = [theCancelButtonBlock copy];
    otherButtonBlock = [theOtherButtonBlock copy];
    
    parentControl = control;
    
    if (IOS_VERSION >= 8.0) {
        _alertControl = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        if (![self stringIsEmpty:cancelButtonTitle]) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
               
                cancelButtonBlock();
                _alertControl = nil;
            }];
               [_alertControl addAction:cancelAction];
        }
       
        if (![self stringIsEmpty:otherButtonTitles]) {
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                  otherButtonBlock();
                _alertControl = nil;
            }];
             [_alertControl addAction:otherAction];
        }
    
        // Add the actions.
     
       
        
    } else {
        _alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
        _alertView.tag = OINAlertViewTypeNormal;
    }
    
 
    
 
    
    return self;
}

- (id) initWithTitle:(NSString*)title
             message:(NSString*)message
            parentControl:(UIViewController *)control
       textFieldHint:(NSString*)textFieldMessage
      textFieldValue:(NSString *)texttFieldValue
   cancelButtonTitle:(NSString *)cancelButtonTitle
   otherButtonTitles:(NSString *)otherButtonTitles
   cancelButtonBlock:(HX_AlertViewBlock)theCancelButtonBlock
    otherButtonBlock:(HX_AlertViewStringBlock)theOtherButtonBlock
{
    
    cancelButtonBlock = [theCancelButtonBlock copy];
    textFieldBlock = [theOtherButtonBlock copy];
    parentControl = control;
    
    if (IOS_VERSION >= 8.0) {
        _alertControl = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        [_alertControl addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = textFieldMessage;
            textField.text = texttFieldValue;
            _textField = textField;
        }];
        
        if (![self stringIsEmpty:cancelButtonTitle]) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                cancelButtonBlock();
                _alertControl = nil;
            }];
            [_alertControl addAction:cancelAction];
        }
        
        if (![self stringIsEmpty:otherButtonTitles]) {
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                 textFieldBlock(_alertControl.textFields[0].text);
                _alertControl = nil;
            }];
            [_alertControl addAction:otherAction];
        }
        
        
        
        // Add the actions.
        
        
        
    } else {
    
    
        _alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
        _alertView.tag = OINAlertViewTypeTextField;
        
        _alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        [[_alertView textFieldAtIndex:0] setPlaceholder:textFieldMessage];
        [[_alertView textFieldAtIndex:0] setText:texttFieldValue];
        _textField = [_alertView textFieldAtIndex:0];
    
    }
    
    return self;
}

- (void)showAlertInView
{
    if (IOS_VERSION >=8.0) {
        
         [parentControl presentViewController:_alertControl animated:YES completion:nil];
    } else {
        [_alertView show];

    }
    
}


@end
