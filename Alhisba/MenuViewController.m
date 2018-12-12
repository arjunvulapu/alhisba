//
//  MenuViewController.m
//  RevealControllerStoryboardExample
//
//  Created by Nick Hodapp on 1/9/13.
//  Copyright (c) 2013 CoDeveloper. All rights reserved.
//

#import "MenuViewController.h"
#import "Utils.h"
#import "HomeViewController.h"
#import "BaseViewController.h"
#import "SWRevealViewController.h"
#import "SVProgressHUD.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "LoginOrSignUpViewController.h"
#import "RegisterdTradesViewController.h"
#import "SWRevealViewController.h"
#import "PrivacyPolicyViewController.h"
#import "TermsofUseViewController.h"
#import "ContactUsViewController.h"
#import "FaqsViewController.h"
#import "NewViewController.h"
#import "articlesViewController.h"
#import "FaqsViewController.h"
#import "AboutUsViewController.h"
#import "ViewControllerCellHeader.h"
#import "instantValueEstimatorViewController.h"
#import "AuctionsViewController.h"
#import "CostEstimatorViewController.h"
#import "ReloanCalculatorViewController.h"
#import "OfficialApraisalViewController.h"
#import "MKPersianFont.h"


@implementation SWUITableViewCell
@end

@implementation MenuViewController
{
    NSArray *menuList,*iconsList,*infoList,*infoIconList;
    NSMutableArray *resultArray;
    SWRevealViewController *revealViewController;
    ViewControllerCellHeader *headerView;
    NSMutableArray *arrSelectedSectionIndex,*memberArray,*plusImage,*minusImage;
    BOOL isMultipleExpansionAllowed;
    MKPersianFont *myFont;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    _valid = [[NSString alloc] init];
    
    [_loginBtn setTitle:Localized(@"Login") forState:UIControlStateNormal];
    [_registerBtn setTitle:Localized(@"Register") forState:UIControlStateNormal];
    
//    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
//
//        [_loginBtn.titleLabel setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:16]];
//        [_registerBtn.titleLabel setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:16]];
//    }
//    else{
//
//        [_loginBtn.titleLabel setFont:[UIFont fontWithName:@"DroidSans-Bold" size:16]];
//        [_registerBtn.titleLabel setFont:[UIFont fontWithName:@"DroidSans-Bold" size:16]];
//    }
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    //UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    ////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    isMultipleExpansionAllowed = YES;
    
    arrSelectedSectionIndex = [[NSMutableArray alloc] init];
    
    if (!isMultipleExpansionAllowed) {
        
        //        [arrSelectedSectionIndex addObject:[NSNumber numberWithInt:count+2]];
    }
    
    [self showHUD:@""];
    [self makePostCallForPage:SERVICES withParams:@{} withRequestCode:1];
    
                _instaImage.image = [_instaImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    //_instaImage.image = [_instaImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_instaImage   setTintColor:[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1]];
    _twitterImage.image = [_twitterImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_twitterImage   setTintColor:[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1]];

    _whatsAppImage.image = [_whatsAppImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_whatsAppImage   setTintColor:[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1]];

    //        [cell.titleIMage1 setTintColor:[UIColor colorWithRed:49/255 green:49/255 blue:49/255 alpha:1]];
}

#pragma Parse Function .......

-(void)parseResult:(id)result withCode:(int)reqeustCode{
 
    if (reqeustCode == 1) {
        
        _valid = [[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"];
        
        NSString *strin = _valid;
        if([strin class]==NULL){
            strin=@"";
        }
        if ([strin length]>0) {
            
            resultArray = result;
            [_tableView reloadData];
            [self hideHUD];
            
            [self showHUD:@""];
            [self makePostCallForPage:MEMBERS withParams:@{@"member_id":[[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"]} withRequestCode:100];
        }
        else{
            resultArray = result;
            [_tableView reloadData];
            [self hideHUD];
        }
    }
    else if (reqeustCode == 100){
        
        memberArray = result;
        NSLog(@"member array is %@",memberArray);
        _emailLbl.hidden = NO;
        _emailLbl.text = [memberArray[0] valueForKey:@"email"];
         [self hideHUD];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self makePostCallForPage:SERVICES withParams:@{} withRequestCode:1];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];//UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];

    _valid = [[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"];
    [_nameLbl setTextAlignment:NSTextAlignmentCenter];
    [_emailLbl setTextAlignment:NSTextAlignmentCenter];

    NSLog(@"valid Details are %@",_valid);
    
    NSString *strin = _valid;
    if([strin class]==NULL){
        strin=@"";
    }
    if ([strin length]>0) {
        
        _loginBtn.hidden = YES;
        _registerBtn.hidden =YES;
        _nameLbl.hidden = NO;
        _logOutBtn.hidden = NO;
        _coverView.hidden = NO;
        _scollviewBottom.constant = 70;
        
        [_logOutBtn setTitle:Localized(@"Log Out") forState:UIControlStateNormal];
        
//        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
//
//            [_nameLbl setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:17]];
//            [_emailLbl setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:17]];
//            [_logOutBtn.titleLabel setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:17]];
//            [_loginBtn.titleLabel setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:17]];
//            [_registerBtn.titleLabel setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:17]];
//        }
//        else{
//
//            [_nameLbl setFont:[UIFont fontWithName:@"DroidSans-Bold" size:17]];
//            [_emailLbl setFont:[UIFont fontWithName:@"DroidSans-Bold" size:17]];
//            [_logOutBtn.titleLabel setFont:[UIFont fontWithName:@"DroidSans-Bold" size:17]];
//            [_loginBtn.titleLabel setFont:[UIFont fontWithName:@"DroidSans-Bold" size:17]];
//            [_registerBtn.titleLabel setFont:[UIFont fontWithName:@"DroidSans-Bold" size:17]];
//        }
        
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.view.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:190.0f/255.0f blue:74.0f/255.0f alpha:1];
        
        _nameLbl.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"userName"];

        _emailLbl.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"Email"];
        
        
        iconsList = [[NSArray alloc]initWithObjects:@"services.png",@"news.png",@"articles.png",@"about.png",@"contact.png",@"lang.png",@"info.png", nil];
        
        plusImage = [[NSMutableArray alloc]initWithObjects:@"plu.png",@"plu.png",@"plu.png",@"plu.png",@"plu.png",@"plu.png",@"plu.png", nil];
        
        minusImage = [[NSMutableArray alloc]initWithObjects:@"min.png",@"min.png",@"min.png",@"min.png",@"min.png",@"min.png",@"min.png", nil];
        
        menuList = @[Localized(@"Alhisba Services"),Localized(@"News"),Localized(@"Articles"),Localized(@"About Us"),Localized(@"Contact Us"),Localized(@"Language"),Localized(@"Information")];

        infoList = @[Localized(@"Faqs"),Localized(@"Privacy Policy"),Localized(@"Terms and conditions")];
        
        infoIconList = [[NSArray alloc]initWithObjects:@"faq.png",@"privacy-3.png",@"terms.png", nil];

        //        self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-100;
        
    }else{
        
        _loginBtn.hidden = NO;
        _registerBtn.hidden =NO;
        _nameLbl.hidden = YES;
        _emailLbl.hidden = YES;
        _logOutBtn.hidden = YES;
        _coverView.hidden = YES;
        _scollviewBottom.constant = 0;
        
[_logOutBtn setTitle:Localized(@"Log Out") forState:UIControlStateNormal];
[self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                      forBarMetrics:UIBarMetricsDefault];//UIImageNamed:@"transparent.png"
        self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.view.backgroundColor = [UIColor clearColor];

//  iconsList = [[NSArray alloc]initWithObjects:@"services.png",@"news.png",@"articles.png",@"faq.png",@"about.png",@"contact.png",@"services.png",@"services.png",@"services.png", nil];
//
//  menuList = @[Localized(@"Alhisba Services"),Localized(@"NEWS"),Localized(@"Articles"),Localized(@"Faqs"),Localized(@"About Us"),Localized(@"Contact Us"),Localized(@"Language"),Localized(@"Privacy Policy"),Localized(@"Terms and conditions")];
        
        iconsList = [[NSArray alloc]initWithObjects:@"services.png",@"news.png",@"articles.png",@"about.png",@"contact.png",@"lang.png",@"info.png", nil];
        
        menuList = @[Localized(@"Alhisba Services"),Localized(@"News"),Localized(@"Articles"),Localized(@"About Us"),Localized(@"Contact Us"),Localized(@"Language"),Localized(@"Information")];
        
        infoList = @[Localized(@"Faqs"),Localized(@"Privacy Policy"),Localized(@"Terms and conditions")];
        
        infoIconList = [[NSArray alloc]initWithObjects:@"faq.png",@"privacy-3.png",@"terms.png", nil];
        
        plusImage = [[NSMutableArray alloc]initWithObjects:@"plu.png",@"plu.png",@"plu.png",@"plu.png",@"plu.png",@"plu.png",@"plu.png", nil];
        
        minusImage = [[NSMutableArray alloc]initWithObjects:@"min.png",@"min.png",@"min.png",@"min.png",@"min.png",@"min.png",@"min.png", nil];

        //        self.revealViewController.rearViewRevealWidth = self.view.frame.size.width-100;
    }
    
    [_tableView reloadData];
    
//    NSArray *windows = [UIApplication sharedApplication].windows;
//    for (UIWindow *window in windows) {
//        for (UIView *view in window.subviews) {
//            [view removeFromSuperview];
//            [window addSubview:view];
//        }
//    }

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return menuList.count;
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return menuList.count;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([arrSelectedSectionIndex containsObject:[NSNumber numberWithInteger:section]])
    {
        if (section == 0) {
            
            return resultArray.count;
        }
        else if (section == 6){
            return infoList.count;
        }
        else{
            return menuList.count;
        }
        
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 40;
    }
    else if (indexPath.section == 6) {
        return 40;
    }
    else {
        return 100;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  SWUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"map" forIndexPath: indexPath];

    if (cell ==nil)
    {
        [_tableView registerClass:[SWUITableViewCell class] forCellReuseIdentifier:@"map"];
        
        cell = [_tableView dequeueReusableCellWithIdentifier:@"ViewControllerCell"];
    }
    if (indexPath.section == 0) {
        
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            cell.label.text = [[resultArray valueForKey:@"name_arabic"] objectAtIndex:indexPath.row];
        }
        else{
            cell.label.text = [[resultArray valueForKey:@"name_english"] objectAtIndex:indexPath.row];
        }
        [cell.subImageView sd_setImageWithURL:[NSURL URLWithString:[[resultArray valueForKey:@"image"] objectAtIndex:indexPath.row]]];
    }
    
  else if (indexPath.section == 6) {
      
      cell.label.text = [infoList objectAtIndex:indexPath.row];
      cell.subImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[infoIconList objectAtIndex:indexPath.row]]];
    }
    else{
    }
    

    return cell;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    headerView = [tableView dequeueReusableCellWithIdentifier:@"ViewControllerCellHeader"];
    
    if (headerView ==nil)
    {
        [_tableView registerClass:[ViewControllerCellHeader class] forCellReuseIdentifier:@"ViewControllerCellHeader"];
        
        headerView = [tableView dequeueReusableCellWithIdentifier:@"ViewControllerCellHeader"];
    }
    
    headerView.lbTitle.text = [NSString stringWithFormat:@"%@",[menuList objectAtIndex:(long)section]];
    
//    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
//
//        [headerView.lbTitle setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:18]];
//    }
//    else{
//        [headerView.lbTitle setFont:[UIFont fontWithName:@"DroidSans-Bold" size:18]];
//    }
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        [headerView.lbTitle setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold" size:18]];
    }
    else{
        [headerView.lbTitle setFont:[UIFont fontWithName:@"DroidSans-Bold" size:18]];
    }

    headerView.titleImae.image = [UIImage imageNamed:[iconsList objectAtIndex:(long)section]];

    if ([arrSelectedSectionIndex containsObject:[NSNumber numberWithInteger:section]])
    {
        headerView.btnShowHide.selected = YES;
        headerView.completeHeadBtn.selected = YES;
    }
    
    if (section == 0 || section == 6) {
        
        headerView.btnShowHide.hidden = NO;
        headerView.tapButton.hidden = YES;
        headerView.completeHeadBtn.hidden = NO;
    }
    else{
         headerView.btnShowHide.hidden = YES;
         headerView.tapButton.hidden = NO;
         headerView.completeHeadBtn.hidden = YES;
    }
    
    if (section == 1) {
        
        [[headerView tapButton] setTag:1];
    }
    if (section == 2) {
        
        [[headerView tapButton] setTag:2];
    }
    if (section == 3) {
        
        [[headerView tapButton] setTag:3];
    }
    if (section == 4) {
        
        [[headerView tapButton] setTag:4];
    }
    if (section == 5) {
        
        [[headerView tapButton] setTag:5];
    }
    if (section == 6) {
        
        [[headerView tapButton] setTag:6];
    }

    [[headerView btnShowHide] setTag:section];
    [[headerView completeHeadBtn] setTag:section];
    [[headerView tapButton] setTag:section];
    headerView.tapButton.tag = section;
//    headerView.completeHeadBtn.tag = section;
    
    [[headerView btnShowHide] addTarget:self action:@selector(btnTapShowHideSection:) forControlEvents:UIControlEventTouchUpInside];
    
    [[headerView completeHeadBtn] addTarget:self action:@selector(btnTapShowHideSection:) forControlEvents:UIControlEventTouchUpInside];

    [[headerView tapButton] addTarget:self action:@selector(tapButtonTapped:) forControlEvents:UIControlEventTouchUpInside];

//    [headerView.contentView setBackgroundColor:section%2==0?[UIColor groupTableViewBackgroundColor]:[[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.5f]];
    
    return headerView.contentView;
}

-(IBAction)tapButtonTapped:(UIButton*)sender
{
    UIButton* button = (UIButton*)sender;
    //    filterTag = [NSString stringWithFormat:@"%@",sender.tag];
    CGRect buttonFrame =[button convertRect:button.bounds toView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:buttonFrame.origin];
    NSString *strInt = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
 //   [button setImage:[UIImage imageNamed:@"min.png"] forState:UIControlStateNormal];

    if (sender.tag == 1) {
        
                NewViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"NewViewController"];
                UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:loginView];
                [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
    }
    else if (sender.tag == 2)
    {
        articlesViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"articlesViewController"];
        UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:loginView];
        [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
    }
   else if (sender.tag == 4) {
       
       ContactUsViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactUsViewController"];
       UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:loginView];
       [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
   }
    else if (sender.tag == 3){
        
        AboutUsViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
        UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:loginView];
        [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
    }
    else if (sender.tag == 1){
        
        NewViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"NewViewController"];
        UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:loginView];
        [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
    }
    else if (sender.tag == 2){
        
        articlesViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"articlesViewController"];
        UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:loginView];
        [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
    }
    else if (sender.tag == 3){
        
        FaqsViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"FaqsViewController"];
        UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:loginView];
        [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
    }
    
    else if (sender.tag == 5){
        
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            
            [Utils setLanguage:KEY_LANGUAGE_EN];
            [[MCLocalization sharedInstance] setLanguage:KEY_LANGUAGE_EN];
            
            [[UILabel appearance] setTextAlignment:NSTextAlignmentRight];
            [[UITextField appearance] setTextAlignment:NSTextAlignmentRight];
            [[UITextView appearance] setTextAlignment:NSTextAlignmentRight];
            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
        } else {
            [Utils setLanguage:KEY_LANGUAGE_AR];
            [[MCLocalization sharedInstance] setLanguage:KEY_LANGUAGE_AR];
            [[UILabel appearance] setTextAlignment:NSTextAlignmentLeft];
            [[UITextField appearance] setTextAlignment:NSTextAlignmentLeft];
            [[UITextView appearance] setTextAlignment:NSTextAlignmentLeft];
            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
        }
        NSArray *windows = [UIApplication sharedApplication].windows;
        for (UIWindow *window in windows) {
            for (UIView *view in window.subviews) {
                [view removeFromSuperview];
                [window addSubview:view];
            }
        }
        [APP_DELEGATE reloadUIForLanguageChange];
        
        HomeViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:loginView];
        [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
    }
}

