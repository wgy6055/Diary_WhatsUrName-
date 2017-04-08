//
//  DWSettingStore.h
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/4/8.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWSettingStore : NSObject

@property (assign, nonatomic) BOOL isLocked;

+ (instancetype)sharedInstance;

@end
