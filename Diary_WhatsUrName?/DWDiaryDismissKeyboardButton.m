//
//  DWDiaryDismissKeyboardButton.m
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/3/12.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import "DWDiaryDismissKeyboardButton.h"
#import "Constants.h"

@implementation DWDiaryDismissKeyboardButton

- (instancetype)init {
    self = [[super class] buttonWithType:UIButtonTypeCustom];
    if (self) {
        self.backgroundColor = DWDisKeyboardButtonGrayColor;
        [self setTitle:@"隐藏键盘" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

@end
