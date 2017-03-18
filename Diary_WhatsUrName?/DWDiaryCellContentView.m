//
//  DWDiaryCellContentView.m
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/3/1.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import "DWDiaryCellContentView.h"
#import "Constants.h"

@interface DWDiaryCellContentView()

@property (strong, nonatomic) UILabel *labelDay;
@property (strong, nonatomic) UILabel *labelWeek;
@property (strong, nonatomic) UILabel *labelTime;
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *labelDetail;
@property (strong, nonatomic) UIImageView *ivWeather;
@property (strong, nonatomic) UIImageView *ivEmotion;

@end

@implementation DWDiaryCellContentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3.0;
        self.layer.masksToBounds = YES;
        
        [self addSubview:self.labelDay];
        [self addSubview:self.labelWeek];
        [self addSubview:self.labelTime];
        [self addSubview:self.labelTitle];
        [self addSubview:self.labelDetail];
        [self addSubview:self.ivWeather];
        [self addSubview:self.ivEmotion];
    }
    return self;
}

- (UILabel *)labelDay {
    if (!_labelDay) {
        _labelDay = [[UILabel alloc] init];
        _labelDay.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:23];
        _labelDay.textColor = DWDiaryThemeBlueColor;
    }
    return _labelDay;
}

- (UILabel *)labelWeek {
    if (!_labelWeek) {
        _labelWeek = [[UILabel alloc] init];
        _labelWeek.font = [UIFont fontWithName:@"CourierNewPSMT" size:10];
        _labelWeek.textColor = DWDiaryThemeBlueColor;
    }
    return _labelWeek;
}

- (UILabel *)labelTime {
    if (!_labelTime) {
        _labelTime = [[UILabel alloc] init];
        _labelTime.font = [UIFont fontWithName:@"STHeitiSC-Light" size:10];
        _labelTime.textColor = DWDiaryThemeBlueColor;
    }
    return _labelTime;
}

- (UILabel *)labelTitle {
    if (!_labelTitle) {
        _labelTitle = [[UILabel alloc] init];
        _labelTitle.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:14];
        _labelTitle.textColor = DWDiaryThemeBlueColor;
    }
    return _labelTitle;
}

- (UILabel *)labelDetail {
    if (!_labelDetail) {
        _labelDetail = [[UILabel alloc] init];
        _labelDetail.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12];
        _labelDetail.textColor = DWDiaryThemeBlueColor;
    }
    return _labelDetail;
}

- (UIImageView *)ivWeather {
    if (!_ivWeather) {
        _ivWeather = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 40 - 20, 12, 20, 20)];
    }
    return _ivWeather;
}

- (UIImageView *)ivEmotion {
    if (!_ivEmotion) {
        _ivEmotion = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 20 - 10 , 12, 20, 20)];
    }
    return _ivEmotion;
}

- (void)setDicDate:(NSDictionary *)dicDate {
    if (dicDate) {
        _dicDate = dicDate;
        
        CGFloat margin = 12.0;
        CGFloat marginTime = 8.0;
        CGRect rect;
        
        self.labelDay.text = dicDate[@"day"];
        [self.labelDay sizeToFit];
        rect = self.labelDay.frame;
        rect.origin.x = margin;
        rect.origin.y = margin - 2;
        self.labelDay.frame = rect;
        
        self.labelWeek.text = dicDate[@"week"];
        [self.labelWeek sizeToFit];
        rect = self.labelWeek.frame;
        rect.origin.x = margin;
        rect.origin.y = CGRectGetMaxY(self.labelDay.frame) + 3;
        self.labelWeek.frame = rect;
        
        self.labelTime.text = dicDate[@"time"];
        [self.labelTime sizeToFit];
        rect = self.labelTime.frame;
        rect.origin.x = CGRectGetMaxX(self.labelDay.frame) + margin;
        rect.origin.y = marginTime;
        self.labelTime.frame = rect;
    }
}

- (void)setTitle:(NSString *)title {
    if (title) {
        _title = title;
        CGRect rect;
        self.labelTitle.text = title;
        [self.labelTitle sizeToFit];
        rect = self.labelTitle.frame;
        rect.origin.x = self.labelTime.frame.origin.x;
        rect.origin.y = CGRectGetMaxY(self.labelTime.frame) + 1.5;
        self.labelTitle.frame = rect;
    }
}

- (void)setDetail:(NSString *)detail {
    if (detail) {
        _detail = detail;
        CGRect rect;
        self.labelDetail.text = detail;
        [self.labelDetail sizeToFit];
        rect = self.labelDetail.frame;
        rect.origin.x = self.labelTime.frame.origin.x;
        rect.origin.y = CGRectGetMaxY(self.labelTitle.frame) + 1.5;
        rect.size.width = 100;
        self.labelDetail.frame = rect;
    }
}

- (void)setWeather:(NSString *)weather {
    if (weather) {
        _weather = weather;
        self.ivWeather.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_blue", weather]];
    }
}

- (void)setEmotion:(NSString *)emotion {
    if (emotion) {
        _emotion = emotion;
        self.ivEmotion.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_blue", emotion]];
    }
}

@end
