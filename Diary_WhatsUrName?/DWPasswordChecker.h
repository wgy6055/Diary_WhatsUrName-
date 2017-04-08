//
//  DWPasswordChecker.h
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/4/8.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWPasswordChecker : NSObject

// 返回密码校验结果
- (BOOL)checkPassword:(NSString *)password;

// 更新密码
- (void)updateKey:(NSString *)key;

@end