-(IBAction)btnTapShowHideSection:(UIButton*)sender
{
    UIButton* button = (UIButton*)sender;
    //    filterTag = [NSString stringWithFormat:@"%@",sender.tag];
    CGRect buttonFrame =[button convertRect:button.bounds toView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:buttonFrame.origin];
    NSString *strInt = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    if (button.selected == YES)
    {
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[plusImage objectAtIndex:[button tag]]]] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor redColor]];
        button.selected = YES;
    }
    else{
        
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[minusImage objectAtIndex:[button tag]]]] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor redColor]];
        button.selected = NO;
    }

    if (!sender.selected)
    {
        if (!isMultipleExpansionAllowed) {
            
            [arrSelectedSectionIndex replaceObjectAtIndex:sender.tag withObject:[NSNumber numberWithInteger:sender.tag]];
        }else {
            
            [arrSelectedSectionIndex addObject:[NSNumber numberWithInteger:sender.tag]];
        }
        
        sender.selected = YES;
    }else{
        sender.selected = NO;
        
        if ([arrSelectedSectionIndex containsObject:[NSNumber numberWithInteger:sender.tag]])
        {
            [arrSelectedSectionIndex removeObject:[NSNumber numberWithInteger:sender.tag]];
        }
    }
    if (!isMultipleExpansionAllowed) {
        
        [_tableView reloadData];
        
    }else {
        
        [_tableView reloadData];
    }
}


