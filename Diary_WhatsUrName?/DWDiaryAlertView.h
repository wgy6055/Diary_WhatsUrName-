//
//  DWDiaryAlertView.h
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/3/18.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DWDiaryAlertDelegate <NSObject>

- (void)buttonYesPressed;
- (void)buttonNoPressed;

@end

@interface DWDiaryAlertView : UIView

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *message;

@property (weak, nonatomic) id<DWDiaryAlertDelegate> delegate;

- (void)showAnimated;

@end
