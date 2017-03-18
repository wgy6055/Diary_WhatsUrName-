//
//  DWDiaryAlertView.m
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/3/18.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import "DWDiaryAlertView.h"
#import "Constants.h"

@interface DWDiaryAlertView()

@property (strong, nonatomic) UIWindow *alphaWindow;

@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *labelMessage;

@property (strong, nonatomic) UIButton *buttonYes;
@property (strong, nonatomic) UIButton *buttonNo;

@end

@implementation DWDiaryAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = DWDiaryThemeBlueColor;
        
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;
        
        [self.buttonYes addTarget:self action:@selector(buttonYesTap) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonNo addTarget:self action:@selector(buttonNoTap) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.labelTitle];
        [self addSubview:self.labelMessage];
        [self addSubview:self.buttonYes];
        [self addSubview:self.buttonNo];
    }
    return self;
}

- (UIWindow *)alphaWindow {
    if (!_alphaWindow) {
        _alphaWindow = [[UIWindow alloc] init];
        _alphaWindow.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _alphaWindow.windowLevel = 101;
    }
    return _alphaWindow;
}

- (UILabel *)labelTitle {
    if (!_labelTitle) {
        _labelTitle = [[UILabel alloc] init];
        _labelTitle.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:18];
        _labelTitle.textColor = [UIColor whiteColor];
    }
    return _labelTitle;
}

- (UILabel *)labelMessage {
    if (!_labelMessage) {
        _labelMessage = [[UILabel alloc] init];
        _labelMessage.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12];
        _labelMessage.textColor = [UIColor whiteColor];
    }
    return _labelMessage;
}

- (UIButton *)buttonNo {
    if (!_buttonNo) {
        _buttonNo = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonNo setImage:[UIImage imageNamed:@"no"] forState:UIControlStateNormal];
        _buttonNo.frame = CGRectMake(30, self.frame.size.height - 15 - 28, 28, 28);
    }
    return _buttonNo;
}

- (UIButton *)buttonYes {
    if (!_buttonYes) {
        _buttonYes = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonYes setImage:[UIImage imageNamed:@"yes"] forState:UIControlStateNormal];
        _buttonYes.frame = CGRectMake(self.frame.size.width - 28 - 30, self.buttonNo.frame.origin.y - 5, 35, 35);
    }
    return _buttonYes;
}

- (void)setTitle:(NSString *)title {
    if (title) {
        _title = title;
        self.labelTitle.text = title;
        [self.labelTitle sizeToFit];
        CGRect rect = self.labelTitle.frame;
        rect.origin.x = self.frame.size.width / 2 - rect.size.width / 2;
        rect.origin.y = 10;
        self.labelTitle.frame = rect;
    }
}

- (void)setMessage:(NSString *)message {
    if (message) {
        _message = message;
        self.labelMessage.text = message;
        [self.labelMessage sizeToFit];
        CGRect rect = self.labelMessage.frame;
        rect.origin.x = self.frame.size.width / 2 - rect.size.width / 2;
        rect.origin.y = CGRectGetMaxY(self.labelTitle.frame) + 10;
        self.labelMessage.frame = rect;
    }
}

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

#pragma mark - handle tap gesture
- (void)buttonYesTap {
    [_delegate buttonYesPressed];
    [self removeFromSuperview];
    self.alphaWindow.hidden = YES;
}

- (void)buttonNoTap {
    [_delegate buttonNoPressed];
    [self removeFromSuperview];
    self.alphaWindow.hidden = YES;
}

@end
