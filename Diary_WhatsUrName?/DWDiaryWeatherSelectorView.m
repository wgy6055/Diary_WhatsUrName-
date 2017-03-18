//
//  DWDiaryWeatherSelectorView.m
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/3/13.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import "DWDiaryWeatherSelectorView.h"

@interface DWDiaryWeatherSelectorView()

@property (strong, nonatomic) UIWindow *alphaWindow;

@property (strong, nonatomic) UIButton *buttonSunny;
@property (strong, nonatomic) UIButton *buttonCloudy;
@property (strong, nonatomic) UIButton *buttonRain;
@property (strong, nonatomic) UIButton *buttonSnow;

@end

@implementation DWDiaryWeatherSelectorView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        
        [self addSubview:self.buttonSunny];
        [self addSubview:self.buttonCloudy];
        [self addSubview:self.buttonRain];
        [self addSubview:self.buttonSnow];
        
        [self.buttonSunny addTarget:self action:@selector(buttonWeatherTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonCloudy addTarget:self action:@selector(buttonWeatherTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonRain addTarget:self action:@selector(buttonWeatherTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonSnow addTarget:self action:@selector(buttonWeatherTap:) forControlEvents:UIControlEventTouchUpInside];
        
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

- (UIButton *)buttonSunny {
    if (!_buttonSunny) {
        _buttonSunny = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonSunny setImage:[UIImage imageNamed:@"sunny_normal"] forState:UIControlStateNormal];
        _buttonSunny.frame = CGRectMake(25, self.frame.size.height / 2 - 30 / 2, 30, 30);
    }
    return _buttonSunny;
}

- (UIButton *)buttonCloudy {
    if (!_buttonCloudy) {
        _buttonCloudy = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonCloudy setImage:[UIImage imageNamed:@"cloudy_normal"] forState:UIControlStateNormal];
        _buttonCloudy.frame = CGRectMake(CGRectGetMaxX(self.buttonSunny.frame) + 25, self.frame.size.height / 2 - 30 / 2, 30, 30);
    }
    return _buttonCloudy;
}

- (UIButton *)buttonRain {
    if (!_buttonRain) {
        _buttonRain = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonRain setImage:[UIImage imageNamed:@"rain_normal"] forState:UIControlStateNormal];
        _buttonRain.frame = CGRectMake(CGRectGetMaxX(self.buttonCloudy.frame) + 25, self.frame.size.height / 2 - 30 / 2, 30, 30);
    }
    return _buttonRain;
}

- (UIButton *)buttonSnow {
    if (!_buttonSnow) {
        _buttonSnow = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonSnow setImage:[UIImage imageNamed:@"snow_normal"] forState:UIControlStateNormal];
        _buttonSnow.frame = CGRectMake(CGRectGetMaxX(self.buttonRain.frame) + 25, self.frame.size.height / 2 - 30 / 2, 30, 30);
    }
    return _buttonSnow;
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

- (void)buttonWeatherTap:(UIButton *)button {
    if (button == self.buttonSunny) {
        [_delegate setWeatherWithString:@"sunny"];
    } else if (button == self.buttonCloudy) {
        [_delegate setWeatherWithString:@"cloudy"];
    } else if (button == self.buttonRain) {
        [_delegate setWeatherWithString:@"rain"];
    } else if (button == self.buttonSnow) {
        [_delegate setWeatherWithString:@"snow"];
    }
    [self dismissView];
}

@end
