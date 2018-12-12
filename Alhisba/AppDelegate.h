//
//  AppDelegate.h
//  Alhisba
//
//  Created by apple on 18/07/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
- (void)reloadUIForLanguageChange;
- (void)downloadSettings;
- (void)downloadSettingsWithOutLOCK;
@property(strong,nonatomic) NSString *fromPushOrNot;

@end

