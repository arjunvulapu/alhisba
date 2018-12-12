//
//  TradesTableViewCell.h
//  Alhisba
//
//  Created by apple on 18/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TradesTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *tradesDate;
@property (weak, nonatomic) IBOutlet UILabel *descriptionTitle;
@property (weak, nonatomic) IBOutlet UILabel *priceInKd;
@property (weak, nonatomic) IBOutlet UILabel *priceM2;
@property (weak, nonatomic) IBOutlet UILabel *sizePrice;
@property (weak, nonatomic) IBOutlet UILabel *plotValue;

@property (weak, nonatomic) IBOutlet UITextView *questionLbl;


@property (weak, nonatomic) IBOutlet UIButton *dropDownBtn;


@end
