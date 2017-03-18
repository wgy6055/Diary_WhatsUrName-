//
//  DWDiaryTipsView.h
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/3/18.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWDiaryTipsView : UIView

@property (copy, nonatomic) NSString *message;

- (void)showAnimated;
- (void)disappear;

@end
