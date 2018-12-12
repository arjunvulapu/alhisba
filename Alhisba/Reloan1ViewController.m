//
//  Reloan1ViewController.m
//  Alhisba
//
//  Created by apple on 10/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "Reloan1ViewController.h"
#import "JBWhatsAppActivity.h"
#import <GoogleAnalytics/GAI.h>
#import <GoogleAnalytics/GAIDictionaryBuilder.h>
#import <GoogleAnalytics/GAIFields.h>

@interface Reloan1ViewController ()<UIScrollViewDelegate>{
    
    UIButton *menuBtn,*backBtn;
}

@end

@implementation Reloan1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _scollView.delegate = self;
    
    self.navigationItem.title = Localized(@"Re Loan calculator");
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:20.0],NSFontAttributeName,nil];
    
    menuBtn = [[UIButton alloc] init];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
    menuBtn.frame = CGRectMake(0, 0, 30, 30);
     [menuBtn addTarget:self action:@selector(shareBtnTapped) forControlEvents:UIControlEventTouchUpInside];
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
    
    _topView.layer.cornerRadius = 15.0f;
    _previewPop.layer.cornerRadius = 15.0f;
    _scollView.layer.cornerRadius = 15.0f;
    _topView.clipsToBounds =YES;
    _previewPop.clipsToBounds =YES;
    _scollView.clipsToBounds =YES;

    _estimatedPriceValue.layer.cornerRadius = 15.0f;
    _estimatedPriceValue.layer.masksToBounds = YES;
    [_lastUpdateonLbl setTextAlignment:NSTextAlignmentCenter];
    [_estimatedPriceValue setTextAlignment:NSTextAlignmentCenter];
    
    NSLog(@"area title is %@",_areaTitle1);
    
    _areaTitle.text = [NSString stringWithFormat:@"%@",_areaTitle1];
    _landSizeTitle.text = [NSString stringWithFormat:@"%@",_landSizeTitle1];
    _streetTitle.text = [NSString stringWithFormat:@"%@",_streetTitle1];
    _locationTitle.text = [NSString stringWithFormat:@"%@",_locationTitle1];
    _buildingAgeTitle.text = [NSString stringWithFormat:@"%@",_buildingAgeTitle1];
    _finishingQualityTitle.text = [NSString stringWithFormat:@"%@",_finishingQualityTitle1];
    _basementTitle.text = [NSString stringWithFormat:@"%@",_basementTitle1];
    _noOffloorsTitle.text = [NSString stringWithFormat:@"%@",_noOffloorsTitle1];
    _seaFrontTitle.text = [NSString stringWithFormat:@"%@",_seaFrontTitle1];
    _backStreetTitle.text = [NSString stringWithFormat:@"%@",_backStreetTitle1];
   _directionTitle.text = [NSString stringWithFormat:@"%@",_directionTitle1];
   _curbTitle.text = [NSString stringWithFormat:@"%@",_curbTitle1];
   _estimatedPriceValue.text = [NSString stringWithFormat:@"%@ %@",Localized(@"KD"),[_dict valueForKey:@"emi"]];
    _landValue.text = [NSString stringWithFormat:@"%@",_landValue1];
    
    
    if ([_landSpecsTitle1 length] == 0){
     
        _landSpecsTitle1 = @"";
    }
    if ([_plotSpecsTitles1 length]==0){
      
        _plotSpecsTitles1 = @"";
    }
    if ([_facingSpecsTitles1 length]==0){
        
       _facingSpecsTitles1 = @"";
    }
    
    _buildingValue.text = [NSString stringWithFormat:@"%@",_buildingValue1];
    _landSpecsTitle.text = [NSString stringWithFormat:@"%@",_landSpecsTitle1];
    _plotSpecsTitles.text = [NSString stringWithFormat:@"%@",_plotSpecsTitles1];
   _facingSpecsTitles.text = [NSString stringWithFormat:@"%@",_facingSpecsTitles1];
    
    
    self.estimatedPriceLbl.text = [NSString stringWithFormat:@"%@",[_dict valueForKey:@"emi"]];
    self.landValue.text =[NSString stringWithFormat:@"%@",[_dict valueForKey:@"tot_purchase"]];
    self.buildingValue.text =[NSString stringWithFormat:@"%@",[_dict valueForKey:@"bank_profit"]];
    self.loanDurationResultLbl.text =[NSString stringWithFormat:@"%@",[_dict valueForKey:@"term"]];
    
    [self settextAlignment:_estimatedPriceValue];
    [self settextAlignment:_areaTitle];
    [self settextAlignment:_landSizeTitle];
    [self settextAlignment:_streetTitle];
    [self settextAlignment:_locationTitle];
    [self settextAlignment:_buildingAgeTitle];
    [self settextAlignment:_finishingQualityTitle];
    [self settextAlignment:_basementTitle];
    [self settextAlignment:_noOffloorsTitle];
    [self settextAlignment:_seaFrontTitle];
    [self settextAlignment:_backStreetTitle];
    [self settextAlignment:_directionTitle];
    [self settextAlignment:_curbTitle];
    
    [self settextAlignment:_previewAreaLbl];
    [self settextAlignment:_previewLandSizeLbl];
    [self settextAlignment:_previewstreetLbl];
    [self settextAlignment:_previewLocationLbl];
    [self settextAlignment:_previewbuildingAgeLbl];
    [self settextAlignment:_previewfinishingQuali];
    [self settextAlignment:_previewbasementLlb];
    [self settextAlignment:_previewnoOfFloors];
    [self settextAlignment:_previewSeaFrontLbl];
    [self settextAlignment:_previewbackStreetLenght];
    [self settextAlignment:_previewDirectionLbl];
    [self settextAlignment:_previewCurbFld];
    [self settextAlignment:_previewDetailsLbl];
    [self settextAlignment:_totalProperty];
    [self settextAlignment:_totalProperty2];

    [_scollView setShowsVerticalScrollIndicator:YES];
    
