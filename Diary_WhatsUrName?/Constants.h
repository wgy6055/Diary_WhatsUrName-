//
//  Constants.h
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/3/11.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define SECONDS_OF_ONE_DAY 86400
#define DWScreenWidth [UIScreen mainScreen].bounds.size.width
#define DWScreenHeight [UIScreen mainScreen].bounds.size.height
#define DWDiaryCalendarViewHeight 350
#define DWDiaryNavigationBarHeight 109
#define DWDiaryTypingCalendarHeight 145
#define DWDisKeyboardButtonHeight 20
#define DWDisKeyboardButtonWidth 60

#define DWDateViewHeight 165
#define DWDetailTextViewHeight 415

#define DWDiaryAlertViewWidth 250
#define DWDiaryAlertViewHeight 150

#define DWDiaryTipsViewWidth 100
#define DWDiaryTipsViewHeight 50

// RGB颜色
#define DWRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define DWRGBA(R, G, B, A) [UIColor colorWithRed:(R)/255.f green:(G)/255.f blue:(B)/255.f alpha:(A)]
// 主题颜色
#define DWDiaryThemeBlueColor DWRGBColor(70, 130, 180)
#define DWDisKeyboardButtonGrayColor DWRGBColor(201, 201, 201)

#endif /* Constants_h */
