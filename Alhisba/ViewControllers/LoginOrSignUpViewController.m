//
//  LoginOrSignUpViewController.m
//  Alhisba
//
//  Created by apple on 19/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "LoginOrSignUpViewController.h"
#import "UIFloatLabelTextField.h"
#import "HomeViewController.h"
#import "ForgotPasswordViewController.h"
#import "OfficialApraisalViewController.h"

@interface LoginOrSignUpViewController ()<UIScrollViewDelegate>
{
    UIButton *backBtn;
    NSString *emailRegEx;
    NSPredicate *emailTest;

}
@end

@implementation LoginOrSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _emailAddressFld.delegate = self;
    _passwordFld.delegate = self;
    _signUpEmailFld.delegate = self;
    _signUppasswordFld.delegate = self;
    _confirmPasswordFld.delegate = self;
    _firstNameFld.delegate = self;
    _lastNameFld.delegate = self;
    _phoneFld.delegate = self;
    
    
    
    self.navigationItem.title = Localized(@"Login/SignUp");
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
    
//    UINavigationBar *navigationBar = self.navigationController.navigationBar;
//    UIImage *image = [UIImage imageNamed: @"NavImage.png"];
//    [navigationBar setBackgroundImage:image forBarMetrics: UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];//UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    [_loginBtn setTitle:Localized(@"Login") forState:UIControlStateNormal];
    [_signUpBtn setTitle:Localized(@"SignUp") forState:UIControlStateNormal];
    [_forgotBtn setTitle:Localized(@"Forgot Password ?") forState:UIControlStateNormal];
    [_mainLoginBtn setTitle:Localized(@"Login") forState:UIControlStateNormal];
    [_signUpMainBtn setTitle:Localized(@"SignUp") forState:UIControlStateNormal];

    [_signUpLogin setTitle:Localized(@"Login") forState:UIControlStateNormal];
    [_signUpSignUp setTitle:Localized(@"SignUp") forState:UIControlStateNormal];

    [_loginBtn.layer setCornerRadius: 5.0f];
    [_loginBtn.layer setBorderWidth:0.0f];
    [_loginBtn.layer setMasksToBounds:YES];
    
    [_mainLoginBtn.layer setCornerRadius: 5.0f];
    [_mainLoginBtn.layer setBorderWidth:0.0f];
    [_mainLoginBtn.layer setMasksToBounds:YES];

    [_signUpBtn.layer setCornerRadius: 5.0f];
    [_signUpBtn.layer setBorderWidth:2.0f];
    [_signUpBtn.layer setMasksToBounds:YES];
    [_signUpBtn.layer setBorderColor:[UIColor colorWithRed:245.0f/255.0f green:190.0f/255.0f blue:74.0f/255.0f alpha:1].CGColor];
    
    if ([_fromOfficial isEqualToString:@"fromOfficial"]) {
        
        [self signUpViewHidden];
    }
    
    if ([_loginOrSign isEqualToString:@"login"]) {
        
        [self signUpViewHidden];
    }
    else{
        [self signUpViewNotHidden];
    }
   
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"back-whiteright.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 20, 20);
        [backBtn addTarget:self action:@selector(backBtnTapped) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *customBarRightBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:customBarRightBtn,nil];
        
    }
    else{
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"back-white.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 20, 20);
        [backBtn addTarget:self action:@selector(backBtnTapped) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *customBarRightBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:customBarRightBtn,nil];
    }

    UIColor *color = [UIColor whiteColor];
    _emailAddressFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Email Address") attributes:@{NSForegroundColorAttributeName: color}];

    _passwordFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Password") attributes:@{NSForegroundColorAttributeName: color}];
    _firstNameFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"First Name") attributes:@{NSForegroundColorAttributeName: color}];
    _lastNameFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Last Name") attributes:@{NSForegroundColorAttributeName: color}];
    _phoneFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Phone Number") attributes:@{NSForegroundColorAttributeName: color}];
    _signUpEmailFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Email Address") attributes:@{NSForegroundColorAttributeName: color}];
    _signUppasswordFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Password") attributes:@{NSForegroundColorAttributeName: color}];
    _confirmPasswordFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Confirm Password") attributes:@{NSForegroundColorAttributeName: color}];
    
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    _phoneFld.inputAccessoryView = keyboardDoneButtonView;
    
    emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
        
        switch ((int)[[UIScreen mainScreen] nativeBounds].size.height) {
                
            case 1920:
                printf("iPhone 6+/6S+/7+/8+");
                _scrollView.scrollEnabled = NO;
                break;
            case 2436:
                printf("iPhone X");
                _scrollView.scrollEnabled = NO;
                break;
            case 2688:
                printf("iPhone Xs Max");
                _scrollView.scrollEnabled = NO;
                break;
            default:
                printf("unknown");
        }
    }
}

