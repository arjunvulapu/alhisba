//
//  SelectArea1ViewController.m
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
////  Copyright © 2016 Amit Kulkarni. All rights reserved.


#import "SelectExistAdresViewController.h"
#import "AppTableViewCell.h"

@interface SelectExistAdresViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (nonatomic) NSMutableArray *states;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end

@implementation SelectExistAdresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _noAddresLbl.hidden = YES;
    
    self.states = [[NSMutableArray alloc] init];
    
    [self.tableView registerClass:[AppTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"close-white.png"] style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    
    [_noAddresLbl setTextAlignment:NSTextAlignmentCenter];
    
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
    
[_cancelBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];

    self.navItem.title = Localized(@"select address");
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    if ([self.restId length] > 0) {
        [dictionary setValue:self.restId forKey:@"rest_id"];
    }
    
    NSUserDefaults *memberId = [NSUserDefaults standardUserDefaults];
    [dictionary setValue:[memberId valueForKey:@"customer_id"] forKey:@"member_id"];

//    [self makePostCallForPage:ADDRESSES withParams:@{@"member_id":[[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"],@"area_id":[[NSUserDefaults standardUserDefaults] valueForKey:@"Id"]} withRequestCode:1];
    
    [self makePostCallForPage:ADDRESSES withParams:@{@"member_id":[[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"]} withRequestCode:1];

    
}

- (void)viewWillAppear:(BOOL)animated {
    self.view.layer.cornerRadius = 10;
    self.view.clipsToBounds = YES;
}

- (void)parseResult:(id)result withCode:(int)reqeustCode {
    NSArray *array = (NSArray *)result;
    
    if ([array count]==0) {
        _noAddresLbl.hidden = NO;
    }
    else{
        _noAddresLbl.hidden = YES;
        for (NSDictionary *dictionary in array) {
            
            [self.states addObject:[ExistAddres instanceFromDictionary:dictionary]];
        }
        [self.tableView reloadData];
    }
}

-(void)backBtnClicked{
    [self.delegate cancelButtonClicked:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)close {
    [self.delegate cancelButtonClicked:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - tableView

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    Country *country = [self.areas objectAtIndex:section];
//    return country.title;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [self.states count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    ExistAddres *cat = [self.states objectAtIndex:indexPath.row];
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    cell.textLabel.text = cat.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ExistAddres *cat = [self.states objectAtIndex:indexPath.row];
    self.completionBlock(cat);
    [self.delegate cancelButtonClicked:self];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
