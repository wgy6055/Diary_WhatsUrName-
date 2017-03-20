//
//  DWDiaryTypingView.m
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/3/12.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import "DWDiaryTypingView.h"
#import "DWDiaryLineImageView.h"
#import "DWDiaryEmotionSelectorView.h"
#import "DWDiaryWeatherSelectorView.h"
#import "DWDiaryTipsView.h"
#import "Constants.h"

@interface DWDiaryTypingView() <DWDiaryEmotionSelectorDelegate, DWDiaryWeatherSelectorDelegate>

@property (strong, nonatomic) UITextField *tFTitle;
@property (strong, nonatomic) UITextView *tVDetail;
@property (strong, nonatomic) UIView *toolBar;

@property (strong, nonatomic) UIButton *buttonEmotion;
@property (strong, nonatomic) UIButton *buttonWeather;
@property (strong, nonatomic) UIButton *buttonSave;

@property (strong, nonatomic) DWDiaryEmotionSelectorView *emotionSelectorView;
@property (strong, nonatomic) DWDiaryWeatherSelectorView *weatherSelectorView;

@property (strong, nonatomic) DWDiaryTipsView *tipsView;

@end

@implementation DWDiaryTypingView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.tFTitle];
        [self addSubview:[[DWDiaryLineImageView alloc] initWithFrame:CGRectMake(0, DWDiaryTypingTextFieldHeight + 5, DWScreenWidth, 10) lineWidth:0.2]];
        [self addSubview:self.tVDetail];
        
        [self addSubview:self.toolBar];
        [self.toolBar addSubview:self.buttonEmotion];
        [self.toolBar addSubview:self.buttonWeather];
        [self.toolBar addSubview:self.buttonSave];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    if (title) {
        _title = title;
        _tFTitle.text = title;
    }
}

- (void)setDetail:(NSString *)detail {
    if (detail) {
        _detail = detail;
        _tVDetail.text = detail;
    }
}

- (void)setEmotion:(NSString *)emotion {
    if (emotion) {
        _emotion = emotion;
        [_buttonEmotion setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlight", emotion]] forState:UIControlStateNormal];
    }
}

- (void)setWeather:(NSString *)weather {
    if (weather) {
        _weather = weather;
        [_buttonWeather setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlight", weather]] forState:UIControlStateNormal];
    }
}

- (UITextField *)tFTitle {
    if (!_tFTitle) {
        _tFTitle = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, DWScreenWidth - 10, DWDiaryTypingTextFieldHeight)];
        _tFTitle.placeholder = @"标题";
        [_tFTitle setBorderStyle:UITextBorderStyleNone];
    }
    return _tFTitle;
}

- (UITextView *)tVDetail {
    if (!_tVDetail) {
        _tVDetail = [[UITextView alloc] initWithFrame:CGRectMake(5, DWDiaryTypingTextFieldHeight + 15, DWScreenWidth - 10, DWDiaryTypingTextViewHeight)];
        _tVDetail.font = [UIFont systemFontOfSize:15];
    }
    return _tVDetail;
}

- (UIView *)toolBar {
    if (!_toolBar) {
        _toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - DWDiaryTypingToolBarHeight, DWScreenWidth, DWDiaryTypingToolBarHeight)];
        _toolBar.backgroundColor = DWDiaryThemeBlueColor;
        
        _buttonEmotion = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonEmotion setImage:[UIImage imageNamed:@"happy_highlight"] forState:UIControlStateNormal];
        _buttonWeather = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonWeather setImage:[UIImage imageNamed:@"sunny_highlight"] forState:UIControlStateNormal];
        _buttonSave = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonSave setImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
        
        _buttonEmotion.frame = CGRectMake(10, _toolBar.frame.size.height / 2 - 25 / 2, 25, 25);
        _buttonWeather.frame = CGRectMake(CGRectGetMaxX(_buttonEmotion.frame) + 10, _buttonEmotion.frame.origin.y, 25, 25);
        _buttonSave.frame = CGRectMake(_toolBar.frame.size.width - 10 - 30, _toolBar.frame.size.height / 2 - 30 / 2, 30, 30);
        
        [_buttonEmotion addTarget:self action:@selector(buttonEmotionTap) forControlEvents:UIControlEventTouchUpInside];
        [_buttonWeather addTarget:self action:@selector(buttonWeatherTap) forControlEvents:UIControlEventTouchUpInside];
        [_buttonSave addTarget:self action:@selector(buttonSaveTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _toolBar;
}

- (DWDiaryTipsView *)tipsView {
    if (!_tipsView) {
        _tipsView = [[DWDiaryTipsView alloc] initWithFrame:CGRectMake(DWScreenWidth / 2 - DWDiaryTipsViewWidth / 2, DWScreenHeight / 3 * 2, DWDiaryTipsViewWidth, DWDiaryTipsViewHeight)];
    }
    return _tipsView;
}

- (void)updateFrameWithDalta:(CGFloat)dalta {
    self.tVDetail.frame = CGRectMake(5, DWDiaryTypingTextFieldHeight + 15, DWScreenWidth - 10, DWDiaryTypingTextViewHeight - dalta);
}

#pragma mark - handle button tap
- (void)buttonEmotionTap {
    _emotionSelectorView = [[DWDiaryEmotionSelectorView alloc] initWithFrame:CGRectMake(DWScreenWidth / 2 - 190 / 2, DWScreenHeight / 2 - 60 / 2, 190, 60)];
    _emotionSelectorView.delegate = self;
    [_emotionSelectorView showAnimated];
}

- (void)buttonWeatherTap {
    _weatherSelectorView = [[DWDiaryWeatherSelectorView alloc] initWithFrame:CGRectMake(DWScreenWidth / 2 - 245 / 2, DWScreenHeight / 2 - 60 / 2, 245, 60)];
    _weatherSelectorView.delegate = self;
    [_weatherSelectorView showAnimated];
}

- (void)buttonSaveTap {
    dispatch_queue_t queue  = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    if ([self.tFTitle.text isEqualToString:@""] && [self.tVDetail.text isEqualToString:@""]) {
        self.tipsView.message = @"日记不能为空";
        [self.tipsView showAnimated];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), queue, ^{
            [self.tipsView disappear];
        });
        return;
    }
    self.tipsView.message = @"已保存";
    [self.tipsView showAnimated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), queue, ^{
        [self.tipsView disappear];
    });
    [_delegate saveModelWithTitle:self.tFTitle.text detail:self.tVDetail.text emotion:self.emotion weather:self.weather];
}

#pragma mark - DWDiaryEmotionSelectorDelegate
- (void)setEmotionWithString:(NSString *)emotion {
    self.emotion = emotion;
}

- (void)setWeatherWithString:(NSString *)weather {
    self.weather = weather;
}

@end
