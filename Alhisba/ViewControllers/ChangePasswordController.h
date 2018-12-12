//
//  ChangePasswordController.h
//  sheeel
//
//  Created by apple on 18/05/17.
//  Copyright © 2017 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UIFloatLabelTextField.h"


@interface ChangePasswordController : BaseViewController

@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *oldPas;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *ProvidePasswo;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *confirmPass;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;


@property (weak, nonatomic) IBOutlet UITextField *enterOldPasswordLbl;
@property (weak, nonatomic) IBOutlet UITextField *confirmPaswordLbl;


- (IBAction)submitBtnClicked:(id)sender;



@end
