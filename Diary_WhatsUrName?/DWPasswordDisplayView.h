//
//  DWPasswordDisplayView.h
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/4/8.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWPasswordDisplayView : UIView

@property (assign, nonatomic) BOOL isEmpty;
@property (assign, nonatomic) BOOL isFull;

- (void)plus;
- (void)minus;

@end
