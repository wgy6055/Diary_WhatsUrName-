//
//  DWDiaryCellContentView.h
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/3/1.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWDiaryCellContentView : UIView

@property (strong, nonatomic) NSDictionary *dicDate;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *detail;
@property (strong, nonatomic) NSString *weather;
@property (strong, nonatomic) NSString *emotion;

@end