#pragma mark state preservation / restoration
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO save what you need here
   [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO restore what you need here
    
    [super decodeRestorableStateWithCoder:coder];
}

- (void)applicationFinishedRestoringState {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO call whatever function you need to visually restore
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 7) {
            
//            PrivacyPolicyViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"PrivacyPolicyViewController"];
//            UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:loginView];
//            [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
        }
        else if (indexPath.row == 6){
            
            OfficialApraisalViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"OfficialApraisalViewController"];
            loginView.fromMenu = @"menu";
            UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:loginView];
            [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
        }
        else if (indexPath.row == 5){
            
            ReloanCalculatorViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"ReloanCalculatorViewController"];
            loginView.fromMenu = @"menu";
            UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:loginView];
            [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
        }
        else if (indexPath.section == 3){
            
            CostEstimatorViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"CostEstimatorViewController"];
             loginView.fromMenu = @"menu";
            UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:loginView];
            [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
        }
        else if (indexPath.row == 0){
            
            instantValueEstimatorViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"instantValueEstimatorViewController"];
             loginView.fromMenu = @"menu";
            UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:loginView];
            [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
        }
        else if (indexPath.row == 1){
            
            RegisterdTradesViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterdTradesViewController"];
             loginView.fromMenu = @"menu";
            UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:loginView];
            [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
        }

        else if (indexPath.row == 2){
            
            AuctionsViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"AuctionsViewController"];
            UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:loginView];
            [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
        }
        else if (indexPath.row == 3){
            
            CostEstimatorViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"CostEstimatorViewController"];
            UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:loginView];
            loginView.fromMenu = @"menu";
            [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
        }
    }
    else{
        if (indexPath.row == 0){
            
            FaqsViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"FaqsViewController"];
            UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:loginView];
            [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
        }
      else  if (indexPath.row == 1){
            
            PrivacyPolicyViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"PrivacyPolicyViewController"];
            UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:loginView];
            [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
        }
       else if (indexPath.row == 2){
            
            TermsofUseViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"TermsofUseViewController"];
            UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:loginView];
            [self.revealViewController pushFrontViewController:navigationController1 animated:YES];
        }
    }
}

