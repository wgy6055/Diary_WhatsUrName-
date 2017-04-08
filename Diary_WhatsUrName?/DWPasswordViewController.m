//
//  DWPasswordViewController.m
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/4/8.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import "DWPasswordViewController.h"
#import "DWPasswordNumberButton.h"
#import "DWPasswordDisplayView.h"
#import "DWPasswordChecker.h"
#import "Constants.h"

@interface DWPasswordViewController ()

@property (strong, nonatomic) DWPasswordDisplayView *passwordDisplayView;
@property (strong, nonatomic) NSArray<DWPasswordNumberButton *> *arrayNumButton;
@property (strong, nonatomic) UIButton *buttonBackspace;
@property (strong, nonatomic) UIButton *buttonQuit;

@property (strong, nonatomic) DWPasswordChecker *checker;
@property (copy, nonatomic) NSMutableString *password;

@end

@implementation DWPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.passwordDisplayView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    for (DWPasswordNumberButton *button in self.arrayNumButton) {
        [self.view addSubview:button];
    }
    
    [self.view addSubview:self.buttonBackspace];
    if (self.isSettingMode) {
        [self.view addSubview:self.buttonQuit];
    }
}

- (DWPasswordDisplayView *)passwordDisplayView {
    if (!_passwordDisplayView) {
        _passwordDisplayView = [[DWPasswordDisplayView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - DWPasswordDisplayViewWidth / 2, DWPasswordDisplayViewTopPadding, DWPasswordDisplayViewWidth, DWPasswordDisplayViewHeight)];
    }
    return _passwordDisplayView;
}

- (NSArray *)arrayNumButton {
    if (!_arrayNumButton) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:10];
        for (int i = 1; i <= 9; i++) {
            DWPasswordNumberButton *button = [[DWPasswordNumberButton alloc] initWithFrame:CGRectMake(DWPasswordNumButtonLeftPadding + (DWPasswordNumButtonMargin + DWPasswordNumButtonWidth) * ((i - 1) % 3), DWPasswordNumButtonTopPadding + (DWPasswordNumButtonMargin + DWPasswordNumButtonWidth) * ((i - 1) / 3), DWPasswordNumButtonWidth, DWPasswordNumButtonWidth) number:i];
            button.tag = i;
            [button addTarget:self action:@selector(buttonNumberTap:) forControlEvents:UIControlEventTouchUpInside];
            [array addObject:button];
        }
        DWPasswordNumberButton *button = [[DWPasswordNumberButton alloc] initWithFrame:CGRectMake(DWPasswordNumButtonLeftPadding + (DWPasswordNumButtonMargin + DWPasswordNumButtonWidth), DWPasswordNumButtonTopPadding + (DWPasswordNumButtonMargin + DWPasswordNumButtonWidth) * 3, DWPasswordNumButtonWidth, DWPasswordNumButtonWidth) number:0];
        button.tag = 0;
        [button addTarget:self action:@selector(buttonNumberTap:) forControlEvents:UIControlEventTouchUpInside];
        [array addObject:button];
        _arrayNumButton = [[NSArray alloc] initWithArray:[array copy]];
    }
    return _arrayNumButton;
}

- (UIButton *)buttonBackspace {
    if (!_buttonBackspace) {
        _buttonBackspace = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonBackspace setImage:[UIImage imageNamed:@"backspace"] forState:UIControlStateNormal];
        [_buttonBackspace setFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 34 / 2, CGRectGetMaxY([self.arrayNumButton lastObject].frame) + DWPasswordNumButtonMargin, 34, 25)];
        [_buttonBackspace addTarget:self action:@selector(buttonBackspaceTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonBackspace;
}

- (UIButton *)buttonQuit {
    if (!_buttonQuit) {
        _buttonQuit = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonQuit setTitle:@"取消" forState:UIControlStateNormal];
        [_buttonQuit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _buttonQuit.titleLabel.font = [UIFont fontWithName:@"CourierNewPSMT" size:18];
        [_buttonQuit sizeToFit];
        [_buttonQuit setFrame:CGRectMake(CGRectGetMidX([self.arrayNumButton objectAtIndex:8].frame) - _buttonQuit.frame.size.width / 2, self.buttonBackspace.frame.origin.y, _buttonQuit.frame.size.width, _buttonQuit.frame.size.height)];
        [_buttonQuit addTarget:self action:@selector(buttonQuitTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonQuit;
}

- (DWPasswordChecker *)checker {
    if (!_checker) {
        _checker = [[DWPasswordChecker alloc] init];
    }
    return _checker;
}

- (NSMutableString *)password {
    if (!_password) {
        _password = [[NSMutableString alloc] initWithCapacity:4];
    }
    return _password;
}

#pragma mark - handle tap gesture
- (void)buttonBackspaceTap {
    if (!self.passwordDisplayView.isEmpty) {
        [self.passwordDisplayView minus];
        if (self.password.length > 0) {
            [self.password deleteCharactersInRange:NSMakeRange(self.password.length - 1, 1)];
        }
    }
}

- (void)buttonQuitTap {
    [self.delegate dismissViewController];
    [self.delegate setSwitcherValue:NO];
}

- (void)buttonNumberTap:(DWPasswordNumberButton *)sender {
    if (!self.passwordDisplayView.isFull) {
        [self.passwordDisplayView plus];
        if (self.password.length < 4) {
            [self.password appendString:[NSString stringWithFormat:@"%ld", (long)sender.tag]];
        }
        if (self.password.length == 4) {
            if (self.isSettingMode) {
                [self.delegate saveKeyIntoDataBase:self.password];
                [self.delegate dismissViewController];
            } else {
                if ([self.checker checkPassword:self.password]) {
                    [self.delegate enterApp];
                } else {
                    NSLog(@"no");
                }
            }
        }
    }
}

@end
