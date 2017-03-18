//
//  DWDiaryTipsView.m
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/3/18.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import "DWDiaryTipsView.h"

@interface DWDiaryTipsView()

@property (strong, nonatomic) UIWindow *alphaWindow;

@property (strong, nonatomic) UILabel *labelMessage;

@end

@implementation DWDiaryTipsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;
        
        [self addSubview:self.labelMessage];
    }
    return self;
}

- (UIWindow *)alphaWindow {
    if (!_alphaWindow) {
        _alphaWindow = [[UIWindow alloc] init];
        _alphaWindow.backgroundColor = [UIColor clearColor];
        _alphaWindow.windowLevel = 100;
    }
    return _alphaWindow;
}

- (UILabel *)labelMessage {
    if (!_labelMessage) {
        _labelMessage = [[UILabel alloc] init];
        _labelMessage.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:14];
        _labelMessage.textColor = [UIColor whiteColor];
    }
    return _labelMessage;
}

- (void)setMessage:(NSString *)message {
    if (message) {
        _message = message;
        self.labelMessage.text = message;
        [self.labelMessage sizeToFit];
        CGRect rect = self.labelMessage.frame;
        rect.origin.x = self.frame.size.width / 2 - rect.size.width / 2;
        rect.origin.y = self.frame.size.height / 2 - rect.size.height / 2;
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

- (void)disappear {
    [self removeFromSuperview];
    self.alphaWindow.hidden = YES;
}

@end
