//
//  DWDiaryTypingCalendarView.h
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/3/12.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DWDiaryTypingCalendarDelegate <NSObject>

- (void)leftButtonPressed;
- (void)rightButtonPressed;

@end

@interface DWDiaryTypingCalendarView : UIView

@property (strong, nonatomic) NSDictionary *dicDate;
@property (weak, nonatomic) id<DWDiaryTypingCalendarDelegate> delegate;

- (void)transformToSmallMood;
- (void)transformToNormalMood;

@end
