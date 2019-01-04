//
//  NewViewController.m
//  Alhisba
//
//  Created by apple on 02/08/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "NewViewController.h"
#import "HomeViewController.h"
#import "SVProgressHUD.h"
#import "newsTableViewCell.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "detailsViewController.h"

@interface NewViewController (){
    
    UIButton *backBtn;
    NSMutableArray *newsArray;
    NSString *htmlString;
    
    NSString *pageLoading;
    int pageNumber;
     BOOL loaded;
}

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pageLoading = @"YES";
    pageNumber = 0;
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    UIImage *image = [UIImage imageNamed: @"NavImage.png"];
    [navigationBar setBackgroundImage:image forBarMetrics: UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];//UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
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
    
    [self showHUD:@""];
//    [self makePostCallForPage:NEWS withParams:@{@"page":@"0"} withRequestCode:23];
    [self makePostCallForPage:NEWS withParams:@{@"page":@"0"} withRequestCode:23];

    self.navigationItem.title=Localized(@"NEWS");
     loaded = NO;
}

-(void)goBack{
    
    HomeViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    [self.navigationController pushViewController:obj animated:YES];
}


-(void)parseResult:(id)result withCode:(int)reqeustCode {
    [self hideHUD];

    if(reqeustCode==23){
       
        NSLog(@"Result is %lu",(unsigned long)newsArray.count);
        newsArray = [[NSMutableArray alloc] init];
        NSArray *array = (NSArray *)result;
        for (NSDictionary *dictionary in array) {
            [newsArray addObject:dictionary];
        }
        NSLog(@"n %@",[newsArray valueForKey:@"id"]);
        //[_newsTableView reloadData];
        pageLoading = @"NO";
         loaded=NO;
        pageNumber = 1;
    }else if(reqeustCode==24){
        NSLog(@"Result isss %lu",(unsigned long)newsArray.count);
        
        NSArray *array = (NSArray *)result;
        if(array.count==0){
            pageLoading = @"YES";
            loaded=YES;
        }else{
            pageLoading = @"NO";
            loaded=NO;
            pageNumber = pageNumber+1;
        }
        for (NSDictionary *dictionary in result) {
            [newsArray addObject:dictionary];
        }
    }
    _newsTableView.reloadData;

}
-(void)loadmore
{
    //add datasource object here for tableview
    //now insert cell in tableview
    [_newsTableView beginUpdates];
    [_newsTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[newsArray count]-1 inSection:0]]withRowAnimation:UITableViewRowAnimationAutomatic];
    [_newsTableView endUpdates];
}
#pragma TableView Delegate & Dat Source..

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"select %lu",(unsigned long)newsArray.count);
    //return newsArray.count;
    if(newsArray.count>0 && !loaded){
        return newsArray.count+1;
    }else{
        return newsArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == newsArray.count){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoadingCell" forIndexPath:indexPath];
        UIActivityIndicatorView *activityIndicator = (UIActivityIndicatorView *)[cell.contentView viewWithTag:100];
        [activityIndicator startAnimating];
        
        return cell;
        
        
    }
    else{
    static NSString *CellIdentifier = @"newsTableViewCell";
    
    newsTableViewCell *cell = [_newsTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSMutableDictionary *dic = [newsArray objectAtIndex:indexPath.row];
    cell.newsTitle.text = [dic  valueForKey:@"title_english"];
    
    cell.separatorInset = UIEdgeInsetsMake(20, 20, 20, 20);
    cell.layer.borderWidth = 5;
    cell.layer.borderColor = [UIColor colorWithRed:1.0f/255.0f green:33.0f/255.0f blue:72.0f/255.0f alpha:0.6f].CGColor;

    [cell.newsimageView setImageWithURL:[dic valueForKey:@"image"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        htmlString = [dic  valueForKey:@"small_content_english"];
    }
    else{
        htmlString = [dic  valueForKey:@"small_content_english"];
        
    }
//
//    NSAttributedString *attributedString = [[NSAttributedString alloc]
//                                            initWithData: [htmlString dataUsingEncoding:NSUnicodeStringEncoding]
//                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
//                                            documentAttributes: nil
//                                            error: nil
//                                            ];
//
//
//    cell.nesDes.attributedText = attributedString;
    cell.nesDes.text = htmlString;
//    cell.nesDes.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    detailsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"detailsViewController"];
    obj.detailsDic = [newsArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:obj animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}

//- (void)tableView:(UITableView *)tableView
//  willDisplayCell:(UITableViewCell *)cell
//forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if(tableView == _newsTableView){
//        if([pageLoading  isEqual: @"NO"]){
//            if (newsArray.count-1 == indexPath.row) {
//                pageLoading = @"YES";
//
//                [self makePostCallForPage:NEWS withParams:@{@"page":[NSString stringWithFormat:@"%d",pageNumber]} withRequestCode:24];
//            }
//        }
//
//    }
//}
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
if(indexPath.row == newsArray.count){
    if(newsArray.count>0){
            [self makePostCallForPage:NEWS withParams:@{@"page":[NSString stringWithFormat:@"%d",pageNumber]} withRequestCode:24];

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


@end
