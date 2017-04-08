//
//  DWPasswordDisplayView.m
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/4/8.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import "DWPasswordDisplayView.h"
#import "Constants.h"

@interface DWPasswordDisplayView()

@property (strong, nonatomic) NSArray<UIImageView *> *arrayImageView;

@end

@implementation DWPasswordDisplayView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        for (UIImageView *imageView in self.arrayImageView) {
            [self addSubview:imageView];
        }
        self.isFull = NO;
        self.isEmpty = YES;
    }
    return self;
}

- (NSArray<UIImageView *> *)arrayImageView {
    if (!_arrayImageView) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:4];
        for (int i = 0; i < 4; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"space"]];
            [imageView setHighlightedImage:[UIImage imageNamed:@"point"]];
            [imageView setFrame:CGRectMake((DWPasswordSpaceWidth + DWPasswordSpaceMargin) * i, self.frame.size.height / 2 - DWPasswordSpaceHeight / 2, DWPasswordSpaceWidth, DWPasswordSpaceHeight)];
            [array addObject:imageView];
        }
        _arrayImageView = [[NSArray alloc] initWithArray:[array copy]];
    }
    return _arrayImageView;
}

- (void)plus {
    int i = 0;
    for (; i < 4; i++) {
        if (!self.arrayImageView[i].highlighted) {
            self.arrayImageView[i].highlighted = YES;
            break;
        }
    }
    if (i == 3) {
        self.isFull = YES;
    }
    self.isEmpty = NO;
}

- (void)minus {
    int i = 3;
    for (; i >= 0; i--) {
        if (self.arrayImageView[i].highlighted) {
            self.arrayImageView[i].highlighted = NO;
            break;
        }
    }
    if (i == 0) {
        self.isEmpty = YES;
    }
    self.isFull = NO;
}

@end
