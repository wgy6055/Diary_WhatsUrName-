//
//  DWPasswordViewController.h
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/4/8.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DWPasswordViewControllerDelegate <NSObject>

- (void)dismissViewController;
- (void)saveKeyIntoDataBase:(NSString *)key;
- (void)setSwitcherValue:(BOOL)value;

- (void)enterApp;

@end

@interface DWPasswordViewController : UIViewController

@property (weak, nonatomic) id<DWPasswordViewControllerDelegate> delegate;
@property (assign, nonatomic) BOOL isSettingMode;

@end
