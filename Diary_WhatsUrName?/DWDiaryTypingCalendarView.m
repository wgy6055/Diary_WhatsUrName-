//
//  DWDiaryTypingCalendarView.m
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/3/12.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import "DWDiaryTypingCalendarView.h"
#import "Constants.h"

@interface DWDiaryTypingCalendarView()

@property (strong, nonatomic) UILabel *labelMonth;
@property (strong, nonatomic) UILabel *labelDay;
@property (strong, nonatomic) UILabel *labelWeek;
@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UIButton *rightButton;

@property (strong, nonatomic) UILabel *labelSmall;

@end

@implementation DWDiaryTypingCalendarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = DWDiaryThemeBlueColor;
        
        [self addSubview:self.labelMonth];
        [self addSubview:self.labelDay];
        [self addSubview:self.labelWeek];
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
    }
    return self;
}

- (UILabel *)labelMonth {
    if (!_labelMonth) {
        _labelMonth = [[UILabel alloc] init];
        _labelMonth.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:20];
        _labelMonth.textColor = [UIColor whiteColor];
    }
    return _labelMonth;
}

- (UILabel *)labelDay {
    if (!_labelDay) {
        _labelDay = [[UILabel alloc] init];
        _labelDay.font = [UIFont fontWithName:@"STHeitiTC-Light" size:40];
        _labelDay.textColor = [UIColor whiteColor];
    }
    return _labelDay;
}

- (UILabel *)labelWeek {
    if (!_labelWeek) {
        _labelWeek = [[UILabel alloc] init];
        _labelWeek.font = [UIFont fontWithName:@"STHeitiSC-Light" size:20];
        _labelWeek.textColor = [UIColor whiteColor];
    }
    return _labelWeek;
}

- (UILabel *)labelSmall {
    if (!_labelSmall) {
        _labelSmall = [[UILabel alloc] init];
        _labelSmall.font = [UIFont fontWithName:@"STHeitiSC-Light" size:15];
        _labelSmall.textColor = [UIColor whiteColor];
    }
    return _labelSmall;
}

- (void)setDicDate:(NSDictionary *)dicDate {
    if (dicDate) {
        _dicDate = dicDate;
        
        CGRect rect;
        
        self.labelMonth.text = dicDate[@"month"];
        [self.labelMonth sizeToFit];
        rect = self.labelMonth.frame;
        rect.origin.x = self.frame.size.width / 2 - rect.size.width / 2;
        rect.origin.y = 8;
        self.labelMonth.frame = rect;
        
        self.labelDay.text = dicDate[@"day"];
        [self.labelDay sizeToFit];
        rect = self.labelDay.frame;
        rect.origin.x = self.frame.size.width / 2 - rect.size.width / 2;
        rect.origin.y = CGRectGetMaxY(self.labelMonth.frame);
        self.labelDay.frame = rect;
        
        self.labelWeek.text = dicDate[@"week"];
        [self.labelWeek sizeToFit];
        rect = self.labelWeek.frame;
        rect.origin.x = self.frame.size.width / 2 - rect.size.width / 2;
        rect.origin.y = CGRectGetMaxY(self.labelDay.frame);
        self.labelWeek.frame = rect;
    }
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(leftButtonTap) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.frame = CGRectMake(5, self.bounds.size.height / 2 - 10, 20, 20);
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightButtonTap) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.frame = CGRectMake(DWScreenWidth - 5 - 20, self.bounds.size.height / 2 - 10, 20, 20);
    }
    return _rightButton;
}

- (void)leftButtonTap {
    [_delegate leftButtonPressed];
}

- (void)rightButtonTap {
    [_delegate rightButtonPressed];
}

- (void)transformToSmallMood {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.labelSmall.text = [NSString stringWithFormat:@"%@%@日，%@", self.dicDate[@"month"], self.dicDate[@"day"], self.dicDate[@"week"]];
    [self.labelSmall sizeToFit];
    CGRect rect = self.labelSmall.frame;
    rect.origin.x = DWScreenWidth / 2 - rect.size.width / 2;
    rect.origin.y = 54 / 2 - rect.size.height / 2 + 5;
    self.labelSmall.frame = rect;
    [self addSubview:self.labelSmall];
}

- (void)transformToNormalMood {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self addSubview:self.labelMonth];
    [self addSubview:self.labelDay];
    [self addSubview:self.labelWeek];
    [self addSubview:self.leftButton];
    [self addSubview:self.rightButton];
}

@end
