//
//  DWDiaryContentView.m
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/3/13.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import "DWDiaryContentView.h"
#import "DWDiaryAlertView.h"
#import "Constants.h"

@interface DWDiaryContentView() <DWDiaryAlertDelegate>

@property (strong, nonatomic) UIWindow *alphaWindow;

@property (strong, nonatomic) UIView *dateView;
@property (strong, nonatomic) UILabel *labelYearMonth;
@property (strong, nonatomic) UILabel *labelDay;
@property (strong, nonatomic) UILabel *labelWeekTime;
@property (strong, nonatomic) UIButton *buttonQuit;

@property (strong, nonatomic) UITextView *tVDetail;

@property (strong, nonatomic) UIView *toolBar;
@property (strong, nonatomic) UIButton *buttonLast;
@property (strong, nonatomic) UIButton *buttonNext;
@property (strong, nonatomic) UIButton *buttonShare;
@property (strong, nonatomic) UIButton *buttonEdit;
@property (strong, nonatomic) UIButton *buttonDelete;

@property (strong, nonatomic) DWDiaryAlertView *alertView;

@end

@implementation DWDiaryContentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;
        
        [self addSubview:self.dateView];
        [self addSubview:self.tVDetail];
        [self addSubview:self.toolBar];
        
        [self.buttonQuit addTarget:self action:@selector(buttonQuitTap) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonLast addTarget:self action:@selector(buttonLastTap) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonNext addTarget:self action:@selector(buttonNextTap) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonShare addTarget:self action:@selector(buttonShareTap) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonEdit addTarget:self action:@selector(buttonEditTap) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonDelete addTarget:self action:@selector(buttonDeleteTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setDicDate:(NSDictionary *)dicDate {
    if (dicDate) {
        _dicDate = dicDate;
        
        CGRect rect;
        
        self.labelYearMonth.text = [NSString stringWithFormat:@"%@，%@", dicDate[@"year"], dicDate[@"month"]];
        [self.labelYearMonth sizeToFit];
        rect = self.labelYearMonth.frame;
        rect.origin.x = self.dateView.frame.size.width / 2 - rect.size.width / 2;
        rect.origin.y = DWDateLabelY;
        self.labelYearMonth.frame = rect;
        
        self.labelDay.text = dicDate[@"day"];
        [self.labelDay sizeToFit];
        rect = self.labelDay.frame;
        rect.origin.x = self.dateView.frame.size.width / 2 - rect.size.width / 2;
        rect.origin.y = CGRectGetMaxY(self.labelYearMonth.frame);
        self.labelDay.frame = rect;
        
        self.labelWeekTime.text = [NSString stringWithFormat:@"%@ %@", dicDate[@"week"], dicDate[@"time"]];
        [self.labelWeekTime sizeToFit];
        rect = self.labelWeekTime.frame;
        rect.origin.x = self.dateView.frame.size.width / 2 - rect.size.width / 2;
        rect.origin.y = CGRectGetMaxY(self.labelDay.frame);
        self.labelWeekTime.frame = rect;
    }
}

- (void)setDetail:(NSString *)detail {
    if (detail) {
        _detail = detail;
        self.tVDetail.text = detail;
    }
}

- (UIWindow *)alphaWindow {
    if (!_alphaWindow) {
        _alphaWindow = [[UIWindow alloc] init];
        _alphaWindow.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _alphaWindow.windowLevel = 100;
    }
    return _alphaWindow;
}

- (UIView *)dateView {
    if (!_dateView) {
        _dateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, DWDateViewHeight)];
        _dateView.backgroundColor = DWDiaryThemeBlueColor;
        
        [_dateView addSubview:self.labelYearMonth];
        [_dateView addSubview:self.labelDay];
        [_dateView addSubview:self.labelWeekTime];
        [_dateView addSubview:self.buttonQuit];
    }
    return _dateView;
}

- (UILabel *)labelYearMonth {
    if (!_labelYearMonth) {
        _labelYearMonth = [[UILabel alloc] init];
        _labelYearMonth.font = [UIFont fontWithName:@"STHeitiSC-Light" size:15];
        _labelYearMonth.textColor = [UIColor whiteColor];
    }
    return _labelYearMonth;
}

- (UILabel *)labelDay {
    if (!_labelDay) {
        _labelDay = [[UILabel alloc] init];
        _labelDay.font = [UIFont fontWithName:@"STHeitiTC-Light" size:60];
        _labelDay.textColor = [UIColor whiteColor];
    }
    return _labelDay;
}

- (UILabel *)labelWeekTime {
    if (!_labelWeekTime) {
        _labelWeekTime = [[UILabel alloc] init];
        _labelWeekTime.font = [UIFont fontWithName:@"STHeitiSC-Light" size:15];
        _labelWeekTime.textColor = [UIColor whiteColor];
    }
    return _labelWeekTime;
}

