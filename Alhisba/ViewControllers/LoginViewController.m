//
//  LoginViewController.m
//  Alhisba
//
//  Created by apple on 04/12/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "Common.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self strToCurrencyFormatter:@"200012312"];

    self.userName.text=@"";
    self.password.text=@"";
    self.userName.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:Localized(@"UserName")
     attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:233.0f/255.0f green:236.0f/255.0f blue:239.0f/255.0f alpha:1]}];
    self.password.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:Localized(@"Password")
     attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:233.0f/255.0f green:236.0f/255.0f blue:239.0f/255.0f alpha:1]}];
    self.submitBtn.layer.cornerRadius = self.submitBtn.frame.size.height/2;
    self.submitBtn.clipsToBounds = YES;
    self.submitBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.submitBtn.layer.borderWidth = 2;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submitBtnAction:(id)sender {
    
    if ([self.userName.text length] == 0) {
        [self  showErrorAlertWithMessage:Localized(@"Please Enter User Name")];
    }else if ([self.password.text length] == 0) {
        [self  showErrorAlertWithMessage:Localized(@"Please Enter Password")];
    
    }
    else{
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [currentDefaults objectForKey:@"SETTINGS"];
    NSString *user= [dict valueForKey:@"app_username"];
    NSString *password= [dict valueForKey:@"app_password"];

    if( [_userName.text  caseInsensitiveCompare:user] == NSOrderedSame ) {
        // strings are equal except for possibly case
         if( [_password.text  caseInsensitiveCompare:password] == NSOrderedSame ) {
             [APP_DELEGATE downloadSettingsWithOutLOCK];
         }else{
             [self  showErrorAlertWithMessage:Localized(@"Please Enter Valid User Name")];

         }
    }else{
        [self  showErrorAlertWithMessage:Localized(@"Please Enter Valid Password")];
    }
    }
}
@end
