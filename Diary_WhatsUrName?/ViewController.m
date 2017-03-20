//
//  ViewController.m
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/3/1.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import "ViewController.h"
#import "DWDiaryTableViewCell.h"
#import "DWDiaryCalendarScrollView.h"
#import "DWDiaryTypingCalendarView.h"
#import "DWDiaryTypingView.h"
#import "DWDiaryDismissKeyboardButton.h"
#import "DWDiaryContentView.h"
#import "Constants.h"

#import "AppDelegate.h"

typedef enum : NSUInteger {
    CONTROLLER_MODE_BROWSE,
    CONTROLLER_MODE_CALENDAR,
    CONTROLLER_MODE_TYPING,
} DWControllerMode;

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, DWDiaryTypingCalendarDelegate, DWDiaryTypingDelegate, DWDiaryContentViewDelegate>

@property (strong, nonatomic) NSMutableArray *arrayModel;
@property (strong, nonatomic) NSMutableArray *arrayModelDay;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *navigationBar;
@property (strong, nonatomic) UISegmentedControl *segment;
@property (strong, nonatomic) UILabel *labelTheme;
@property (strong, nonatomic) DWDiaryCalendarScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray *arrayTodayDics;

@property (strong, nonatomic) DWDiaryTypingCalendarView *pickerView;
@property (strong, nonatomic) DWDiaryTypingView *typingView;
@property (strong, nonatomic) DWDiaryDismissKeyboardButton *disKeyboardButton;

@property (strong, nonatomic) DWDiaryContentView *contentView;
@property (strong, nonatomic) NSIndexPath *currentIndexPath;

@property (assign, nonatomic) DWControllerMode controllerMode;

@end

@implementation ViewController {
    CGFloat _startContentOffsetX;
    CGFloat _willEndContentOffsetX;
    CGFloat _endContentOffsetX;
}

+ (NSArray *)arrayMonth
{
    static NSArray *_month;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _month = @[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"];
    });
    return _month;
}

+ (NSArray *)arrayWeekDay
{
    static NSArray *_weekDay;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _weekDay = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    });
    return _weekDay;
}

+ (NSArray *)arrayFormatNumber {
    static NSArray *_formatNumber;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _formatNumber = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09"];
    });
    return _formatNumber;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgd"]]];
    
    CGRect rect = self.view.bounds;
    
    _arrayModel = [[NSMutableArray alloc] init];
    [self updateTableViewDataSourceFromDataBase];
    
    _arrayModelDay = [[NSMutableArray alloc] init];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, DWDiaryNavigationBarHeight, rect.size.width, rect.size.height - CGRectGetHeight(_navigationBar.frame)) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, DWDiaryNavigationBarHeight)];
    _navigationBar.backgroundColor = [UIColor whiteColor];
    _segment = [[UISegmentedControl alloc] initWithItems:@[@"浏览", @"日历", @"撰写"]];
    _segment.tintColor = DWDiaryThemeBlueColor;
    _segment.frame = CGRectMake(50, DWDiarySegmentY, rect.size.width - 100, 25);
    [_segment addTarget:self action:@selector(didChangeValueOfSegmentControl:) forControlEvents:UIControlEventValueChanged];
    _segment.selectedSegmentIndex = 0;
    [_navigationBar addSubview:_segment];
    
    _labelTheme = [[UILabel alloc] init];
    _labelTheme.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:20];
    _labelTheme.textColor = DWDiaryThemeBlueColor;
    _labelTheme.text = @"日记";
    [_labelTheme sizeToFit];
    CGRect labelRect = _labelTheme.frame;
    labelRect.origin.x = _navigationBar.frame.size.width / 2 - labelRect.size.width / 2;
    labelRect.origin.y = CGRectGetMaxY(_segment.frame) / 2 + DWDiaryNavigationBarHeight / 2 - 12;
    _labelTheme.frame = labelRect;
    [_navigationBar addSubview:_labelTheme];
    
    [self.view addSubview:_navigationBar];
    
    _scrollView = [[DWDiaryCalendarScrollView alloc] initWithFrame:CGRectMake(0, DWDiaryNavigationBarHeight, rect.size.width, DWDiaryCalendarViewHeight)];
    _scrollView.delegate = self;
    _scrollView.arrayDayDics = self.arrayTodayDics;
    _scrollView.currentIndex = 2;
    [_scrollView setContentOffset:CGPointMake(DWScreenWidth * 2, 0)];
    
    _pickerView = [[DWDiaryTypingCalendarView alloc] initWithFrame:CGRectMake(0, DWDiaryNavigationBarHeight, DWScreenWidth, DWDiaryTypingCalendarHeight)];
    _pickerView.dicDate = self.arrayTodayDics[2];
    _pickerView.delegate = self;
    
    _typingView = [[DWDiaryTypingView alloc] initWithFrame:CGRectMake(0, DWDiaryNavigationBarHeight + DWDiaryTypingCalendarHeight, DWScreenWidth, DWScreenHeight - CGRectGetMaxY(_pickerView.frame))];
    _typingView.delegate = self;
    
    _disKeyboardButton = [[DWDiaryDismissKeyboardButton alloc] init];
    [_disKeyboardButton setFrame:CGRectMake(DWScreenWidth - DWDisKeyboardButtonWidth, DWDisKeyboardButtonHeight + DWDisKeyboardButtonHeight, DWDisKeyboardButtonWidth, DWDisKeyboardButtonHeight)];

    _controllerMode = CONTROLLER_MODE_BROWSE;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
    
    //注册通知,监听键盘弹出事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //注册通知,监听键盘消失事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    [_disKeyboardButton addTarget:self action:@selector(dismissKeyboardTap) forControlEvents:UIControlEventTouchUpInside];
}

