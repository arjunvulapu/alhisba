//
//  SelectArea1ViewController.h
//  Minwain
//
//  Created by Amit Kulkarni on 10/05/16.
//  Copyright © 2016 Amit Kulkarni. All rights reserved.
//

#import "BaseViewController.h"
#import "PopViewControllerDelegate.h"
#import "Addres.h"
#import "ExistAddres.h"

@interface SelectExistAdresViewController : BaseViewController
@property (nonnull) id<PopViewControllerDelegate> delegate;
@property (nonatomic) NSString *restId;
@property (nonatomic, copy) void (^completionBlock)(ExistAddres *address);

@property (weak, nonatomic) IBOutlet UILabel *noAddresLbl;

@end
