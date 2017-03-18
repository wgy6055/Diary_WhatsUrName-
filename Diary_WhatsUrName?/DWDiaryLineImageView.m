//
//  DWDiaryLineImageView.m
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/3/12.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import "DWDiaryLineImageView.h"
#import "Constants.h"

@implementation DWDiaryLineImageView

- (instancetype)initWithFrame:(CGRect)frame lineWidth:(CGFloat)width{
    if (self = [super initWithFrame:frame]) {
        UIGraphicsBeginImageContext(self.frame.size);
        [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), width);
        CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 201 / 255, 201 / 255, 201 / 255, 1.0);
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 0, self.frame.size.height / 2);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), self.frame.size.width, self.frame.size.height / 2);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        self.image=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return self;
}

@end
