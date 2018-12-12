//
//  ContactUsViewController.m
//  Bloomego
//
//  Created by apple on 08/01/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ContactUsViewController.h"
#import "SVProgressHUD.h"
#import "HomeViewController.h"
#import <MessageUI/MessageUI.h>

@interface ContactUsViewController ()<UITextFieldDelegate,MFMailComposeViewControllerDelegate,UITextViewDelegate>{
    
    UIButton *backButton,*cartButton;
    NSMutableArray *contactDetailsArray;
    NSString *latString,*longString;
}

@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = Localized(@"Contact Us");
    
    _nameFld.delegate = self;
    _emailFld.delegate = self;
    _phoneFld.delegate = self;
    _messageView.delegate = self;
    [ _phoneView setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
//    [_submitBtn.layer setCornerRadius:10.0];//Set corner radius of label to change the shape.
    [_submitBtn setClipsToBounds:YES];//Set its to YES for Corner radius to work.
    
    [self.messageView setText:@"Please enter your message here"];
    
    _submitBtn.layer.cornerRadius = 15.0f;

    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    UIImage *image = [UIImage imageNamed: @"NavImage.png"];
    [navigationBar setBackgroundImage:image forBarMetrics: UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    //UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    ////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];

    UIColor *color = [UIColor whiteColor];
    _nameFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Name") attributes:@{NSForegroundColorAttributeName: color}];
    _emailFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Email Address") attributes:@{NSForegroundColorAttributeName: color  }];
    _phoneFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Localized(@"Mobile Number") attributes:@{NSForegroundColorAttributeName: color  }];
    
    _messageView.layer.masksToBounds=YES;
    _messageView.layer.borderWidth= 1.0f;
    _messageView.layer.borderColor=[[UIColor whiteColor]CGColor];
    
    _messageView.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",Localized(@"Please enter message")]];
    [_messageView setTextColor:[UIColor whiteColor]];
    
    _submitBtn.titleLabel.text = Localized(@"Submit");
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer setWidth:-10];
    
    
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:Localized(@"Done")
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    _phoneFld.inputAccessoryView = keyboardDoneButtonView;

    
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
    // Cart Button...
    
    cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cartButton setImage:[UIImage imageNamed:@"cart-white.png"] forState:UIControlStateNormal];
    [cartButton addTarget:self action:@selector(cartBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    cartButton.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *customBarRightBtn3 = [[UIBarButtonItem alloc] initWithCustomView:cartButton];
   // self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,customBarRightBtn3,nil];
    
    [_submitBtn setTitle:Localized(@"Submit") forState:UIControlStateNormal];
    
    [self showHUD:@""];
    [self makePostCallForPage:CONTACT withParams:@{} withRequestCode:23];

}

-(void)backBtnClicked{
 
//    [self.navigationController popViewControllerAnimated:YES];
    
    HomeViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    [self.navigationController pushViewController:obj animated:NO];
}

-(void)cartBtnClicked{
//    CartViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"CartViewController"];
//    obj.fromDetails = @"fromDetails";
//    [self.navigationController pushViewController:obj animated:YES];
}

- (IBAction)submitBtnClicked:(id)sender {
    
    if ([self.nameFld.text length] == 0) {
        [self showErrorAlertWithMessage:@"Please Enter name"];
    }
    else if ([self.emailFld.text length] == 0) {
        [self showErrorAlertWithMessage:@"Please Enter email address"];
    }
    else if ([self.phoneFld.text length] == 0) {
        [self showErrorAlertWithMessage:@"Please Enter phone no"];
    }
    else if ([self.messageView.text length] == 0) {
        [self showErrorAlertWithMessage:@"Please Enter message"];
    }
    else {
        [self makePostCallForPage:CONTACT_US withParams:@{@"name":self.nameFld.text,@"email":self.emailFld.text,@"phone":self.phoneFld.text,@"message":self.messageView.text} withRequestCode:1];
    }
}

-(void)parseResult:(id)result withCode:(int)reqeustCode
{
    if (reqeustCode == 23) {
        
        contactDetailsArray = result;
        
        _mobileNoLbl.text = [contactDetailsArray valueForKey:@"phone_no"];
        _emailLbl.text = [contactDetailsArray valueForKey:@"email"];
        _weblinkLbl.text = [contactDetailsArray valueForKey:@"website"];
        _timeLbl.text = [contactDetailsArray valueForKey:@"timing_english"];
        _locationInfoLbl.text = [contactDetailsArray valueForKey:@"address_english"];
        
        latString = [contactDetailsArray valueForKey:@"lattitude"];
        longString = [contactDetailsArray valueForKey:@"longitude"];
        
        MKPointAnnotation*    annotation = [[MKPointAnnotation alloc] init];
        CLLocationCoordinate2D myCoordinate;
        myCoordinate.latitude=[latString floatValue];
        myCoordinate.longitude=[longString floatValue];
        annotation.coordinate = myCoordinate;
        // annotation.title=[dic valueForKey:@"title"];
        annotation.subtitle=@"";
        
        [_mapView setZoomEnabled:YES];
        [_mapView setScrollEnabled:YES];
        MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
        region.center.latitude = [latString floatValue];
        region.center.longitude = [longString floatValue];
        region.span.longitudeDelta = 10.0f;
        region.span.latitudeDelta = 10.0f;
        [_mapView setRegion:region animated:NO];
        [self.mapView addAnnotation:annotation];

    }
    else{
     
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[result valueForKey:@"status"] message:[result valueForKey:@"message"]preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [alertController dismissViewControllerAnimated:YES completion:^{
                
                if ([[result valueForKey:@"status"]isEqualToString:@"Success"]) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
                else{
                    
                }
                
            }];
            
        });
    }
    [self hideHUD];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

- (IBAction)callingBtnTapped:(id)sender {
    
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:_mobileNoLbl.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

- (IBAction)mailBtnTapped:(id)sender {
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
        [composeViewController setMailComposeDelegate:self];
        [composeViewController setToRecipients:@[@"info@alhisba.com"]];
        [composeViewController setSubject:@"example subject"];
        [self presentViewController:composeViewController animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)webLinkBtnTapped:(id)sender {
    
    NSString* text = _weblinkLbl.text;
    NSURL*    url  = [[NSURL alloc] initWithString:text];
    
    if (url.scheme.length == 0)
    {
        text = [@"http://" stringByAppendingString:text];
        url  = [[NSURL alloc] initWithString:text];
    }
    
    [[UIApplication sharedApplication] openURL:url];
}



- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _phoneFld) {
        
        NSInteger length = [_phoneFld.text length];
        if (length>7 && ![string isEqualToString:@""]) {
            return NO;
        }dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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


-(void)textViewDidBeginEditing:(UITextView *)textView
{
    _messageView.text=@"";
    self.messageView.textColor = [UIColor blackColor];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        
        _messageView.text=@"Please enter your message here";
        self.messageView.textColor = [UIColor whiteColor];
        
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        
        UIColor *color = [UIColor whiteColor];
        
        NSAttributedString *string = [[NSAttributedString alloc]initWithString:self.messageView.text attributes:@{NSForegroundColorAttributeName:color}];
        self.messageView.attributedText = string;
        [_messageView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}


#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}
@end
