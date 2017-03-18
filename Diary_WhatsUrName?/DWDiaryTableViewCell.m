//
//  DWDiaryTableViewCell.m
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/3/1.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import "DWDiaryTableViewCell.h"
#import "DWDiaryCellContentView.h"

#define DWScreenWidth [UIScreen mainScreen].bounds.size.width

@interface DWDiaryTableViewCell()

@property (strong, nonatomic) DWDiaryCellContentView *cellContentView;

@end

@implementation DWDiaryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        _cellContentView = [[DWDiaryCellContentView alloc] initWithFrame:CGRectMake(8, 8, DWScreenWidth - 16, 74)];
        [self.contentView addSubview:_cellContentView];
        
    }
    return self;
}

- (void)setDicDate:(NSDictionary *)dicDate {
    if (dicDate) {
        _dicDate = dicDate;
        _cellContentView.dicDate = dicDate;
    }
}

- (void)setTitle:(NSString *)title {
    if (title) {
        _title = title;
        _cellContentView.title = title;
    }
}

- (void)setDetail:(NSString *)detail {
    if (detail) {
        _detail = detail;
        _cellContentView.detail = detail;
    }
}

- (void)setEmotion:(NSString *)emotion {
    if (emotion) {
        _emotion = emotion;
        _cellContentView.emotion = emotion;
    }
}

- (void)setWeather:(NSString *)weather {
    if (weather) {
        _weather = weather;
        _cellContentView.weather = weather;
    }
}

@end