-(void)backBtnTapped{
 
    HomeViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    [self.navigationController pushViewController:obj animated:YES];
}

- (IBAction)loginBtnTapped:(id)sender {
    
    [self signUpViewHidden];
}

- (IBAction)signUpBtnTapped:(id)sender {

    [self signUpViewNotHidden];
}

- (IBAction)forgotBtnTapped:(id)sender {
    
    ForgotPasswordViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordViewController"];
    [self.navigationController pushViewController:obj animated:YES];
}

- (IBAction)mainLoginBtnTapped:(id)sender {
    
    if ([self.emailAddressFld.text length] == 0) {
        
        [self showErrorAlertWithMessage:Localized(@"Please Enter email address")];
        
    }
    else if (![emailTest evaluateWithObject:_emailAddressFld.text] == YES)
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:Localized(@"Alert") message:Localized(@"Please enter valid email") preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *button=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
        
        [alert addAction:button];
        [self presentViewController:alert animated:YES completion:nil];
    }else if ([self.passwordFld.text length] == 0) {
        
        [self showErrorAlertWithMessage:Localized(@"Please Enter Password")];
        
    } else {
        [self makePostCallForPage:LOGIN withParams:@{@"email":self.emailAddressFld.text, @"password":self.passwordFld.text} withRequestCode:1];
    }
}

-(void)parseResult:(id)result withCode:(int)reqeustCode
{
    if (requestCode == 1) {
        
        NSString *userId = [result valueForKey:@"member_id"];
        NSUserDefaults *memberId = [NSUserDefaults standardUserDefaults];
        [memberId setObject:userId forKey:@"customer_id"];
        [memberId synchronize];
        
        NSString *userName = [result valueForKey:@"name"];
        NSUserDefaults *membername = [NSUserDefaults standardUserDefaults];
        [membername setObject:userName forKey:@"userName"];
        [membername synchronize];
        
        NSString *email = [result valueForKey:@"email"];
        NSUserDefaults *emailID = [NSUserDefaults standardUserDefaults];
        [emailID setObject:email forKey:@"Email"];
        [emailID synchronize];


        
        NSLog(@"Result is %@", result);
        
        if ([[result valueForKey:@"status"]isEqualToString:@"Success"]) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[result valueForKey:@"status"] preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [alertController dismissViewControllerAnimated:YES completion:^{
                    
                    if ([_fromOfficial isEqualToString:@"fromOfficial"]) {
                        
                        [self.navigationController popViewControllerAnimated:NO];
                    }
                    else{
                        HomeViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
                        [self.navigationController pushViewController:obj animated:YES];

                    }
                    
                }];
                
            });
        }
        else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[result valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [alertController dismissViewControllerAnimated:YES completion:^{
                    // Do something
                    
                }];
                
            });
        }
    }
    
    if ([[result valueForKey:@"status"]isEqualToString:@"Success"]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[result valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [alertController dismissViewControllerAnimated:YES completion:^{
                
                [self signUpViewHidden];
                
            }];
            
        });
    }
    else{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[result valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [alertController dismissViewControllerAnimated:YES completion:^{
                
                _signUpView.hidden = NO;
                
                [self signUpViewNotHidden];
                
            }];
            
        });
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault];//UIImageNamed:@"transparent.png"
//    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
//    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.view.backgroundColor = [UIColor clearColor];
}

- (IBAction)signUpSignUpBtnClicked:(id)sender {
    
     [self signUpViewNotHidden];
}

- (IBAction)signUploginBtnClicked:(id)sender {
    
    [self signUpViewHidden];
}

