//
//  DWSettingSwitchTableViewCell.m
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/4/8.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import "DWSettingSwitchTableViewCell.h"
#import "DWSettingStore.h"
#import "Constants.h"

@implementation DWSettingSwitchTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *labelTitle = [[UILabel alloc] init];
        labelTitle.text = title;
        labelTitle.font = [UIFont systemFontOfSize:16];
        [labelTitle sizeToFit];
        CGRect rect = labelTitle.frame;
        rect.origin.x = 10;
        rect.origin.y = 50 / 2 - rect.size.height / 2;
        labelTitle.frame = rect;
        [self.contentView addSubview:labelTitle];
        
        [self.contentView addSubview:self.switcher];
    }
    return self;
}

- (UISwitch *)switcher {
    if (!_switcher) {
        _switcher = [[UISwitch alloc] init];
        CGRect rect = _switcher.frame;
        rect.origin.x = DWScreenWidth - rect.size.width - 10;
        rect.origin.y = 50 / 2 - rect.size.height / 2;
        _switcher.frame = rect;
        _switcher.on = [DWSettingStore sharedInstance].isLocked;
        [_switcher addTarget:self action:@selector(switcherValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _switcher;
}

- (void)switcherValueChanged:(UISwitch *)sender {
    [self.delegate switcherValueChanged:sender];
}

@end
