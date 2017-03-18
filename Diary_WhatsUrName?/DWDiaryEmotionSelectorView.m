//
//  DWDiaryEmotionSelectorView.m
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/3/13.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import "DWDiaryEmotionSelectorView.h"

@interface DWDiaryEmotionSelectorView()

@property (strong, nonatomic) UIWindow *alphaWindow;

@property (strong, nonatomic) UIButton *buttonHappy;
@property (strong, nonatomic) UIButton *buttonNormal;
@property (strong, nonatomic) UIButton *buttonSad;

@end

@implementation DWDiaryEmotionSelectorView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        
        [self addSubview:self.buttonHappy];
        [self addSubview:self.buttonNormal];
        [self addSubview:self.buttonSad];
        
        [self.buttonHappy addTarget:self action:@selector(buttonEmotionTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonNormal addTarget:self action:@selector(buttonEmotionTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonSad addTarget:self action:@selector(buttonEmotionTap:) forControlEvents:UIControlEventTouchUpInside];
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        recognizer.numberOfTapsRequired = 1;
        [self.alphaWindow addGestureRecognizer:recognizer];
    }
    return self;
}

- (UIWindow *)alphaWindow {
    if (!_alphaWindow) {
        _alphaWindow = [[UIWindow alloc] init];
        _alphaWindow.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _alphaWindow.windowLevel = 100;
    }
    return _alphaWindow;
}

- (UIButton *)buttonHappy {
    if (!_buttonHappy) {
        _buttonHappy = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonHappy setImage:[UIImage imageNamed:@"happy_normal"] forState:UIControlStateNormal];
        _buttonHappy.frame = CGRectMake(25, self.frame.size.height / 2 - 30 / 2, 30, 30);
    }
    return _buttonHappy;
}

- (UIButton *)buttonNormal {
    if (!_buttonNormal) {
        _buttonNormal = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonNormal setImage:[UIImage imageNamed:@"normal_normal"] forState:UIControlStateNormal];
        _buttonNormal.frame = CGRectMake(CGRectGetMaxX(self.buttonHappy.frame) + 25, self.frame.size.height / 2 - 30 / 2, 30, 30);
    }
    return _buttonNormal;
}

- (UIButton *)buttonSad {
    if (!_buttonSad) {
        _buttonSad = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonSad setImage:[UIImage imageNamed:@"sad_normal"] forState:UIControlStateNormal];
        _buttonSad.frame = CGRectMake(CGRectGetMaxX(self.buttonNormal.frame) + 25, self.frame.size.height / 2 - 30 / 2, 30, 30);
    }
    return _buttonSad;
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
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.layer addAnimation:animation forKey:nil];
}

- (void)dismissView {
    [self removeFromSuperview];
    self.alphaWindow.hidden = YES;
}

#pragma mark - handle gesture
- (void)handleTapGesture:(UITapGestureRecognizer *)recognizer {
    if ([recognizer.view isKindOfClass:[UIWindow class]]) {
        [self dismissView];
    }
}

- (void)buttonEmotionTap:(UIButton *)button {
    if (button == self.buttonHappy) {
        [_delegate setEmotionWithString:@"happy"];
    } else if (button == self.buttonNormal) {
        [_delegate setEmotionWithString:@"normal"];
    } else if (button == self.buttonSad) {
        [_delegate setEmotionWithString:@"sad"];
    }
    [self dismissView];
}

@end
