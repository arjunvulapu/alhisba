//
//  LoginViewController.h
//  Alhisba
//
//  Created by apple on 04/12/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JVFloatLabeledTextField.h"
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@interface LoginViewController : BaseViewController
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *userName;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *password;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)submitBtnAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
