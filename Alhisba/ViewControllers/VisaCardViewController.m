//
//  VisaCardViewController.m
//  Deeels
//
//  Created by apple on 05/06/17.
//  Copyright © 2017 apple. All rights reserved.
//

#import "VisaCardViewController.h"
#import "SVProgressHUD.h"
#import "HomeViewController.h"

@interface VisaCardViewController ()<NSURLSessionDelegate>{
    
    NSString *finalUrl;
    NSString *str;
    NSString *jsonString;
}

@end

@implementation VisaCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];

 //   NSLog(@"cart details%@",_cartListDetails);
 //   NSLog(@"cart list%@",_cartList);
    
    str = [[NSUserDefaults standardUserDefaults] valueForKey:@"GiftWrap"];
//    NSLog(@"str %@",str);

    _yourCartisEmptyLbl.hidden = YES;
    _continueShopingBtn.hidden = YES;
    

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];//UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];

    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"DroidSans-Bold" size:20.0],NSFontAttributeName,nil];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        UIButton  *backBtn = [[UIButton alloc] init];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"backWhiteRight.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 15, 15);
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backBarButtonItem;

    }
    else{
        UIButton  *backBtn = [[UIButton alloc] init];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"back-white.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 15, 15);
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backBarButtonItem;
    }
    
    if ([_paymentType isEqualToString:@"TAP"]) {
        
        self.navigationItem.title = (@"Online Payment");

        NSString *totalString = [[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"];
        
        if (totalString.length==0) {
            
            NSString *url = [NSString stringWithFormat:@"http://alhisba.com/api/Tap-ios.php?"];
            finalUrl = [NSString stringWithFormat:@"%@amount=%@&member_id=%@&request_id=%@",
                        url, [[NSUserDefaults standardUserDefaults]valueForKey:@"Price"],[[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"],[[NSUserDefaults standardUserDefaults]valueForKey:@"reqId"]];
            NSLog(@"final url: %@", finalUrl);
        }
        else{
            
            [self showHUD:@""];
            
            NSString *url = [NSString stringWithFormat:@"http://alhisba.com/api/Tap-ios.php?"];
            finalUrl = [NSString stringWithFormat:@"%@amount=%@&member_id=%@&request_id=%@",
                        url, [[NSUserDefaults standardUserDefaults]valueForKey:@"Price"],[[NSUserDefaults standardUserDefaults] valueForKey:@"customer_id"],[[NSUserDefaults standardUserDefaults]valueForKey:@"reqId"]];
            NSLog(@"final url: %@", finalUrl);

        }
        self.webView.delegate = self;
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:finalUrl]]];
    }
    
    else{
         [self placeOrder1];
        
    }
}

-(void)back{
    
        [self.navigationController popViewControllerAnimated:NO];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self hideHUD];
}

#pragma mark - webview delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    BOOL result = YES;
    
    NSURL *url = [request URL];

    if ([[url query] containsString:@"result=failed"]) {
        [self.navigationController popViewControllerAnimated:NO];
        if (self.completionBlock) {
            self.completionBlock(@"failed");
        }
        return YES;
    } else if ([[url query] containsString:@"result=SUCCESS"]) {
        
    //    [self placeOrder];
        
        HomeViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        [self.navigationController pushViewController:obj animated:YES];
    
        return YES;
    }
    //}
    
    return result;
}

-(void)placeOrder1{
    
//    [self makePostCallForPage:PLACE_ORDER withParams:@{@"content":_cartListDetails} withRequestCode:120];
    
//    NSError *error;
//
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_cartListDetails
//                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
//                                                         error:&error];
    
//    if (! jsonData) {
//        NSLog(@"Got an error: %@", error);
//    } else {
//        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
// //       NSLog(@"jsonString %@",jsonString);
//
//        //     [self makePostCallForPage:PLACE_ORDER withParams:@{@"content":jsonString} withRequestCode:1];
//
//        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
//        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
//
//        NSURL * url = [NSURL URLWithString:@"http://clients.mamacgroup.com/sadaleya/api/place-order.php"];
//        NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
//        NSString * params = [NSString stringWithFormat:@"content=%@",jsonString];
//        [urlRequest setHTTPMethod:@"POST"];
//        [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
//
//        NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
//                                                           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
// //    NSLog(@"Response:%@ %@\n", response, error);
//    if(error == nil)
//     {
//    NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
//
//         NSError *error1;
//
//   NSMutableDictionary * innerJson = [NSJSONSerialization
//                                      JSONObjectWithData:data options:kNilOptions error:&error1];
//
//     NSLog(@"Data = %@",text);
//
//
//    NSString *string = @"visaCardView";
////    CashOnDeliveryViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"CashOnDeliveryViewController"];
////    obj.visaCardView = string; // [[NSUserDefaults standardUserDefaults] valueForKey:@"products"];
////    obj.invoiceID = [innerJson valueForKey:@"invoice_id"];
////    [self.navigationController pushViewController:obj animated:NO];
//    }
//    }];
//        [dataTask resume];
//    }

}

