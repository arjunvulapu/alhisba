//
//  MenuViewController.h
//  RevealControllerStoryboardExample
//
//  Created by Nick Hodapp on 1/9/13.
//  Copyright (c) 2013 CoDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SWUITableViewCell : UITableViewCell
@property (nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *subImageView;

@end

@interface MenuViewController : BaseViewController{
    
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toCenter;
@property (nonatomic, strong) NSString *valid;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *logOutBtn;
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scollviewBottom;

- (IBAction)logOutBtnClicked:(id)sender;
- (IBAction)loginBtnTapped:(id)sender;
- (IBAction)registerBtnTapped:(id)sender;
- (IBAction)twitterBtnAction:(id)sender;
- (IBAction)instagramBtnAction:(id)sender;
- (IBAction)whatsappBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *instaImage;
@property (weak, nonatomic) IBOutlet UIImageView *twitterImage;
@property (weak, nonatomic) IBOutlet UIImageView *whatsAppImage;
@property (weak, nonatomic) IBOutlet UIImageView *shareImage;
- (IBAction)shareBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *shareText;
@property (weak, nonatomic) IBOutlet UILabel *ourSocialMediaLbl;

@end
