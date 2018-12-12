//
//  articlesViewController.m
//  Alhisba
//
//  Created by apple on 02/08/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "articlesViewController.h"
#import "SVProgressHUD.h"
#import "HomeViewController.h"
#import "articlesTableViewCell.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "detailsViewController.h"

@interface articlesViewController (){
    
    UIButton *backBtn;
    NSMutableArray *articlesArray;
    NSString *pageLoading;
    int pageNumber;
}

@end

@implementation articlesViewController

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
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidArabicKufi-Bold" size:20.0],NSFontAttributeName,nil];
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
//    [self makePostCallForPage:BLOG withParams:@{@"page":[NSString stringWithFormat:@"%d",pageNumber]} withRequestCode:23];
    [self makePostCallForPage:BLOG withParams:@{} withRequestCode:23];

    self.navigationItem.title=Localized(@"Articles");
    
}

-(void)goBack{
    
    HomeViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    [self.navigationController pushViewController:obj animated:YES];
}


-(void)parseResult:(id)result withCode:(int)reqeustCode
 
    
    {
        
        if(reqeustCode==23){
            pageLoading = @"NO";
            pageNumber = 1;
            NSLog(@"Result is %@",result);
            articlesArray = [[NSMutableArray alloc] init];
            NSArray *array = (NSArray *)result;
            for (NSDictionary *dictionary in array) {
                [articlesArray addObject:dictionary];
            }
            [_articlesTableView reloadData];
          
        }else{
        
            NSArray *array = (NSArray *)result;
            if(array.count==0){
                pageLoading = @"YES";
            }else{
                pageLoading = @"NO";
                pageNumber = pageNumber+1;
            }
            for (NSDictionary *dictionary in array) {
                [articlesArray addObject:dictionary];
            }
            [_articlesTableView reloadData];
            
        }
        
        [self hideHUD];
    
}


#pragma TableView Delegate & Dat Source..

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return articlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"articlesTableViewCell";
    
    articlesTableViewCell *cell = [_articlesTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSMutableDictionary *dic = [articlesArray objectAtIndex:indexPath.row];
    cell.articleTitle.text = [dic  valueForKey:@"title_english"];
    
    cell.separatorInset = UIEdgeInsetsMake(20, 20, 20, 20);
    cell.layer.borderWidth = 5;
    cell.layer.borderColor = [UIColor colorWithRed:1.0f/255.0f green:33.0f/255.0f blue:72.0f/255.0f alpha:0.6f].CGColor;
    
    [cell.articlesImageView setImageWithURL:[dic valueForKey:@"image"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    NSString *htmlString = [dic  valueForKey:@"small_content_english"];
    
//    NSAttributedString *attributedString = [[NSAttributedString alloc]
//                                            initWithData: [htmlString dataUsingEncoding:NSUnicodeStringEncoding]
//                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
//                                            documentAttributes: nil
//                                            error: nil
//                                            ];
//    cell.articleDes.attributedText = attributedString;
    cell.articleDes.text = htmlString;

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    detailsViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"detailsViewController"];
    obj.detailsDic = [articlesArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:obj animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}
//- (void)tableView:(UITableView *)tableView
//  willDisplayCell:(UITableViewCell *)cell
//forRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    if([pageLoading  isEqual: @"NO"]){
//        if (articlesArray.count-1 == indexPath.row) {
//            pageLoading = @"YES";
//
//            [self makePostCallForPage:BLOG withParams:@{@"page":[NSString stringWithFormat:@"%d",pageNumber]} withRequestCode:24];
//        }
//    }
//
//
//}
#pragma mark - SVPROGRESS HUD

- (void) showHUD:(NSString *)labelText {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}


@end
