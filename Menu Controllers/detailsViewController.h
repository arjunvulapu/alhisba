//
//  detailsViewController.h
//  Alhisba
//
//  Created by apple on 03/08/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface detailsViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *detailsImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailsTitle;
@property (weak, nonatomic) IBOutlet UILabel *detailsPostedOn;
@property (weak, nonatomic) IBOutlet UILabel *detailspostedBy;
@property (weak, nonatomic) IBOutlet UITextView *detailsDes;

@property (strong, nonatomic)NSMutableDictionary *detailsDic;

@end
