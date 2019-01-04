//
//  HomeViewController.m
//  Alhisba
//
//  Created by apple on 18/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCollectionViewCell.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "SVProgressHUD.h"
#import "RegisterdTradesViewController.h"
#import "SWRevealViewController.h"
#import "ReloanCalculatorViewController.h"
#import "AuctionsViewController.h"
#import "CostEstimatorViewController.h"
#import "OfficialApraisalViewController.h"
#import "instantValueEstimatorViewController.h"
#import "MKPersianFont.h"
#import <GoogleAnalytics/GAI.h>
#import <GoogleAnalytics/GAIDictionaryBuilder.h>
#import <GoogleAnalytics/GAIFields.h>
#import "ZHPopupView.h"
#import "UIViewController+MJPopupViewController.h"
#import "PopViewControllerDelegate.h"
#import "ShowPopupViewController.h"
#define APP_DELEGATE (AppDelegate *) [[UIApplication sharedApplication] delegate]

@interface HomeViewController (){
    UIButton *menuBtn,*lanBtn;
    NSMutableArray *resultArray;
    SWRevealViewController *revealViewController;
    CGFloat height;
    HomeCollectionViewCell *heightcell;
    MKPersianFont *myFont;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    resultArray = [[NSMutableArray alloc] init];
    myFont = [[MKPersianFont alloc]init];
    
    
    
    if(![[[NSUserDefaults standardUserDefaults] valueForKey:@"INSTALLED"] isEqualToString:@"YES"]){
        [self showTCpopup];
       
    }
 //   [self showTCpopup];
//    UIImage *image = [UIImage imageNamed:@"logo.png"];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 160, 160)];
////    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
//    [imageView setImage:image];
//    [imageView.widthAnchor constraintEqualToConstant:160].active = YES;
//    [imageView.heightAnchor constraintEqualToConstant:160].active = YES;
//    [imageView setContentMode:UIViewContentModeScaleAspectFill];
//    self.navigationItem.titleView = imageView;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];//UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    menuBtn = [[UIButton alloc] init];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    menuBtn.frame = CGRectMake(0, 0, 30, 30);
    // [menuBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    self.navigationItem.rightBarButtonItem = backBarButtonItem;
    
    lanBtn = [[UIButton alloc] init];
    lanBtn.frame = CGRectMake(0, 0, 50, 30);
     [lanBtn addTarget:self action:@selector(languageBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        [lanBtn setTitle:Localized(@"Language") forState:UIControlStateNormal];
    }
    else{
        [lanBtn setTitle:Localized(@"Language") forState:UIControlStateNormal];
    }
    
    UIBarButtonItem *backBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:lanBtn];
    self.navigationItem.leftBarButtonItem = backBarButtonItem1;
    
    [self customSetup];
    [self showHUD:@""];
    [self makePostCallForPage:SERVICES withParams:@{} withRequestCode:1];
}
-(void)showTCpopup{
    
    //NSDictionary *dict = [[NSUserDefaults standardUserDefaults] valueForKey:@"SETTINGS"];
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
//    NSData *data = [currentDefaults objectForKey:@"SETTINGS"];
    NSDictionary *dict = [currentDefaults objectForKey:@"SETTINGS"];
    NSAttributedString *str = @"";
    //    if([[Utils getLanguage] isEqual:KEY_LANGUAGE_AR]){
    //        str = [dict valueForKey:@"terms_ar"];
    //    }else{
    //        str = [dict valueForKey:@"terms"];
    //
    //    }
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        NSString *htmlString = [dict valueForKey:@"privacy_policy_app_ar"];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                       initWithData: [htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                                       options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                       documentAttributes: nil
                                                       error: nil
                                                       ];
        str = attributedString;
        
    } else {
        NSString *htmlString = [dict valueForKey:@"privacy_policy_app"];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                       initWithData: [htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                                       options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, }
                                                       documentAttributes: nil
                                                       error: nil
                                                       ];
        str = attributedString;
        
        
    }
   
    
    ShowPopupViewController *vc = [[ShowPopupViewController alloc] initWithNibName:@"ShowPopupViewController" bundle:nil];
    vc.delegate=self;
    vc.pptext = str;
    //    [self.navigationController pushViewController:vc animated:YES];
    vc.completionBlock2 = ^(NSString *area) {
        NSLog(@"%@",area);
       
        [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"INSTALLED"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    };
    
    [self presentPopupViewController:vc animationType:MJPopupViewAnimationSlideBottomTop dismissed:nil];
}
- (void)cancelButtonClicked:(UIViewController *)secondDetailViewController {
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
}


-(void)viewWillAppear:(BOOL)animated{
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"HOME SCREEN"];
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

#pragma Language button Clicked....

-(void)languageBtnTapped{
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_EN]) {
        [Utils setLanguage:KEY_LANGUAGE_AR];
        [[MCLocalization sharedInstance] setLanguage:KEY_LANGUAGE_AR];
        [lanBtn setTitle:Localized(@"Language") forState:UIControlStateNormal];
    } else {
        [Utils setLanguage:KEY_LANGUAGE_EN];
        [[MCLocalization sharedInstance] setLanguage:KEY_LANGUAGE_EN];
        [lanBtn setTitle:Localized(@"Language") forState:UIControlStateNormal];
    }
    
    [APP_DELEGATE reloadUIForLanguageChange];
    [self customSetup];

    NSArray *windows = [UIApplication sharedApplication].windows;
    for (UIWindow *window in windows) {
        for (UIView *view in window.subviews) {
            [view removeFromSuperview];
            [window addSubview:view];
        }
    }


    [_collectionView reloadData];
}

