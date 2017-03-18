//
//  DWDiaryCalendarView.m
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/3/11.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import "DWDiaryCalendarView.h"
#import "Constants.h"

@interface DWDiaryCalendarView()

@property (strong, nonatomic) UILabel *labelMonth;
@property (strong, nonatomic) UILabel *labelDay;
@property (strong, nonatomic) UILabel *labelWeek;

@end

@implementation DWDiaryCalendarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.labelMonth];
        [self addSubview:self.labelDay];
        [self addSubview:self.labelWeek];
    }
    return self;
}

- (UILabel *)labelMonth {
    if (!_labelMonth) {
        _labelMonth = [[UILabel alloc] init];
        _labelMonth.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:30];
        _labelMonth.textColor = DWDiaryThemeBlueColor;
    }
    return _labelMonth;
}

- (UILabel *)labelDay {
    if (!_labelDay) {
        _labelDay = [[UILabel alloc] init];
        _labelDay.font = [UIFont fontWithName:@"STHeitiTC-Light" size:100];
        _labelDay.textColor = DWDiaryThemeBlueColor;
    }
    return _labelDay;
}

- (UILabel *)labelWeek {
    if (!_labelWeek) {
        _labelWeek = [[UILabel alloc] init];
        _labelWeek.font = [UIFont fontWithName:@"STHeitiSC-Light" size:28];
        _labelWeek.textColor = DWDiaryThemeBlueColor;
    }
    return _labelWeek;
}

- (void)setDicDate:(NSDictionary *)dicDate {
    if (dicDate) {
        _dicDate = dicDate;
        
        CGRect rect;
        
        self.labelMonth.text = dicDate[@"month"];
        [self.labelMonth sizeToFit];
        rect = self.labelMonth.frame;
        rect.origin.x = self.frame.size.width / 2 - rect.size.width / 2;
        rect.origin.y = 40;
        self.labelMonth.frame = rect;
        
        self.labelDay.text = dicDate[@"day"];
        [self.labelDay sizeToFit];
        rect = self.labelDay.frame;
        rect.origin.x = self.frame.size.width / 2 - rect.size.width / 2;
        rect.origin.y = CGRectGetMaxY(self.labelMonth.frame) + 20;
        self.labelDay.frame = rect;
        
        self.labelWeek.text = dicDate[@"week"];
        [self.labelWeek sizeToFit];
        rect = self.labelWeek.frame;
        rect.origin.x = self.frame.size.width / 2 - rect.size.width / 2;
        rect.origin.y = CGRectGetMaxY(self.labelDay.frame) + 20;
        self.labelWeek.frame = rect;
    }
}

@end
