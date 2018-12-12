//
//  detailsViewController.m
//  Alhisba
//
//  Created by apple on 03/08/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "detailsViewController.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "JBWhatsAppActivity.h"


@interface detailsViewController (){
    
    UIButton *backBtn,*menuBtn;
    NSString *shareLink;
}

@end

@implementation detailsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    UIImage *image = [UIImage imageNamed: @"NavImage.png"];
    [navigationBar setBackgroundImage:image forBarMetrics: UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    //UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    ////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_AR]) {
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:20],NSFontAttributeName,nil];
    }
    else{
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:20],NSFontAttributeName,nil];
    }
    
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
    
    menuBtn = [[UIButton alloc] init];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"shareWhite.png"] forState:UIControlStateNormal];
    menuBtn.frame = CGRectMake(0, 0, 30, 30);
    [menuBtn addTarget:self action:@selector(shareBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    self.navigationItem.rightBarButtonItem = backBarButtonItem;
    
    _detailsTitle.text = [_detailsDic valueForKey:@"title_english"];
    _detailsPostedOn.text = [_detailsDic valueForKey:@"posted_on"];
    _detailspostedBy.text = [_detailsDic valueForKey:@"posted_by_english"];
    
    [_detailsImageView setImageWithURL:[_detailsDic valueForKey:@"image"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
 
    NSString *htmlString = [_detailsDic  valueForKey:@"content_english"];
    shareLink = [_detailsDic  valueForKey:@"link"];

//    NSRange allOfStr = NSMakeRange(0, [htmlString length]);
//    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  //  paragraphStyle.alignment = NSTextAlignmentJustified;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                            initWithData: [htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                            documentAttributes: nil
                                            error: nil
                                            ];


//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle];
//    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, attributedString.length)];
//    NSMutableParagraphStyle *paragraphStyles = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyles.alignment = NSTextAlignmentJustified;
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyles range:NSMakeRange(0, attributedString.length)];

    _detailsDes.attributedText = attributedString;
    //_detailsDes.contentInset = UIEdgeInsetsMake(-7.0,0.0,0,0.0);
    _detailsDes.textColor = [UIColor whiteColor];

}

-(void)shareBtnTapped{
    
//    WhatsAppMessage *whatsappMsg = [[WhatsAppMessage alloc] initWithMessage:[_detailsDic  valueForKey:@"link"] forABID:@"Alhisba"];
//
//    NSArray *applicationActivities = @[[[JBWhatsAppActivity alloc] init]];
//    NSArray *excludedActivities    = @[UIActivityTypePrint, UIActivityTypePostToWeibo, UIActivityTypeMessage];
//    NSArray *activityItems         = @[[_detailsDic  valueForKey:@"link"], whatsappMsg];
//
//    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:applicationActivities];
//    activityViewController.excludedActivityTypes = excludedActivities;
//
//    [self presentViewController:activityViewController animated:YES completion:^{}];
    
    NSString *str = [_detailsDic  valueForKey:@"link"];
    
    NSMutableArray *activityItems = [NSMutableArray arrayWithObjects: str, nil];
    
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

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:NO];
}

@end
