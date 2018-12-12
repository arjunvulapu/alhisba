//
//  FaqsViewController.m
//  Bloomego
//
//  Created by apple on 04/06/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "FaqsViewController.h"
#import "HomeViewController.h"
#import "SVProgressHUD.h"
#import "TradesTableViewCell.h"
#import "ExpandTableViewCell.h"

@interface FaqsViewController (){
    
    UIButton *backBtn;
    NSMutableArray *faqsArray;
}

@end

@implementation FaqsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@",Localized(@"FAQ'S")];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidArabicKufi-Bold"size:20.0],NSFontAttributeName,nil];
    }
    else{
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
    }
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    UIImage *image = [UIImage imageNamed: @"NavImage.png"];
    [navigationBar setBackgroundImage:image forBarMetrics: UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];//UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];

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
    
    [self showHUD:@""];
    [self makePostCallForPage:FAQS withParams:@{} withRequestCode:23];

}

-(void)parseResult:(id)result withCode:(int)reqeustCode
{
    if (reqeustCode == 23) {
        
        faqsArray = result;
        [_tradesTableView reloadData];
    }
    [self hideHUD];
}


-(void)goBack{

    //[self.navigationController popViewControllerAnimated:YES];
    HomeViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    [self.navigationController pushViewController:obj animated:YES];
}

#pragma TableView Delegate & Dat Source..

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//    return resultArray.count;
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _tradesTableView) {
        
        return JNExpandableTableViewNumberOfRowsInSection((JNExpandableTableView *)tableView,section,faqsArray.count);
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tradesTableView) {
        
        NSIndexPath * adjustedIndexPath = [self.tradesTableView adjustedIndexPathFromTable:indexPath];
        
        if ([self.tradesTableView.expandedContentIndexPath isEqual:indexPath])
        {
            static NSString *CellIdentifier = @"expandedCell";
            
            ExpandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            NSMutableDictionary *dic = [faqsArray objectAtIndex:indexPath.row-1];
            
            if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
                
                cell.answerLbl.text = [dic valueForKey:@"answer_arabic"];
            }
            else{
                cell.answerLbl.text = [dic valueForKey:@"answer_english"];
            }
            if (indexPath.row % 2) {
                cell.contentView.backgroundColor = [UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1];

            } else {
                cell.contentView.backgroundColor = [UIColor whiteColor];

            }
            return cell;
        }
        
        else{
            
            static NSString *MyIdentifier = @"TradesTableViewCell";
            
            TradesTableViewCell *cell = [_tradesTableView dequeueReusableCellWithIdentifier:MyIdentifier];
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            
            dic = [faqsArray objectAtIndex:adjustedIndexPath.row];
            
            if (adjustedIndexPath.row % 2) {
                cell.contentView.backgroundColor = [UIColor whiteColor];
            } else {
                cell.contentView.backgroundColor = [UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1];
            }
            
            cell.dropDownBtn.tag = indexPath.row;
            
            if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
                cell.questionLbl.text = [dic valueForKey:@"question_arabic"];
            }
            else{
                
                cell.questionLbl.text = [dic valueForKey:@"question_english"];
            }
            
            [[cell dropDownBtn] addTarget:self action:@selector(tapButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }
    }
    return 0;
}

-(IBAction)tapButtonTapped:(UIButton*)sender
{
    UIButton* button = (UIButton*)sender;
    
    //    filterTag = [NSString stringWithFormat:@"%@",sender.tag];
    CGRect buttonFrame =[button convertRect:button.bounds toView:_tradesTableView];
    NSIndexPath *indexPath = [_tradesTableView indexPathForRowAtPoint:buttonFrame.origin];
   // NSString *strInt = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
//    [self tableView:_tradesTableView willExpand:indexPath];
//    [self tableView:_tradesTableView canExpand:indexPath];
//    [self tableView:_tradesTableView willCollapse:indexPath];
//    [self tableView:_tradesTableView didSelectRowAtIndexPath:indexPath];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (tableView == _tradesTableView) {
//
//        if ([indexPath isEqual:self.tradesTableView.expandedContentIndexPath])
//        {
//            return 40.0f;
//        }
//        else
//            return 60.0f;
//    }
//    else{
//        return 0;
//    }
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
#pragma mark JNExpandableTableView DataSource
- (BOOL)tableView:(JNExpandableTableView *)tableView canExpand:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(JNExpandableTableView *)tableView willExpand:(NSIndexPath *)indexPath
{
    NSLog(@"Will Expand: %@",indexPath);
}
- (void)tableView:(JNExpandableTableView *)tableView willCollapse:(NSIndexPath *)indexPath
{
    NSLog(@"Will Collapse: %@",indexPath);
}
#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}


@end
