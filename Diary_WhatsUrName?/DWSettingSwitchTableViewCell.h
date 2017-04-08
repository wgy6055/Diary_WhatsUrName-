//
//  DWSettingSwitchTableViewCell.h
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/4/8.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DWSettingSwitchCellDelegate <NSObject>

- (void)switcherValueChanged:(UISwitch *)sender;

@end

@interface DWSettingSwitchTableViewCell : UITableViewCell

@property (strong, nonatomic) UISwitch *switcher;
@property (weak, nonatomic) id<DWSettingSwitchCellDelegate> delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier title:(NSString *)title;

@end
