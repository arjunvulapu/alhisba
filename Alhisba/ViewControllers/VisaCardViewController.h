//
//  VisaCardViewController.h
//  Deeels
//
//  Created by apple on 05/06/17.
//  Copyright © 2017 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface VisaCardViewController : BaseViewController<UIWebViewDelegate>

@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *invoice_id;
@property (nonatomic, strong) NSString *paymentType;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, copy) void (^completionBlock)(NSString *status);

@property (strong, nonatomic)NSMutableArray *cartList;
@property (strong, nonatomic)NSDictionary *cartListDetails;

@property (weak, nonatomic) IBOutlet UIImageView *statusImage;

@property (weak, nonatomic) IBOutlet UILabel *yourCartisEmptyLbl;

@property (weak, nonatomic) IBOutlet UIButton *continueShopingBtn;

- (IBAction)continueShopBtnClicked:(id)sender;

@end
