//
//  ChangePasswordController.m
//  sheeel
//
//  Created by apple on 18/05/17.
//  Copyright © 2017 apple. All rights reserved.
//

#import "ChangePasswordController.h"
#import "MCLocalization.h"
#import "Common.h"
#import "BaseViewController.h"
#import "HomeViewController.h"


@interface ChangePasswordController ()<UITextFieldDelegate>{
    
    UIButton *backBtn;
}

@end

@implementation ChangePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _oldPas.delegate = self;
    _ProvidePasswo.delegate = self;
    _confirmPass.delegate = self;
    
    self.navigationItem.title = Localized(@"Change Password");
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];//UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];

    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidArabicKufi-Bold"size:20.0],NSFontAttributeName,nil];
    }
    else{
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
    }
    
    
    _enterOldPasswordLbl.text = Localized(@"Enter old password");
   // _newPswdLbl.text = Localized(@"New password");
    _confirmPaswordLbl.text = Localized(@"Confirm Password");
    
    UIColor *color = [UIColor grayColor];
    _oldPas.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Old Password") attributes:@{NSForegroundColorAttributeName: color  }];
    _ProvidePasswo.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"New Password") attributes:@{NSForegroundColorAttributeName: color}];
    _confirmPass.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Confirm Password") attributes:@{NSForegroundColorAttributeName: color}];

    [_submitBtn.layer setCornerRadius: 5.0f];
    //Set corner radius of label to change the shape.
    [_submitBtn setClipsToBounds:YES];//Set its to YES for Corner radius to work.
    [_submitBtn setTitle:Localized(@"Submit") forState:UIControlStateNormal];
    
     if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
         
         [_oldPas setTextAlignment:NSTextAlignmentLeft];
         [_ProvidePasswo setTextAlignment:NSTextAlignmentLeft];
         [_confirmPass setTextAlignment:NSTextAlignmentLeft];

     }
     else{
         
         [_oldPas setTextAlignment:NSTextAlignmentRight];
         [_ProvidePasswo setTextAlignment:NSTextAlignmentRight];
         [_confirmPass setTextAlignment:NSTextAlignmentRight];

     }
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        backBtn = [[UIButton alloc] init];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"backWhiteRight.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 30, 30);
        [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backBarButtonItem;

    }
    else{
        backBtn = [[UIButton alloc] init];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"back-white.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 30, 30);
        [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backBarButtonItem;
    }
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidArabicKufi-Bold"size:20.0],NSFontAttributeName,nil];
    }
    else{
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
    }
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:9.0f/255.0f green:97.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;

    
//    self.navigationItem.title = @"Change Password";
}

-(void)viewWillAppear:(BOOL)animated{
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        [_oldPas setTextAlignment:NSTextAlignmentRight];
        [_ProvidePasswo setTextAlignment:NSTextAlignmentRight];
        [_confirmPass setTextAlignment:NSTextAlignmentRight];
    }
    else{
        
        [_oldPas setTextAlignment:NSTextAlignmentLeft];
        [_ProvidePasswo setTextAlignment:NSTextAlignmentLeft];
        [_confirmPass setTextAlignment:NSTextAlignmentLeft];
    }
    
}

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:NO];
}


- (IBAction)submitBtnClicked:(id)sender {

    if(_ProvidePasswo.text.length==0)
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Warning" message:Localized(@"new_password") preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *button=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
        
        [alert addAction:button];
        [self presentViewController:alert animated:YES completion:nil];
    }
   else
    {
        if([_ProvidePasswo.text isEqualToString:_confirmPass.text]){
            
            [self changePasswordAiCalling];
        }
        
        else{
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Warning" message:@"Please Provide Same Password" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *button=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
            
            [alert addAction:button];
            [self presentViewController:alert animated:YES completion:nil];

        }
    }
  }

-(void)changePasswordAiCalling{
    
    NSString *totalString = [[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"];
    
    if (totalString.length==0) {
        
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Pharmzi" message:@"Please login to change password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    else{
        
        [self makePostCallForPage:CHANGE_PASS withParams:@{@"member_id":[[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"],@"opassword":self.oldPas.text,@"password":self.ProvidePasswo.text,@"cpassword":self.confirmPass.text,} withRequestCode:1];
    }
  
}

-(void)parseResult:(id)result withCode:(int)reqeustCode
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[result valueForKey:@"status"] message:[result valueForKey:@"message"]preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [alertController dismissViewControllerAnimated:YES completion:^{
            
            if ([[result valueForKey:@"status"]isEqualToString:@"Success"]) {
                
                NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                [defaults setValue:@"" forKey:@"customer_id"];
                [defaults synchronize];

                HomeViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
                [self.navigationController pushViewController:loginView animated:YES];

            }
            else{
                
            }
            
        }];
        
    });
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}


//-(void)textFldBoarders{
//
//    _oldPas.layer.cornerRadius=5.0f;
//    _oldPas.layer.masksToBounds=YES;
//    _oldPas.layer.borderColor=[[UIColor lightGrayColor]CGColor];
//    _oldPas.layer.borderWidth= 1.0f;
//
//    _ProvidePasswo.layer.cornerRadius=5.0f;
//    _ProvidePasswo.layer.masksToBounds=YES;
//    _ProvidePasswo.layer.borderColor=[[UIColor lightGrayColor]CGColor];
//    _ProvidePasswo.layer.borderWidth= 1.0f;
//
//    _confirmPass.layer.cornerRadius=5.0f;
//    _confirmPass.layer.masksToBounds=YES;
//    _confirmPass.layer.borderColor=[[UIColor lightGrayColor]CGColor];
//    _confirmPass.layer.borderWidth= 1.0f;
//
//}
//
//
//-(void)paddingFlds{
//
//    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
//
//        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 5, 20)];
//        _oldPas.rightView = paddingView;
//        _oldPas.rightViewMode = UITextFieldViewModeAlways;
//
//
//        UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 5, 20)];
//        _ProvidePasswo.rightView = paddingView1;
//        _ProvidePasswo.rightViewMode = UITextFieldViewModeAlways;
//
//
//        UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 5, 20)];
//        _confirmPass.rightView = paddingView2;
//        _confirmPass.rightViewMode = UITextFieldViewModeAlways;
//
//    }
//    else{
//        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 5, 20)];
//        _oldPas.leftView = paddingView;
//        _oldPas.leftViewMode = UITextFieldViewModeAlways;
//
//
//        UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 5, 20)];
//        _ProvidePasswo.leftView = paddingView1;
//        _ProvidePasswo.leftViewMode = UITextFieldViewModeAlways;
//
//
//        UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 5, 20)];
//        _confirmPass.leftView = paddingView2;
//        _confirmPass.leftViewMode = UITextFieldViewModeAlways;
//
//    }
//
//}


@end
