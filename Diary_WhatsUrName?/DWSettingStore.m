//
//  DWSettingStore.m
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/4/8.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import "DWSettingStore.h"

@implementation DWSettingStore

static id _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    }
    return _instance;
}

+ (instancetype)sharedInstance {
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }
    return _instance;
}

@end
