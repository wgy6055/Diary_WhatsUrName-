//
//  DWDiaryWeatherSelectorView.h
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/3/13.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DWDiaryWeatherSelectorDelegate <NSObject>

- (void)setWeatherWithString:(NSString *)weather;

@end

@interface DWDiaryWeatherSelectorView : UIView

@property (weak, nonatomic) id<DWDiaryWeatherSelectorDelegate> delegate;

- (void)showAnimated;

@end