- (NSMutableArray *)arrayTodayDics {
    if (!_arrayTodayDics) {
        _arrayTodayDics = [[NSMutableArray alloc] initWithCapacity:5];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSArray *MONTH = [[self class] arrayMonth];
        NSArray *WEEKDAY = [[self class] arrayWeekDay];
        
        for (int i = -2; i < 3; i++) {
            NSDateComponents *addingDateComponents = [[NSDateComponents alloc] init];
            [addingDateComponents setDay:i];
            NSDate *date = [calendar dateByAddingComponents:addingDateComponents toDate:[NSDate date] options:0];
            NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:date];
            [_arrayTodayDics insertObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld年", components.year], @"year", MONTH[components.month - 1], @"month", [NSString stringWithFormat:@"%ld", (long)components.day], @"day", WEEKDAY[components.weekday - 1], @"week", date, @"date", nil] atIndex:i + 2];
        }
    }
    return _arrayTodayDics;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_segment.selectedSegmentIndex == 0) {
        return _arrayModel.count;
    } else {
        return _arrayModelDay.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DWDiaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[DWDiaryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (_segment.selectedSegmentIndex == 0) {
        NSString *time = [self getTimeFromDate:[_arrayModel[indexPath.row] valueForKey:@"date"]];
        cell.dicDate = [[NSDictionary alloc] initWithObjectsAndKeys:[_arrayModel[indexPath.row] valueForKey:@"year"], @"year", [_arrayModel[indexPath.row] valueForKey:@"month"], @"month",[_arrayModel[indexPath.row] valueForKey:@"day"], @"day", [_arrayModel[indexPath.row] valueForKey:@"week"], @"week", time, @"time", [_arrayModel[indexPath.row] valueForKey:@"date"], @"date", nil];
        cell.title = [_arrayModel[indexPath.row] valueForKey:@"title"];
        cell.detail = [_arrayModel[indexPath.row] valueForKey:@"detail"];
        cell.emotion = [_arrayModel[indexPath.row] valueForKey:@"emotion"];
        cell.weather = [_arrayModel[indexPath.row] valueForKey:@"weather"];
    } else {
        NSString *time = [self getTimeFromDate:[_arrayModelDay[indexPath.row] valueForKey:@"date"]];
        cell.dicDate = [[NSDictionary alloc] initWithObjectsAndKeys:[_arrayModelDay[indexPath.row] valueForKey:@"year"], @"year", [_arrayModelDay[indexPath.row] valueForKey:@"month"], @"month",[_arrayModelDay[indexPath.row] valueForKey:@"day"], @"day", [_arrayModelDay[indexPath.row] valueForKey:@"week"], @"week", time, @"time", [_arrayModelDay[indexPath.row] valueForKey:@"date"], @"date", nil];
        cell.title = [_arrayModelDay[indexPath.row] valueForKey:@"title"];
        cell.detail = [_arrayModelDay[indexPath.row] valueForKey:@"detail"];
        cell.emotion = [_arrayModelDay[indexPath.row] valueForKey:@"emotion"];
        cell.weather = [_arrayModelDay[indexPath.row] valueForKey:@"weather"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _contentView = [[DWDiaryContentView alloc] initWithFrame:CGRectMake(10, 25, DWDiaryContentViewWidth, DWDiaryContentViewHeight)];
    _contentView.delegate = self;
    DWDiaryTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _contentView.dicDate = cell.dicDate;
    _contentView.detail = cell.detail;
    [_contentView showAnimated];
    _currentIndexPath = indexPath;
}

- (void)didChangeValueOfSegmentControl:(UISegmentedControl *)segment {
    switch (segment.selectedSegmentIndex) {
        case 0: {
            if (_controllerMode == CONTROLLER_MODE_BROWSE) {
                break;
            } else if (_controllerMode == CONTROLLER_MODE_CALENDAR) {
                [_scrollView removeFromSuperview];
                CGRect rect = _tableView.frame;
                rect.origin.y = DWDiaryNavigationBarHeight;
                rect.size.height = self.view.bounds.size.height - CGRectGetMaxY(_navigationBar.frame);
                _tableView.frame = rect;
                [_navigationBar addSubview:_labelTheme];
            } else if (_controllerMode == CONTROLLER_MODE_TYPING) {
                [_pickerView removeFromSuperview];
                [_typingView removeFromSuperview];
                CGRect rect = _tableView.frame;
                rect.origin.y = DWDiaryNavigationBarHeight;
                rect.size.height = self.view.bounds.size.height - CGRectGetMaxY(_navigationBar.frame);
                _tableView.frame = rect;
                [self.view addSubview:_tableView];
                [_navigationBar addSubview:_labelTheme];
            }
            _controllerMode = CONTROLLER_MODE_BROWSE;
            [self updateTableViewDataSourceFromDataBase];
            break;
        }
        case 1: {
            if (_controllerMode == CONTROLLER_MODE_BROWSE) {
                [_labelTheme removeFromSuperview];
                CGRect rect = _tableView.frame;
                rect.origin.y = DWDiaryNavigationBarHeight + DWDiaryCalendarViewHeight;
                rect.size.height = self.view.bounds.size.height - CGRectGetMaxY(_scrollView.frame);
                _tableView.frame = rect;
                [self.view addSubview:_scrollView];
            } else if (_controllerMode == CONTROLLER_MODE_CALENDAR) {
                break;
            } else if (_controllerMode == CONTROLLER_MODE_TYPING) {
                [_pickerView removeFromSuperview];
                [_typingView removeFromSuperview];
                [self.view addSubview:_scrollView];
                CGRect rect = _tableView.frame;
                rect.origin.y = DWDiaryNavigationBarHeight + DWDiaryCalendarViewHeight;
                rect.size.height = self.view.bounds.size.height - CGRectGetMaxY(_scrollView.frame);
                _tableView.frame = rect;
                [self.view addSubview:_tableView];
            }
            _controllerMode = CONTROLLER_MODE_CALENDAR;
            [self updateTableViewDataSourceFromDataBase];
            [self updateArrayModelDayWithDicDate:_scrollView.arrayDayDics[_scrollView.currentIndex]];
            [_tableView reloadData];
            break;
        }
        case 2: {
            if (_controllerMode == CONTROLLER_MODE_BROWSE) {
                [_tableView removeFromSuperview];
                [_labelTheme removeFromSuperview];
                [self.view addSubview:_pickerView];
                [self.view addSubview:_typingView];
            } else if (_controllerMode == CONTROLLER_MODE_CALENDAR) {
                [_scrollView removeFromSuperview];
                [_tableView removeFromSuperview];
                [self.view addSubview:_pickerView];
                [self.view addSubview:_typingView];
            } else if (_controllerMode == CONTROLLER_MODE_TYPING) {
                break;
            }
            _controllerMode = CONTROLLER_MODE_TYPING;
            [self updateTypingViewContentFromDataBaseWithDicDate:_pickerView.dicDate];
            break;
        }
        default:
            break;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _startContentOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    _willEndContentOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidStop:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidStop:scrollView];
}

- (void)scrollViewDidStop:(UIScrollView *)scrollView {
    CGFloat scrollW = DWScreenWidth;
    int page = (_scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
    _scrollView.currentIndex = page;
    if (page == 0) { // 先改变page == 3的View，后设置offset，再改变其他page的View
        NSMutableArray *array = [_scrollView.arrayDayDics mutableCopy];
        [array replaceObjectAtIndex:3 withObject:[self getDayDicAfterDays:-3 fromDate:[_scrollView.arrayDayDics[3] valueForKey:@"date"]]];
        _scrollView.arrayDayDics = [array copy];
        
        [_scrollView setContentOffset:CGPointMake(scrollW * (_scrollView.arrayDayDics.count - 2), 0)];
        _scrollView.currentIndex = 3;
        
        array = [_scrollView.arrayDayDics mutableCopy];
        for (int i = 0; i < _scrollView.arrayDayDics.count; i++) {
            if (i == 3) {
                continue;
            }
            [array replaceObjectAtIndex:i withObject:[self getDayDicAfterDays:-3 fromDate:[_scrollView.arrayDayDics[i] valueForKey:@"date"]]];
        }
        _scrollView.arrayDayDics = [array copy];
    } else if (page == _scrollView.arrayDayDics.count - 1) { //先改变page == 1的View，后设置offset，再改变其他page的View
        NSMutableArray *array = [_scrollView.arrayDayDics mutableCopy];
        [array replaceObjectAtIndex:1 withObject:[self getDayDicAfterDays:3 fromDate:[_scrollView.arrayDayDics[1] valueForKey:@"date"]]];
        _scrollView.arrayDayDics = [array copy];
        
        [_scrollView setContentOffset:CGPointMake(scrollW, 0)];
        _scrollView.currentIndex = 1;
        
        array = [_scrollView.arrayDayDics mutableCopy];
        for (int i = 0; i < _scrollView.arrayDayDics.count; i++) {
            if (i == 1) {
                continue;
            }
            [array replaceObjectAtIndex:i withObject:[self getDayDicAfterDays:3 fromDate:[_scrollView.arrayDayDics[i] valueForKey:@"date"]]];
        }
        _scrollView.arrayDayDics = [array copy];
    }
    [self updateArrayModelDayWithDicDate:_scrollView.arrayDayDics[_scrollView.currentIndex]];
    [_tableView reloadData];
}

#pragma mark - private method
- (NSDictionary *)getDayDicAfterDays:(int)days fromDate:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSArray *MONTH = [[self class] arrayMonth];
    NSArray *WEEKDAY = [[self class] arrayWeekDay];
    NSDateComponents *addingDateComponents = [[NSDateComponents alloc] init];
    [addingDateComponents setDay:days];
    date = [calendar dateByAddingComponents:addingDateComponents toDate:date options:0];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:date];
    NSDictionary *dicDay = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld年", components.year], @"year", MONTH[components.month - 1], @"month", [NSString stringWithFormat:@"%ld", (long)components.day], @"day", WEEKDAY[components.weekday - 1], @"week", date, @"date", nil];
    return dicDay;
}

- (NSString *)getTimeFromDate:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:date];
    NSString *time = [NSString stringWithFormat:@"%ld:%ld", components.hour, components.minute];
    return time;
}

