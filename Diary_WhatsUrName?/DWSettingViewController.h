//
//  DWSettingViewController.h
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/4/8.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CompletionBlock) (void);

@protocol DWSettingViewControllerDelegate <NSObject>

- (void)dismissViewController;

@end

@interface DWSettingViewController : UIViewController

@property (weak, nonatomic) id<DWSettingViewControllerDelegate> delegate;

@end
