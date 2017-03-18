//
//  DWDiaryEmotionSelectorView.h
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/3/13.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DWDiaryEmotionSelectorDelegate <NSObject>

- (void)setEmotionWithString:(NSString *)emotion;

@end

@interface DWDiaryEmotionSelectorView : UIView

@property (weak, nonatomic) id<DWDiaryEmotionSelectorDelegate> delegate;

- (void)showAnimated;

@end