- (void)keyboardDidShow:(NSNotification *)notification {
    //获取键盘高度
    NSValue *keyboardObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect;
    [keyboardObject getValue:&keyboardRect];
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [_disKeyboardButton setFrame:CGRectMake(DWScreenWidth - DWDisKeyboardButtonWidth, keyboardRect.origin.y - DWDisKeyboardButtonHeight, DWDisKeyboardButtonWidth, DWDisKeyboardButtonHeight)];
    [self.view addSubview:_disKeyboardButton];
    //调整放置有textView的view的位置
    //设置动画
    [UIView beginAnimations:nil context:nil];
    //定义动画时间
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelay:0];
    //设置view的frame，往上平移
    [_pickerView setFrame:CGRectMake(0, 0, DWScreenWidth, DWDiaryTypingCalenderSmallHeight)];
    [_pickerView transformToSmallMood];
    [_typingView setFrame:CGRectMake(0, CGRectGetMaxY(_pickerView.frame), DWScreenWidth, DWDiaryTypingViewHeight)];
    [_navigationBar setFrame:CGRectMake(0, -DWDiaryNavigationBarHeight, DWScreenWidth, DWDiaryNavigationBarHeight)];
    //提交动画
    [UIView commitAnimations];
}

- (void)keyboardDidHidden:(NSNotification *)notification {
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [_disKeyboardButton removeFromSuperview];
    //调整放置有textView的view的位置
    //设置动画
    [UIView beginAnimations:nil context:nil];
    //定义动画时间
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelay:0];
    //设置view的frame，往上平移
    [_typingView setFrame:CGRectMake(0, DWDiaryNavigationBarHeight + DWDiaryTypingCalendarHeight, DWScreenWidth, DWDiaryTypingViewHeight)];
    [_pickerView setFrame:CGRectMake(0, DWDiaryNavigationBarHeight, DWScreenWidth, DWDiaryTypingCalendarHeight)];
    [_pickerView transformToNormalMood];
    [_navigationBar setFrame:CGRectMake(0, 0, DWScreenWidth, DWDiaryNavigationBarHeight)];
    //提交动画
    [UIView commitAnimations];
}