//    _lastUpdateonLbl.text = [NSString stringWithFormat:@"%@ %@",Localized(@"Area values were last update on:"),_date];
    _lastUpdateonLbl.text = [NSString stringWithFormat:@"%@",Localized(@"Installment Amount (KD)")];

    _totalProperty.text = Localized(@"Total Property Value");
    _totalProperty2.text = Localized(@"Total Property Value");

    _landValueLbl.text = Localized(@"Total Property Value(KD)");
    _buildingValueLbl.text = Localized(@"Bank Profilt (KD)");
    _LoanDurationLbl.text = Localized(@"Loan Duration");
    _previewAreaLbl.text = Localized(@"Property Value (KD)");
    _previewLandSizeLbl.text = Localized(@"Land Size(Sqm)");
    _previewstreetLbl.text = Localized(@"Down Payment (KD)");
    _previewLocationLbl.text = Localized(@"Down Payment (%)");
    _previewbuildingAgeLbl.text = Localized(@"Loan Amount");
    _previewfinishingQuali.text = Localized(@"Annual Profit Rate (%)");
    _previewbasementLlb.text =  Localized(@"Grace Period");
    _previewnoOfFloors.text = Localized(@"Repayment Period");
    _previewSeaFrontLbl.text = Localized(@"Installment Type");
    _previewbackStreetLenght.text = Localized(@"No Of Payments");
    
    
    //        [self settextAlignment:_previewAreaLbl];
    //        [self settextAlignment:_previewLandSizeLbl];
    //        [self settextAlignment:_previewstreetLbl];
    //        [self settextAlignment:_previewLocationLbl];
    //        [self settextAlignment:_previewbuildingAgeLbl];
    //        [self settextAlignment:_previewfinishingQuali];
    //        [self settextAlignment:_previewbasementLlb];
    //        [self settextAlignment:_previewnoOfFloors];
    //        [self settextAlignment:_previewSeaFrontLbl];
    //        [self settextAlignment:_previewbackStreetLenght];
    //        [self settextAlignment:_previewDirectionLbl];
    //        [self settextAlignment:_previewCurbFld];
    //        [self settextAlignment:_previewDetailsLbl];

}
-(void)viewWillAppear:(BOOL)animated{
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"RELOANCALCULATOR RESULT SCREEN"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}
-(void)shareBtnTapped{
    
    
    
    
//    WhatsAppMessage *whatsappMsg = [[WhatsAppMessage alloc] initWithMessage:[NSString stringWithFormat:@"%@",_estimatedPriceValue1] forABID:@"Alhisba"];
//
//    NSArray *applicationActivities = @[[[JBWhatsAppActivity alloc] init]];
//    NSArray *excludedActivities    = @[UIActivityTypePrint, UIActivityTypePostToWeibo, UIActivityTypeMessage];
//    NSArray *activityItems         = @[[NSString stringWithFormat:@"%@",_estimatedPriceValue1], whatsappMsg];
//
//    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:applicationActivities];
//    activityViewController.excludedActivityTypes = excludedActivities;
//
//    [self presentViewController:activityViewController animated:YES completion:^{}];
    
    
    
    UIImage *imageToShare = [self captureView:_sharedView inSize:_sharedView.frame.size];
    
    
    NSMutableArray *activityItems = [NSMutableArray arrayWithObjects: imageToShare, nil];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[
                                                     UIActivityTypePrint,
                                                     UIActivityTypeCopyToPasteboard,
                                                     UIActivityTypeAssignToContact,
                                                     UIActivityTypeSaveToCameraRoll,
                                                     UIActivityTypeAddToReadingList,
                                                     UIActivityTypeAirDrop];
    
    
    [self presentViewController:activityViewController animated:YES completion:nil];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView1
{
    //get refrence of vertical indicator
    UIImageView *verticalIndicator = ((UIImageView *)[_scollView.subviews objectAtIndex:(_scollView.subviews.count-1)]);
    //set color to vertical indicator
    [verticalIndicator setBackgroundColor:[UIColor yellowColor]];
}


-(void)backBtnTapped{
    
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)settextAlignment:(UILabel *)label{
    
    [label setTextAlignment:NSTextAlignmentCenter];
}


@end
