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
#define DWDiaryNavigationBarHeight (DWScreenHeight*109/667)
#define DWDiarySegmentY (DWScreenHeight*40/667)
#define DWDiaryTypingCalendarHeight (DWScreenHeight*145/667)
#define DWDiaryTypingCalenderSmallHeight (DWScreenHeight*58/667)
#define DWDiaryTypingTextFieldHeight (DWScreenHeight*30/667)
#define DWDiaryTypingTextViewHeight (DWScreenHeight*304/667)
#define DWDiaryTypingToolBarHeight (DWScreenHeight*55/667)
#define DWDisKeyboardButtonHeight 20
#define DWDisKeyboardButtonWidth 60

#define DWDiaryTypingViewHeight (DWScreenHeight*413/667)

#define DWDiaryContentViewWidth (DWScreenWidth*355/375)
#define DWDiaryContentViewHeight (DWScreenHeight*637/667)

#define DWDateViewHeight (DWScreenHeight*165/667)
#define DWDateLabelY (DWScreenHeight*20/667)
#define DWDetailTextViewHeight (DWScreenHeight*415/667)

#define DWDiaryAlertViewWidth (DWScreenWidth*250/375)
#define DWDiaryAlertViewHeight (DWScreenHeight*150/667)

#define DWDiaryTipsViewWidth (DWScreenHeight*100/667)
#define DWDiaryTipsViewHeight (DWScreenWidth*50/375)

// RGB颜色
#define DWRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define DWRGBA(R, G, B, A) [UIColor colorWithRed:(R)/255.f green:(G)/255.f blue:(B)/255.f alpha:(A)]
// 主题颜色
#define DWDiaryThemeBlueColor DWRGBColor(70, 130, 180)
#define DWDisKeyboardButtonGrayColor DWRGBColor(201, 201, 201)

#endif /* Constants_h */