- (void)updateTableViewDataSourceFromDataBase {
    dispatch_async(dispatch_get_main_queue(), ^{
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"DiaryModel"];
        NSError *error;
        NSArray *objects = [context executeFetchRequest:request
                                                  error:&error];
        NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
        if (objects == nil) {
            NSLog(@"There was an error!");
        }
        if (objects.count > 0) {
            [tmpArray removeAllObjects];
        }
        for (int i = 0; i < objects.count; i++) {
            [tmpArray addObject:[objects objectAtIndex:i]];
        }
        // sort
        NSComparator comparator = ^(id obj1, id obj2) {
            if ([[obj1 valueForKey:@"date"] compare:[obj2 valueForKey:@"date"]] == NSOrderedDescending) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            if ([[obj1 valueForKey:@"date"] compare:[obj2 valueForKey:@"date"]] == NSOrderedAscending) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            return (NSComparisonResult)NSOrderedSame;
        };
        _arrayModel = [[tmpArray sortedArrayUsingComparator:comparator] mutableCopy];;
        
        [_tableView reloadData];
    });
}

- (void) updateArrayModelDayWithDicDate:(NSDictionary *)dicDate {
    [_arrayModelDay removeAllObjects];
    for (id model in _arrayModel) {
        if ([[model valueForKey:@"year"] isEqualToString:dicDate[@"year"]] && [[model valueForKey:@"month"] isEqualToString:dicDate[@"month"]] && [[model valueForKey:@"day"] isEqualToString:dicDate[@"day"]]) {
            [_arrayModelDay addObject:model];
        }
    }
}

