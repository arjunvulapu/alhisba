
#import "SelectArea1ViewController.h"
#import "AppTableViewCell.h"
#import "HomeViewController.h"

#import "UIViewController+MJPopupViewController.h"
#import "SVProgressHUD.h"

#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)



@interface SelectArea1ViewController () <UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>{
    
    NSMutableArray *mostProductsList;
    NSArray *array;
    UIButton *buttonUser;
    NSMutableArray *serviceArray;
    BOOL isFilltered;
    NSMutableArray *Arrdata;
    NSMutableArray *cellText1;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonItem;
@property (nonatomic) NSMutableArray *areas;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UILabel *selectServiceLbl;

@end

@implementation SelectArea1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    cellText1 = [[NSMutableArray alloc]init];
    _totalView.frame=self.view.frame;
    _searchBar.delegate = self;
    self.view.backgroundColor=[UIColor whiteColor];

    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        
        [_selectServiceLbl setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:17.0f]];

    } else {
        
        [_selectServiceLbl setFont:[UIFont fontWithName:@"Libel Suit" size:17.0f]];
    }
    
    _selectServiceLbl.text = Localized(@"Select Area");

    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:9.0f/255.0f green:97.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
    self.navigationController.navigationBar.translucent = NO;

    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        [_selectServiceLbl setTextAlignment:NSTextAlignmentCenter];
        
    } else {
         [_selectServiceLbl setTextAlignment:NSTextAlignmentCenter];
    }
    
    [_cancelBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside ];

    mostProductsList = [[NSMutableArray alloc] init];
    
    self.areas = [[NSMutableArray alloc] init];
    
    [self.tableView registerClass:[AppTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"close.png"] style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        // Add a negative spacer on iOS >= 7.0
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = 10;
        self.navItem.rightBarButtonItems = @[negativeSpacer, closeButton];
    } else {
        self.navItem.leftBarButtonItem = closeButton;
    }
    
//    self.navItem.title = Localized(@"SELECT SERVICES");

    [self showHUD:@"Loading"];
    
    [self makePostCallForPage:LIVE_AREAS
                   withParams:@{}
              withRequestCode:1];
}

-(void)backBtnClicked{
    
//    CountryArea *cat;
    
//    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];

//        HomeViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
//    [self.navigationController pushViewController:obj animated:YES];
    
//    self.completionBlock(cat);
//
    [self.delegate cancelButtonClicked:self];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
//    self.view.layer.cornerRadius = 10;
//    self.view.clipsToBounds = YES;
    self.title = Localized(@"Select Area");

}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    self.areas=[[NSMutableArray alloc]init];
    array = (NSArray *)result;
    
    mostProductsList = [[result valueForKey:@"services"] valueForKey:@"title"];

    for (NSDictionary *dictionary in array) {
        [self.areas addObject:dictionary];
    }
    [self.tableView reloadData];
    
    if ([self.areas count] == 0){
        
        _selectServiceLbl.hidden = NO;
    }
    
    [self hideHUD];
}

//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    
//    if ([searchText length]==0) {
//        [_areas removeAllObjects];
//        [Arrdata addObjectsFromArray:self.areas];
//        
//    }
//    else{
//
//        [Arrdata removeAllObjects];
//        
//        for (NSString *string in _areas) {
//            
//            NSRange r = [string rangeOfString:searchText options:NSCaseInsensitiveSearch];
//            
//            if (r.location != NSNotFound) {
//                
//                [Arrdata addObject:string];
//                
//            }
//        }
//        
//    }
//
//    [_tableView reloadData];
//}


- (void)close {
    
//    [self.delegate cancelButtonClicked:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"Cancel");
    [searchBar resignFirstResponder];
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"GO");
    [searchBar resignFirstResponder];
}

-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
  //  NSLog(@"Search string is -> %@",searchText);
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //    self.restaurants = [[NSMutableArray alloc] init];
    //    self.original = [[NSMutableArray alloc] init];
    [self performSelector:@selector(calServiceWithString) withObject:self afterDelay:1.0 ];
    
}

-(void)calServiceWithString{
    
    [self makePostCallForPage:LIVE_AREAS withParams:@{@"search":_searchBar.text}  withRequestCode:1];
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    NSDictionary *country = [self.areas objectAtIndex:section];
//    return  [country    valueForKey:@"value_english"];
//}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UILabel *customLabel = [[UILabel alloc] init];
//    customLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 3, 150, 30)];
//    [customLabel setTextAlignment:NSTextAlignmentCenter];
//    customLabel.text = [self tableView:tableView titleForHeaderInSection:section];
//    customLabel.backgroundColor=[UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1];
//  //  customLabel.textColor = [UIColor colorWithRed:17/255.0f green:187/255.0f blue:178/255.0f alpha:1];
//    return customLabel;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.areas count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *lbl = [[UILabel alloc] init];
    lbl.textAlignment = UITextAlignmentCenter;
    lbl.font = [UIFont boldSystemFontOfSize:18];
    lbl.text = [self tableView:tableView titleForHeaderInSection:section];
    lbl.textColor = [UIColor blackColor];
    lbl.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1];
    lbl.shadowOffset = CGSizeMake(0,1);
