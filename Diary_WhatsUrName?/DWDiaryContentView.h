//
//  DWDiaryContentView.h
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/3/13.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DWDiaryContentViewDelegate <NSObject>

- (void)openTypingViewWithDicDate:(NSDictionary *)dicDate;
- (void)deleteDiaryWithDicDate:(NSDictionary *)dicDate;
- (void)updateContentViewWithOffset:(NSInteger)offset;

@end

@interface DWDiaryContentView : UIView

@property (strong, nonatomic) NSDictionary *dicDate;
@property (strong, nonatomic) NSString *detail;

@property (weak, nonatomic) id<DWDiaryContentViewDelegate> delegate;

- (void)showAnimated;

@end