-(void)placeOrder{
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_cartListDetails
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"jsonString %@",jsonString);

//    [self makePostCallForPage:PLACE_ORDER withParams:@{@"content":jsonString} withRequestCode:1];
//
//
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_cartListDetails
//                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
//                                                         error:&error];
//
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"jsonString %@",jsonString);

        //     [self makePostCallForPage:PLACE_ORDER withParams:@{@"content":jsonString} withRequestCode:1];

        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];

        NSURL * url = [NSURL URLWithString:@"http://clients.mamacgroup.com/sadaleya/api/place-order.php"];
        NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
        NSString * params = [NSString stringWithFormat:@"content=%@",jsonString];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];

        NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    NSLog(@"result is rajesh:%@ %@\n", response, error);
        if(error == nil)
    {
    NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
        NSLog(@"Data = %@",text);
        
//    NSString *string = @"visaCardView";
//   CartViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"CartViewController"];
//   obj.visaCardView = string; // [[NSUserDefaults standardUserDefaults] valueForKey:@"products"];
//    [self.navigationController pushViewController:obj animated:NO];
    }
    }];
        [dataTask resume];
    }
    
}

-(void)parseResult:(id)result withCode:(int)reqeustCode
{
    
    if (reqeustCode == 1) {

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Order placed succesfully"preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [alertController dismissViewControllerAnimated:YES completion:^{
                
                //            NSString *userId = @"No products";
                //            NSUserDefaults *memberId = [NSUserDefaults standardUserDefaults];
                //            [memberId setObject:userId forKey:@"No products"];
                //            [memberId synchronize];
                
                NSUserDefaults *memberId1 = [NSUserDefaults standardUserDefaults];
                [memberId1 setObject:[NSString stringWithFormat:@"%d",0] forKey:@"GiftWrapCharges"];
                [memberId1 setObject:[NSString stringWithFormat:@"%@",@"0"] forKey:@"SelectWrap"];
                [memberId1 synchronize];
                
                if ([str isEqualToString:@"Selected"]) {
                    
                    NSUserDefaults *memberId = [NSUserDefaults standardUserDefaults];
                    [memberId setObject:[NSString stringWithFormat:@"%@",@"NotSelected"] forKey:@"GiftWrap"];
                    [memberId synchronize];
                }

                NSString *string = @"visaCardView";
//                CartViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"CartViewController"];
//                obj.visaCardView = string; // [[NSUserDefaults standardUserDefaults] valueForKey:@"products"];
        //        [self.navigationController pushViewController:obj animated:NO];
                
                //   [self.navigationController popToRootViewControllerAnimated:YES];
                
            }];
            
        });
    
    }
    
    else if (reqeustCode == 120){
        
        NSLog(@"result is %@",result);
        
//        CashOnDeliveryViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"CashOnDeliveryViewController"];
//        [self.navigationController pushViewController:obj animated:NO];

    }
    else{
        
//        _yourCartisEmptyLbl.hidden = NO;
//        _continueShopingBtn.hidden = NO;
        
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Order placed succesfully"preferredStyle:UIAlertControllerStyleAlert];
//        
//        [self presentViewController:alertController animated:YES completion:nil];
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
//            [alertController dismissViewControllerAnimated:YES completion:^{
//                
//                //            NSString *userId = @"No products";
//                //            NSUserDefaults *memberId = [NSUserDefaults standardUserDefaults];
//                //            [memberId setObject:userId forKey:@"No products"];
//                //            [memberId synchronize];
//                
//                NSUserDefaults *memberId1 = [NSUserDefaults standardUserDefaults];
//                [memberId1 setObject:[NSString stringWithFormat:@"%d",0] forKey:@"GiftWrapCharges"];
//                [memberId1 setObject:[NSString stringWithFormat:@"%@",@"0"] forKey:@"SelectWrap"];
//                [memberId1 synchronize];
//                
//                NSString *string = @"visaCardView";
//                
//                ShoppingCartViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"ShoppingCartViewController"];
//                
//                obj.visaCardView = string; // [[NSUserDefaults standardUserDefaults] valueForKey:@"products"];
//                
//                [self.navigationController pushViewController:obj animated:NO];
//                
//                //            [self.navigationController popToRootViewControllerAnimated:YES];
//                
//            }];
//            
//        });

    }
}

#pragma mark - HUD

- (void) showHUD:(NSString *)labelText {

    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void) hideHUD {
    [SVProgressHUD dismissWithDelay:(NSTimeInterval) 0.2f];
}

@end
