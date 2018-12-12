//
//  AboutUsViewController.m
//  Bloomego
//
//  Created by apple on 29/06/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "AboutUsViewController.h"
#import "SWRevealViewController.h"
#import "SVProgressHUD.h"
#import "HomeViewController.h"

@interface AboutUsViewController (){
    
    UIButton *backBtn,*menuBtn;
    SWRevealViewController *revealViewController;
    NSString *htmlString;
}

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    UIImage *image = [UIImage imageNamed: @"NavImage.png"];
    [navigationBar setBackgroundImage:image forBarMetrics: UIBarMetricsDefault];
    self.navigationItem.title = Localized(@"About Us");
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    //UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    ////UIImageNamed:@"transparent.png"
    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidArabicKufi-Bold"size:20.0],NSFontAttributeName,nil];
    }
    else{
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
    }
    
    //    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:9.0f/255.0f green:97.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
    //    self.navigationController.navigationBar.translucent = NO;

    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"back-whiteright.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 20, 20);
        [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *customBarRightBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:customBarRightBtn,nil];
  }
    else{
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"back-white.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 20, 20);
        [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *customBarRightBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:customBarRightBtn,nil];
    }
    
  //  [self customSetup];
    
    [self showHUD:@""];
    _textviewT.text=@"";
    [self makePostCallForPage:SETTINGS withParams:@{} withRequestCode:23];
}

//- (void)customSetup
//{
//    revealViewController = self.revealViewController;
//    if ( revealViewController )
//    {
//        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
//
//            [menuBtn addTarget:self.revealViewController action:@selector(rightRevealToggle:) forControlEvents:UIControlEventTouchUpInside];
//
//            self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-100;
//
//        }else{
//            [menuBtn addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
//
//            self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-100;
//        }
//        [self.view addGestureRecognizer: self.revealViewController.tapGestureRecognizer];
//    }
//}

-(void)parseResult:(id)result withCode:(int)reqeustCode {
    if(reqeustCode==23){
        //        _textviewT.text=[result valueForKey:@"terms_conditions"];
        
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            htmlString = [result valueForKey:@"about_ar"];
        }
        else{
            htmlString = [result valueForKey:@"about"];
        }
         htmlString = [self stringByStrippingHTML:htmlString];

        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                initWithData: [htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                                options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                documentAttributes: nil
                                                error: nil
                                                ];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, attributedString.length)];
        NSMutableParagraphStyle *paragraphStyles = [[NSMutableParagraphStyle alloc] init];
        paragraphStyles.alignment = NSTextAlignmentJustified;
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyles range:NSMakeRange(0, attributedString.length)];

        _textviewT.attributedText = attributedString;
        _textviewT.textColor = [UIColor whiteColor];
    }
    [self hideHUD];
}



-(NSString *)stringByStrippingHTML:(NSString*)str
{
    NSRange r;
    while ((r = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location     != NSNotFound)
    {
        str = [str stringByReplacingCharactersInRange:r withString:@""];
    }
    return str;
}
-(void)goBack{
    
   // [self.navigationController popViewControllerAnimated:YES];

    HomeViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    [self.navigationController pushViewController:obj animated:YES];
}

#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}

@end