- (void)updateTypingViewContentFromDataBaseWithDicDate:(NSDictionary *)dicDate {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *year = dicDate[@"year"];
        NSString *month = dicDate[@"month"];
        NSString *day = dicDate[@"day"];
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"DiaryModel"];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K = %@ && %K = %@ && %K = %@", @"year", year, @"month", month, @"day", day];
        [request setPredicate:pred];
        NSError *error;
        NSArray *objects = [context executeFetchRequest:request
                                                  error:&error];
        if (objects == nil) {
            NSLog(@"There was an error!");
        }
        if (objects.count == 0) {
            _typingView.title = @"";
            _typingView.detail = @"";
            _typingView.emotion = @"happy";
            _typingView.weather = @"sunny";
        }
        
        for (int i = 0; i < objects.count; i++) {
            _typingView.title = [[objects objectAtIndex:i] valueForKey:@"title"];
            _typingView.detail = [[objects objectAtIndex:i] valueForKey:@"detail"];
            _typingView.emotion = [[objects objectAtIndex:i] valueForKey:@"emotion"];
            _typingView.weather = [[objects objectAtIndex:i] valueForKey:@"weather"];
        }
    });
}

- (void)saveModelIntoDataBaseWithTitle:(NSString *)title detail:(NSString *)detail emotion:(NSString *)emotion weather:(NSString *)weather dicDate:(NSDictionary *)dicDate {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *year = dicDate[@"year"];
        NSString *month = dicDate[@"month"];
        NSString *day = dicDate[@"day"];
        NSString *week = dicDate[@"week"];
        
        NSArray *FORMAT_NUMBER = [[self class] arrayFormatNumber];
        NSDate *currentDate = [NSDate date];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *components = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:currentDate];
        NSString *timeString = [NSString stringWithFormat:@"%@:%@:%@", (components.hour < 10 ? FORMAT_NUMBER[components.hour] : [NSString stringWithFormat:@"%ld", components.hour]), (components.minute < 10 ? FORMAT_NUMBER[components.minute] : [NSString stringWithFormat:@"%ld", components.minute]), (components.second < 10 ? FORMAT_NUMBER[components.second] : [NSString stringWithFormat:@"%ld", components.second])];
        NSString *yearString = [year stringByReplacingOccurrencesOfString:@"年" withString:@""];
        NSString *monthString = [((NSString *)[month stringByReplacingOccurrencesOfString:@"月" withString:@""]) integerValue] < 10 ? FORMAT_NUMBER[[((NSString *)[month stringByReplacingOccurrencesOfString:@"月" withString:@""]) integerValue]] : [month stringByReplacingOccurrencesOfString:@"月" withString:@""];
        NSString *dayString = [day integerValue] < 10 ? FORMAT_NUMBER[[day integerValue]] : day;
        NSString *dateString = [NSString stringWithFormat:@"%@-%@-%@ %@", yearString, monthString, dayString, timeString];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [formatter dateFromString:dateString];
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        NSManagedObjectContext *context = [delegate managedObjectContext];
        NSError *error;
        
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"DiaryModel"];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K = %@ && %K = %@ && %K = %@", @"year", year, @"month", month, @"day", day];
        [request setPredicate:pred];
        
        NSArray *objects = [context executeFetchRequest:request error:&error];
        
        NSManagedObject *theDiary = nil;
        if ([objects count] > 0) {
            theDiary = [objects objectAtIndex:0];
        } else {
            theDiary = [NSEntityDescription insertNewObjectForEntityForName:@"DiaryModel"
                                                     inManagedObjectContext:context];
        }
        
        [theDiary setValue:title forKey:@"title"];
        [theDiary setValue:detail forKey:@"detail"];
        [theDiary setValue:date forKey:@"date"];
        [theDiary setValue:year forKey:@"year"];
        [theDiary setValue:month forKey:@"month"];
        [theDiary setValue:day forKey:@"day"];
        [theDiary setValue:week forKey:@"week"];
        [theDiary setValue:emotion forKey:@"emotion"];
        [theDiary setValue:weather forKey:@"weather"];
        
        [delegate saveContext];
    });
}

