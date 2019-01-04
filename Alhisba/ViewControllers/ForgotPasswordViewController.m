//
//  ForgotPasswordViewController.m
//  Bloomego
//
//  Created by apple on 08/01/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ForgotPasswordViewController.h"


@interface ForgotPasswordViewController ()<UITextFieldDelegate>{
    
    UIButton *backButton,*cartButton;
}

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = Localized(@"Forgot Password");
    
    [_submitBtn setTitle:Localized(@"Submit") forState:UIControlStateNormal];
    
    _emailFld.delegate = self;

    [_submitBtn.layer setCornerRadius: 5.0f];
//Set corner radius of label to change the shape.
    [_submitBtn setClipsToBounds:YES];//Set its to YES for Corner radius to work.
    
    UIColor *color = [UIColor whiteColor];
    _emailFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Email Address") attributes:@{NSForegroundColorAttributeName: color  }];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer setWidth:-10];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];//UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];

    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"back-whiteright.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        backButton.frame = CGRectMake(0, 0, 30, 30);
        UIBarButtonItem *customBarRightBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,customBarRightBtn,nil];
    }
    else{
        backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"back-white.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        backButton.frame = CGRectMake(0, 0, 30, 30);
        UIBarButtonItem *customBarRightBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,customBarRightBtn,nil];
    }
   
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidArabicKufi-Bold"size:20.0],NSFontAttributeName,nil];
    }
    else{
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
    }
    
}

-(void)backBtnClicked{
    
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)cartBtnClicked{
    
}

- (IBAction)submitBtnclicked:(id)sender {
    
    if ([self.emailFld.text length] == 0) {
        [self showErrorAlertWithMessage:@"Please Enter email Address"];
    }
    else {
        [self makePostCallForPage:FORGET_PASSWORD withParams:@{@"email":self.emailFld.text} withRequestCode:1];
    }
}

-(void)parseResult:(id)result withCode:(int)reqeustCode
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[result valueForKey:@"status"] message:[result valueForKey:@"message"]preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [alertController dismissViewControllerAnimated:YES completion:^{
            
            if ([[result valueForKey:@"status"]isEqualToString:@"Success"]) {
                
                [self.navigationController popViewControllerAnimated:NO];
                
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

-(void)viewWillAppear:(BOOL)animated{
    
//    self.navigationItem.title = Localized(@"FORGOT PASSWORD");
//    [_submitBtn setTitle:Localized(@"SUBMIT") forState:UIControlStateNormal];
}

//-(void)textFldBoarders{
//
//    _emailFld.layer.cornerRadius=5.0f;
//    _emailFld.layer.masksToBounds=YES;
//    _emailFld.layer.borderColor=[[UIColor lightGrayColor]CGColor];
//    _emailFld.layer.borderWidth= 1.0f;
//}
//
//-(void)paddingFlds{
//
//    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
//
//        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 5, 20)];
//        _emailFld.rightView = paddingView;
//        _emailFld.rightViewMode = UITextFieldViewModeAlways;
//    }
//    else{
//        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 5, 20)];
//        _emailFld.leftView = paddingView;
//        _emailFld.leftViewMode = UITextFieldViewModeAlways;
//    }
//
//}

@end