//    lbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"my_head_bg"]];
    lbl.alpha = 0.9;
    return lbl;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
   NSDictionary *dict= [self.areas objectAtIndex:indexPath.row];
    
    [cell setBackgroundColor:[UIColor whiteColor]];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        [cell.textLabel setFont:[UIFont fontWithName:@"DroidArabicKufi" size:18]];

        cell.textLabel.text = [dict valueForKey:@"value_arabic"];

    } else {
        [cell.textLabel setFont:[UIFont systemFontOfSize:18]];

        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        cell.textLabel.text = [dict valueForKey:@"value_english"];

    }
    
    [cell.textLabel setBackgroundColor:[UIColor clearColor]];
    [cell.textLabel setTextColor:[UIColor blackColor]];

    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if([view isKindOfClass:[UITableViewHeaderFooterView class]]){
     
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
            UITableViewHeaderFooterView *tableViewHeaderFooterView = (UITableViewHeaderFooterView *) view;
            [tableViewHeaderFooterView.textLabel setBackgroundColor:[UIColor clearColor]];
            [tableViewHeaderFooterView.textLabel setTextColor:[UIColor blackColor]];
            [tableViewHeaderFooterView.textLabel setFont:[UIFont fontWithName:@"DroidArabicKufi-Bold"size:20]];
            tableViewHeaderFooterView.textLabel.textAlignment = NSTextAlignmentCenter;
            
        } else {
            
            UITableViewHeaderFooterView *tableViewHeaderFooterView = (UITableViewHeaderFooterView *) view;
            [tableViewHeaderFooterView.textLabel setBackgroundColor:[UIColor clearColor]];
            [tableViewHeaderFooterView.textLabel setTextColor:[UIColor blackColor]];
            [tableViewHeaderFooterView.textLabel setFont:[UIFont fontWithName:@"DroidSans-Bold" size:20]];
            tableViewHeaderFooterView.textLabel.textAlignment = NSTextAlignmentCenter;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *userId = @"ServiceBtnClick";
    NSUserDefaults *memberId = [NSUserDefaults standardUserDefaults];
    [memberId setObject:userId forKey:@"ServiceBtnClick"];
    [memberId synchronize];
    
    NSDictionary *cat  = [self.areas objectAtIndex:indexPath.row];
    
    
    
//    [_tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
//
//        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
//    
//    NSString *cellText = selectedCell.textLabel.text;
//
//    if
//        ([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark)
//    {
//        
//        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
//        
//        [cellText1 addObject:cellText];
//        
//        NSLog(@"myArray %@",cellText1);
//
//        
//    }else{
//        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
//
//    }
//    
    
//    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];

    
//    Country *country = [self.areas objectAtIndex:section];
//    return [country.areas count];

//    HairCutDetailViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HairCutDetailViewController"];
//    
////    obj.serviceArray = array;
//    
//    obj.serviceString = [array objectAtIndex:indexPath.row];
//    
//    [self.navigationController pushViewController:obj animated:NO];
    
//    NSUserDefaults *memberId = [NSUserDefaults standardUserDefaults];
//    [memberId setObject:array forKey:@"servicesList"];
//    [memberId synchronize];
//
//    serviceArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"servicesList"];
//    NSLog(@"serviceArray%@",serviceArray);
//
//    
//    NSUserDefaults *memberId1 = [NSUserDefaults standardUserDefaults];
//    [memberId1 setObject:cat forKey:@"servicesIndex"];
//    [memberId1 synchronize];
    
    self.completionBlock(cat);
    [self.delegate cancelButtonClicked:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - HUD

- (void) showHUD:(NSString *)labelText {
    //    [HUD hideAnimated:false];
    //    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    HUD.label.text = labelText;
    //    HUD.bezelView.color = [UIColor redColor];
    //    HUD.mode = MBProgressHUDModeCustomView;
    //    HUD.contentColor = [UIColor redColor];
    //    [HUD showAnimated:YES];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}


- (IBAction)cancelBtnClciked:(id)sender {
    
    [self.delegate cancelButtonClicked:self];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