- (IBAction)signUpMainBtnClicked:(id)sender {
    
    if ([self.firstNameFld.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"Please Enter First Name")];
        
        //[self showErrorAlertWithMessage:Localized(@"empty_email")];
    } else if ([self.lastNameFld.text length] == 0) {
        
        [self showErrorAlertWithMessage:Localized(@"Please enter last name")];
        //  [self showErrorAlertWithMessage:Localized(@"empty_password")];
    }
    else if ([self.signUpEmailFld.text length] == 0) {
        [self showErrorAlertWithMessage:Localized(@"Please Enter email address")];
        //  [self showErrorAlertWithMessage:Localized(@"empty_password")];
    }
    else if (![emailTest evaluateWithObject:_signUpEmailFld.text] == YES)
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:Localized(@"Alert") message:Localized(@"Please enter valid email") preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *button=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
        
        [alert addAction:button];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ([self.signUppasswordFld.text length] == 0) {
        
        [self showErrorAlertWithMessage:Localized(@"Please Enter Password")];
        //  [self showErrorAlertWithMessage:Localized(@"empty_password")];
    }
    else if ([self.confirmPasswordFld.text length] == 0) {
        
        [self showErrorAlertWithMessage:Localized(@"Please Enter confirm password")];
        //  [self showErrorAlertWithMessage:Localized(@"empty_password")];
    }
    else if (![_signUppasswordFld.text isEqual:_confirmPasswordFld.text]) {
        
        [self showErrorAlertWithMessage:Localized(@"Password do not match")];
    }
    else if ([self.phoneFld.text length] == 0) {
        
        [self showErrorAlertWithMessage:Localized(@"Please Enter Mobile Number")];
        //  [self showErrorAlertWithMessage:Localized(@"empty_password")];
    }
    else if([_phoneFld.text length]<8){
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Warning" message:@"Please enter  Valid Phone No." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *button=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
        [alert addAction:button];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else {
        
        [self showHUD:@""];
        
        [self makePostCallForPage:REGISTER withParams:@{@"fname":self.firstNameFld.text, @"lname":self.lastNameFld.text, @"email":self.signUpEmailFld.text, @"password":self.signUppasswordFld.text,@"phone":self.phoneFld.text,@"cpassword":_confirmPasswordFld.text} withRequestCode:120];
    }
}

-(void)signUpViewHidden{
    
    _signUpLogin.hidden = YES;
    _signUpSignUp.hidden = YES;
    _signUpMainBtn.hidden = YES;
    _firstNameFld.hidden = YES;
    _lastNameFld.hidden = YES;
    _phoneFld.hidden = YES;
    _signUpEmailFld.hidden = YES;
    _signUppasswordFld.hidden = YES;
    _confirmPasswordFld.hidden = YES;
    _firstNameLbl.hidden = YES;
    _lastNameLbl.hidden = YES;
    _emialLbl.hidden = YES;
    _phoneLbl.hidden = YES;
    _paswwordLbl.hidden = YES;
    _confirmPswdLbl.hidden = YES;
    _signUpLogo.hidden = YES;
    _signUpView.hidden = YES;
    _signUpBackground.hidden = YES;
}
-(void)signUpViewNotHidden{
    
    [_signUpSignUp.layer setCornerRadius: 5.0f];
    [_signUpSignUp.layer setBorderWidth:0.0f];
    [_signUpSignUp.layer setMasksToBounds:YES];
    
    [_signUpMainBtn.layer setCornerRadius: 5.0f];
    [_signUpMainBtn.layer setBorderWidth:0.0f];
    [_signUpMainBtn.layer setMasksToBounds:YES];
    
    [_signUpLogin.layer setCornerRadius: 5.0f];
    [_signUpLogin.layer setBorderWidth:2.0f];
    [_signUpLogin.layer setMasksToBounds:YES];
    [_signUpLogin.layer setBorderColor:[UIColor colorWithRed:245.0f/255.0f green:190.0f/255.0f blue:74.0f/255.0f alpha:1].CGColor];
    
    _signUpLogin.hidden = NO;
    _signUpSignUp.hidden = NO;
    _signUpMainBtn.hidden = NO;
    _firstNameFld.hidden = NO;
    _lastNameFld.hidden = NO;
    _phoneFld.hidden = NO;
    _signUpEmailFld.hidden = NO;
    _signUppasswordFld.hidden = NO;
    _confirmPasswordFld.hidden = NO;
    _firstNameLbl.hidden = NO;
    _lastNameLbl.hidden = NO;
    _emialLbl.hidden = NO;
    _phoneLbl.hidden = NO;
    _paswwordLbl.hidden = NO;
    _confirmPswdLbl.hidden = NO;
    _signUpLogo.hidden = NO;
    _signUpView.hidden = NO;
    _signUpBackground.hidden = NO;
}

- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _phoneFld) {
        
        NSInteger length = [_phoneFld.text length];
        if (length>7 && ![string isEqualToString:@""]) {
            return NO;
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([_phoneFld.text length]>7) {
                _phoneFld.text = [_phoneFld.text substringToIndex:8];
                
            }
        });
        
        return YES;
        
    }
    else{
        return YES;
    }
}

-(void)doneWithNumberPad{
    
    [self.view endEditing:YES];
}

- (IBAction)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    // [self.view endEditing:NO];
    [_phoneFld resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [_phoneFld resignFirstResponder];
}
@end
