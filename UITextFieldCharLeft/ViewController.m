//
//  ViewController.m
//  UITextFieldCharLeft
//
//  Created by contus on 07/08/15.
//  Copyright (c) 2015 kasirajan. All rights reserved.
//

#import "ViewController.h"

#define MAX_CHAR 25

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *method1TextField;
@property (weak, nonatomic) IBOutlet UITextField *method2TextField;
@property (weak, nonatomic) IBOutlet UILabel *method1CountLabel;
@property (strong, nonatomic) UILabel *countLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    // set UITextField Delegate
    _method1TextField.delegate = self;
    _method2TextField.delegate = self;
    

    // Create chat count lable for Method 2
    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    _countLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    [_countLabel setTextAlignment:NSTextAlignmentRight];
    _method2TextField.rightViewMode = UITextFieldViewModeWhileEditing;
    _method2TextField.rightView = _countLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITextField Delegate

/*!
 *  Check UITextField char count
 *
 *
 *  @param textField textField
 *  @param range     char range
 *  @param string    typed value
 *
 *  @return YES/NO
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _method1TextField) // Method 1
    {
        return [self checkCharCountWithLabel:_method1CountLabel originalText:textField.text replaceString:string maxChar:MAX_CHAR];
    }
    else // Method 2
    {
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
    
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        [_countLabel setText:[NSString stringWithFormat:@"%lu ", newLength]];
        
        return newLength < MAX_CHAR;
    }
}

#pragma mark - Private Method Implementation

/*!
 *  Restrict number of char to UITextFiled.
 *  Set character count value to label.
 *
 *  @param label   char count lable
 *  @param text    original message
 *  @param string  newly entered string
 *  @param maxChar maximum number of char allowed in textfield
 *
 *  @return YES/NO
 */
- (BOOL)checkCharCountWithLabel:(UILabel *)label originalText:(NSString *)text replaceString:(NSString *)string maxChar:(int)maxChar {
    NSUInteger count = 0;
    
    /*!
     *  Set charater count to count lable view.
     *
     *  Increase count value if you enter any char
     *  and it will return NO textfiled.text reach max char.
     *  Else
     *  Decrease the count value.
     *
     */
    if ([string length] != 0) {
        count = [text length] + [string length];
        
        if (count > maxChar)
            return NO;
    }
    else {
        count = [text length] - 1;
    }
    
    // set count value
    [label setText:[NSString stringWithFormat:@"%d", maxChar - (int)count]];
    
    return YES;
}

@end