-(UIButton *)buttonQuit {
    if (!_buttonQuit) {
        _buttonQuit = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonQuit setImage:[UIImage imageNamed:@"quit"] forState:UIControlStateNormal];
        _buttonQuit.frame = CGRectMake(self.dateView.frame.size.width - 20 - 18, 20, 18, 18);
    }
    return _buttonQuit;
}

- (UITextView *)tVDetail {
    if (!_tVDetail) {
        _tVDetail = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.dateView.frame), self.frame.size.width - 20, DWDetailTextViewHeight)];
        _tVDetail.textColor = DWDiaryThemeBlueColor;
        _tVDetail.font = [UIFont systemFontOfSize:17];
        _tVDetail.editable = NO;
    }
    return _tVDetail;
}

- (UIView *)toolBar {
    if (!_toolBar) {
        _toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tVDetail.frame), self.frame.size.width, self.frame.size.height - DWDateViewHeight - DWDetailTextViewHeight)];
        _toolBar.backgroundColor = DWDiaryThemeBlueColor;
        
        [_toolBar addSubview:self.buttonLast];
        [_toolBar addSubview:self.buttonNext];
        [_toolBar addSubview:self.buttonShare];
        [_toolBar addSubview:self.buttonEdit];
        [_toolBar addSubview:self.buttonDelete];
    }
    return _toolBar;
}

- (UIButton *)buttonLast {
    if (!_buttonLast) {
        _buttonLast = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonLast setImage:[UIImage imageNamed:@"last"] forState:UIControlStateNormal];
        _buttonLast.frame = CGRectMake(10, self.toolBar.frame.size.height / 2 - 25 / 2, 25, 25);
    }
    return _buttonLast;
}

- (UIButton *)buttonNext {
    if (!_buttonNext) {
        _buttonNext = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonNext setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
        _buttonNext.frame = CGRectMake(CGRectGetMaxX(self.buttonLast.frame) + 10, self.toolBar.frame.size.height / 2 - 25 / 2, 25, 25);
    }
    return _buttonNext;
}

- (UIButton *)buttonShare {
    if (!_buttonShare) {
        _buttonShare = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonShare setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        _buttonShare.frame = CGRectMake(self.buttonEdit.frame.origin.x - 10 - 25, self.toolBar.frame.size.height / 2 - 25 / 2, 25, 25);
    }
    return _buttonShare;
}

- (UIButton *)buttonEdit {
    if (!_buttonEdit) {
        _buttonEdit = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonEdit setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
        _buttonEdit.frame = CGRectMake(self.buttonDelete.frame.origin.x - 10 - 25, self.toolBar.frame.size.height / 2 - 25 / 2, 25, 25);
    }
    return _buttonEdit;
}

- (UIButton *)buttonDelete {
    if (!_buttonDelete) {
        _buttonDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonDelete setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        _buttonDelete.frame = CGRectMake(self.toolBar.frame.size.width - 10 - 25, self.toolBar.frame.size.height / 2 - 25 / 2, 25, 25);
    }
    return _buttonDelete;
}

- (DWDiaryAlertView *)alertView {
    if (!_alertView) {
        _alertView = [[DWDiaryAlertView alloc] initWithFrame:CGRectMake(DWScreenWidth / 2 - DWDiaryAlertViewWidth / 2, DWScreenHeight / 2 - DWDiaryAlertViewHeight / 2, DWDiaryAlertViewWidth, DWDiaryAlertViewHeight)];
        _alertView.title = @"确定要删除这篇日记吗？";
        _alertView.message = @"此操作不可逆。请三思。";
        _alertView.delegate = self;
    }
    return _alertView;
}

#pragma mark - handle tap gesture
- (void)buttonQuitTap {
    [self disappearFromBottomAnimated];
}

- (void)buttonLastTap {
    [_delegate updateContentViewWithOffset:-1];
}

- (void)buttonNextTap {
    [_delegate updateContentViewWithOffset:1];
}

- (void)buttonShareTap {
    
}

- (void)buttonEditTap {
    [self buttonQuitTap];
    [_delegate openTypingViewWithDicDate:self.dicDate];
}

- (void)buttonDeleteTap {
    [self.alertView showAnimated];
}

#pragma mark - implementaion
- (void)showAnimated {
    self.alphaWindow.frame = [UIScreen mainScreen].bounds;
    [self.alphaWindow makeKeyAndVisible];
    [self.alphaWindow addSubview:self];
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.25;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.layer addAnimation:animation forKey:nil];
}

- (void)disappearFromBottomAnimated {
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = self.frame;
        self.frame = CGRectMake(rect.origin.x, rect.origin.y + 642, rect.size.width, rect.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.alphaWindow.hidden = YES;
    }];
}

- (void)disappearFromTopAnimated {
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = self.frame;
        self.frame = CGRectMake(rect.origin.x, rect.origin.y - 652, rect.size.width, rect.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.alphaWindow.hidden = YES;
    }];
}

#pragma mark - DWDiaryAlertDelegate
- (void)buttonYesPressed {
    [self disappearFromTopAnimated];
    [_delegate deleteDiaryWithDicDate:self.dicDate];
}

- (void)buttonNoPressed {
}

@end
