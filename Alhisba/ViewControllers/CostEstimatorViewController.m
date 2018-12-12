//
//  CostEstimatorViewController.m
//  Alhisba
//
//  Created by apple on 25/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "CostEstimatorViewController.h"
#import "SVProgressHUD.h"
#import "SWRevealViewController.h"
#import "HomeViewController.h"
#import <GoogleAnalytics/GAI.h>
#import <GoogleAnalytics/GAIDictionaryBuilder.h>
#import <GoogleAnalytics/GAIFields.h>
@interface CostEstimatorViewController ()<UIWebViewDelegate>{
    UIButton *menuBtn,*backBtn;
    NSString *finalUrl;
    SWRevealViewController *revealViewController;
    NSString *dType;
}

@end

@implementation CostEstimatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];//UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
        
        switch ((int)[[UIScreen mainScreen] nativeBounds].size.height) {
                
            case 1136:
                printf("iPhone 5 or 5S or 5C");
                _webViewTop.constant=-64;
                _webViewBottom.constant=0;
                dType=@"iPhone5";
                break;
            case 1334:
                printf("iPhone 6/6S/7/8");
                _webViewTop.constant=-64;
                _webViewBottom.constant=0;
                 dType=@"iPhone6";
                break;
            case 1920:
                printf("iPhone 6+/6S+/7+/8+");
                _webViewTop.constant=-64;
                _webViewBottom.constant=0;
                 dType=@"iPhone6+";
                break;
            case 2436:
                printf("iPhone X, Xs");
                _webViewTop.constant=-90;
                _webViewBottom.constant=-34;
                 dType=@"iPhoneX";
                break;
            case 2688:
                printf("iPhone Xs Max");
                _webViewTop.constant=-90;
                _webViewBottom.constant=-34;
                 dType=@"iPhoneX";
                 break;
            case 1792:
                printf("iPhone Xr");
                _webViewTop.constant=-90;
                _webViewBottom.constant=-34;
                 dType=@"iPhoneX";
                 break;
            default:
                _webViewTop.constant=-64;
                _webViewBottom.constant=0;
                printf("unknown");
        }
    }
self.navigationItem.title = Localized(@"Cost Estimator");
self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];

    menuBtn = [[UIButton alloc] init];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    menuBtn.frame = CGRectMake(0, 0, 30, 30);
// [menuBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    self.navigationItem.rightBarButtonItem = backBarButtonItem;

if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
    backBtn = [[UIButton alloc] init];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back-whiteright.png"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    [backBtn addTarget:self action:@selector(backBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backBarButtonItem1;
}
else{
    
    backBtn = [[UIButton alloc] init];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back-white.png"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    [backBtn addTarget:self action:@selector(backBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backBarButtonItem1;
}
    
//    [[[self.webView subviews] lastObject] setScrollingEnabled:NO];
    
    [self showHUD:@"Loading"];

    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        finalUrl = [NSString stringWithFormat:@"http://alhisba.com/cost_estimator.php?lang=ar&dtype=%@",dType];
    }
    else{
        finalUrl = [NSString stringWithFormat:@"http://alhisba.com/cost_estimator.php?lang=en&dtype=%@",dType];
    }
    [self customSetup];
    
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:finalUrl]]];
    [self hideHUD];
}
-(void)viewWillAppear:(BOOL)animated{
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"CONSTRUCTION COSTESTIMATOR SCREEN"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}
- (void)customSetup
{
    [menuBtn removeTarget:nil action:nil forControlEvents:UIControlEventAllEvents];
    revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            
            //            [menuBtn addTarget:self.revealViewController action:@selector(rightRevealToggle:) forControlEvents:UIControlEventTouchUpInside];
            //            self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-120;
            
            [menuBtn addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
            
            if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
                
                switch ((int)[[UIScreen mainScreen] nativeBounds].size.height) {
                        
                    case 1920:
                        printf("iPhone 6+/6S+/7+/8+");
                        // self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-135;
                        self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-100;
                        break;
                    case 2436:
                        printf("iPhone X");
                        self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-90;
                        break;
                    case 2688:
                        printf("iPhone Xs Max");
                        self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-100;
                        
                        break;
                    default:
                        self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-90;
                        printf("unknown");
                }
            }
            
        }else{
            
            [menuBtn addTarget:self.revealViewController action:@selector(rightRevealToggle:) forControlEvents:UIControlEventTouchUpInside];
            
            if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
                
                switch ((int)[[UIScreen mainScreen] nativeBounds].size.height) {
                        
                    case 1920:
                        printf("iPhone 6+/6S+/7+/8+");
                        //  self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-135;
                        self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-100;
                        break;
                    case 2436:
                        printf("iPhone X");
                        self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-100;
                        break;
                    case 2688:
                        printf("iPhone Xs Max");
                        self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-100;
                        
                        break;
                    default:
                        self.revealViewController.rightViewRevealWidth = self.view.frame.size.width-100;
                        printf("unknown");
                }
            }
            
        }
        [self.view addGestureRecognizer: self.revealViewController.tapGestureRecognizer];
    }
}


-(void)backBtnTapped{
    
    if ([_fromMenu isEqualToString:@"menu"]) {
        
        HomeViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else{
        [self.navigationController popViewControllerAnimated:NO];
    }}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}


@end