- (void)deleteDiaryModelInDateBaseWithDicDate:(NSDictionary *)dicDate {
    NSString *year = dicDate[@"year"];
    NSString *month = dicDate[@"month"];
    NSString *day = dicDate[@"day"];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSError *error;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"DiaryModel"];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K = %@ && %K = %@ && %K = %@", @"year", year, @"month", month, @"day", day];
    [request setPredicate:pred];
    
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    NSManagedObject *theDiary = nil;
    if ([objects count] > 0) {
        theDiary = [objects objectAtIndex:0];
    }
    [context deleteObject:theDiary];
    [delegate saveContext];
}

- (void)dismissKeyboardTap {
    [_typingView endEditing:YES];
}

#pragma mark - DWDiaryTypingCalendarDelegate
- (void)leftButtonPressed {
    _pickerView.dicDate = [self getDayDicAfterDays:-1 fromDate:_pickerView.dicDate[@"date"]];
    [self updateTypingViewContentFromDataBaseWithDicDate:_pickerView.dicDate];
}

- (void)rightButtonPressed {
    _pickerView.dicDate = [self getDayDicAfterDays:1 fromDate:_pickerView.dicDate[@"date"]];
    [self updateTypingViewContentFromDataBaseWithDicDate:_pickerView.dicDate];
}

#pragma mark - DWDiaryTypingDelegate
- (void)saveModelWithTitle:(NSString *)title detail:(NSString *)detail emotion:(NSString *)emotion weather:(NSString *)weather {
    [self saveModelIntoDataBaseWithTitle:title detail:detail emotion:emotion weather:weather dicDate:_pickerView.dicDate];
}

#pragma mark - DWDiaryContentViewDelegate
- (void)openTypingViewWithDicDate:(NSDictionary *)dicDate {
    _pickerView.dicDate = dicDate;
    [_segment setSelectedSegmentIndex:2];
    [self didChangeValueOfSegmentControl:_segment];
    [self updateTypingViewContentFromDataBaseWithDicDate:dicDate];
}

- (void)deleteDiaryWithDicDate:(NSDictionary *)dicDate {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        [self deleteDiaryModelInDateBaseWithDicDate:dicDate];
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self updateTableViewDataSourceFromDataBase];
        if (_controllerMode == CONTROLLER_MODE_CALENDAR) {
            [self updateArrayModelDayWithDicDate:_scrollView.arrayDayDics[_scrollView.currentIndex]];
        }
    });
}

- (void)updateContentViewWithOffset:(NSInteger)offset {
    if (_contentView) {
        if (_currentIndexPath.row + offset >= 0 && _currentIndexPath.row + offset < _arrayModel.count) {
            _currentIndexPath = [NSIndexPath indexPathForRow:_currentIndexPath.row + offset inSection:0];
            DWDiaryTableViewCell *cell = [_tableView cellForRowAtIndexPath:_currentIndexPath];
            _contentView.dicDate = cell.dicDate;
            _contentView.detail = cell.detail;
        }
    }
}

@end