#pragma Parse Function .......

-(void)parseResult:(id)result withCode:(int)reqeustCode{

//    resultArray = result;
    NSArray *array = (NSArray *)result;
    for (NSDictionary *dictionary in array) {
        [resultArray addObject:dictionary];
    }
    
    [_collectionView reloadData];
    [self hideHUD];
}


#pragma CollectionView Delegate & Data Souce Methods...

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //return resultArray.count;
    
    return resultArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
    
    cell.cellBackView.layer.borderColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.6f].CGColor;
    cell.cellBackView.layer.borderWidth = 2;
    cell.cellBackView.layer.cornerRadius = 12; // optional
    cell.cellBackView.backgroundColor = [UIColor colorWithRed:1.0f/255.0f green:33.0f/255.0f blue:72.0f/255.0f alpha:0.5f];
    [cell.tradesTitle setTextAlignment:NSTextAlignmentCenter];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
  
        dic = [resultArray objectAtIndex:indexPath.row];
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            
            cell.tradesTitle.text = [dic valueForKey:@"name_arabic"];
            
        }
        else{
            cell.tradesTitle.text = [dic valueForKey:@"name_english"];
        }
        
    
    [cell.tradesImage setImageWithURL:[dic valueForKey:@"image"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    //_collectionView.scrollEnabled = NO;
    
    cell.tradesTitle.numberOfLines = 4;
    [cell.tradesTitle setFont:[UIFont boldSystemFontOfSize:14]];
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
    [cell.tradesTitle setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:12]];
    }
    else{
        [cell.tradesTitle setFont:[UIFont fontWithName:@"DroidSans-Bold" size:12]];
    }
    
    
  return cell;

}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

//    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
//
//        switch ((int)[[UIScreen mainScreen] nativeBounds].size.height) {
//            case 1136:
//                printf("iPhone 5 or 5S or 5C");
//                height = self.view.frame.size.height-20;
//                heightcell.imageTopCollectionView.constant = 10;
//                break;
//            case 1334:
//                printf("iPhone 6/6S/7/8");
//                //                height = self.view.frame.size.height-80;
//                //                heightcell.imageTopCollectionView.constant = 10;
//                height = self.view.frame.size.height+50;
//                heightcell.imageTopCollectionView.constant = 10;
//                break;
//            case 2208:
//                printf("iPhone 6+/6S+/7+/8+");
//
//                height = self.view.frame.size.height+20;
//                heightcell.imageTopCollectionView.constant = 80;
//                break;
//            case 2436:
//                printf("iPhone X");
//                height = self.view.frame.size.height-80;
//                 heightcell.imageTopCollectionView.constant = 10;
//                 _collectionViewTop.constant = 50;
//                break;
//            case 2688:
//                printf("iPhone Xs Max");
//                 height = self.view.frame.size.height-40;
//                 heightcell.imageTopCollectionView.constant = 10;
//                _collectionViewTop.constant = 50;
//
//                break;
//            default:
//                height = self.view.frame.size.height-120;
//                printf("unknown");
//        }
//    }
    //changes
    _collectionViewTop.constant = 50;
    height = self.view.frame.size.height;
    CGFloat width  = self.view.frame.size.width;
    // in case you you want the cell to be 40% of your controllers view
//    return CGSizeMake(width/2-10, height*0.20);
    //changes
    return CGSizeMake(width/2-10,150);

}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    float cellSize = collectionView.frame.size.width/values.count;
//    return CGSizeMake(cellSize - 10, collectionView.frame.size.height);
//}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    
    dic = [resultArray objectAtIndex:indexPath.row];
    
    if ([[dic valueForKey:@"id"]  isEqual: @"2"]) {
        
        RegisterdTradesViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterdTradesViewController"];
        obj.fromHome = @"fromHome";
        [self.navigationController pushViewController:obj animated:YES];
    }
    else if ([[dic valueForKey:@"id"]  isEqual: @"1"]){
        
        instantValueEstimatorViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"instantValueEstimatorViewController"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else if ([[dic valueForKey:@"id"]  isEqual: @"6"]){
        
    AuctionsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"AuctionsViewController"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else if ([[dic valueForKey:@"id"]  isEqual: @"3"]){
        CostEstimatorViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"CostEstimatorViewController"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else if ([[dic valueForKey:@"id"]  isEqual: @"7"]){
        ReloanCalculatorViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"ReloanCalculatorViewController"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else if ([[dic valueForKey:@"id"]  isEqual: @"5"]){
//        OfficialApraisalViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"OfficialApraisalViewController"];
//        [self.navigationController pushViewController:obj animated:YES];
    }
    else{
        
    }
}

#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}

//-(void)viewWillAppear:(BOOL)animated{
//    
////    UIImage *image = [UIImage imageNamed:@"logo.png"];
////    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 120, 120)];
////    //    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
////    [imageView setImage:image];
////    [imageView.widthAnchor constraintEqualToConstant:120].active = YES;
////    [imageView.heightAnchor constraintEqualToConstant:120].active = YES;
////    [imageView setContentMode:UIViewContentModeScaleAspectFill];
////    self.navigationItem.titleView = imageView;
////
////    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
////                                                  forBarMetrics:UIBarMetricsDefault];//UIImageNamed:@"transparent.png"
////    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
////    self.navigationController.navigationBar.translucent = YES;
////    self.navigationController.view.backgroundColor = [UIColor clearColor];
//    
//}

@end