#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}

- (IBAction)logOutBtnClicked:(id)sender {
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setValue:@"" forKey:@"customer_id"];
    [defaults synchronize];
    
    _nameLbl.hidden = YES;
    _loginBtn.hidden = NO;
    _registerBtn.hidden = NO;
    _emailLbl.hidden = YES;
    
    HomeViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:obj];
    [self.revealViewController pushFrontViewController:navigationController animated:YES];
}

- (IBAction)loginBtnTapped:(id)sender {
    
    LoginOrSignUpViewController *objViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginOrSignUpViewController"];
    objViewController.loginOrSign = @"login";
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:objViewController];
    [self.revealViewController pushFrontViewController:navigationController animated:YES];
}

- (IBAction)registerBtnTapped:(id)sender {
    
    LoginOrSignUpViewController *objViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginOrSignUpViewController"];
    objViewController.loginOrSign = @"signUp";
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:objViewController];
    [self.revealViewController pushFrontViewController:navigationController animated:YES];
}


- (IBAction)twitterBtnAction:(id)sender {
    NSURL *twitterURL = [NSURL URLWithString:@"https://twitter.com/alhisbakw"];
    if ([[UIApplication sharedApplication] canOpenURL:twitterURL])
        [[UIApplication sharedApplication] openURL:twitterURL];
    else
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/alhisbakw"]];
}

- (IBAction)instagramBtnAction:(id)sender {
    NSURL *instagramURL = [NSURL URLWithString:@"https://instagram.com/alhisba?utm_source=ig_profile_share&igshid=1st4d64ofzoi2"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        [[UIApplication sharedApplication] openURL:instagramURL];
    }
}

- (IBAction)whatsappBtnAction:(id)sender {
    NSURL *twitterURL = [NSURL URLWithString:@"https://bit.ly/2L5C0sk"];
    if ([[UIApplication sharedApplication] canOpenURL:twitterURL])
        [[UIApplication sharedApplication] openURL:twitterURL];
    else
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.twitter.com/ta7weelapp"]];
}
@end
