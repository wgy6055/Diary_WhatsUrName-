//
//  DWSettingViewController.m
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/4/8.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import "DWSettingViewController.h"
#import "DWSettingSwitchTableViewCell.h"
#import "DWPasswordViewController.h"
#import "DWSettingStore.h"
#import "DWUserInfo.h"
#import "AppDelegate.h"
#import "Constants.h"

@interface DWSettingViewController () <UITableViewDelegate, UITableViewDataSource, DWSettingSwitchCellDelegate, DWPasswordViewControllerDelegate>

@property (strong, nonatomic) UIView *navigationBar;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation DWSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DWScreenWidth, DWSettingNavigationBarHeight)];
    [_navigationBar setBackgroundColor:DWDiaryThemeBlueColor];
    
    UILabel *labelTitle = [[UILabel alloc] init];
    labelTitle.text = @"设置";
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.font = [UIFont systemFontOfSize:20];
    [labelTitle sizeToFit];
    labelTitle.frame = CGRectMake(_navigationBar.frame.size.width / 2 - labelTitle.frame.size.width / 2, _navigationBar.frame.size.height / 2 - labelTitle.frame.size.height / 2, labelTitle.frame.size.width, labelTitle.frame.size.height);
    [_navigationBar addSubview:labelTitle];
    
    UIButton *buttonQuit = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonQuit setImage:[UIImage imageNamed:@"quit"] forState:UIControlStateNormal];
    [buttonQuit setFrame:CGRectMake(DWSettingQuitButtonLeftPadding, _navigationBar.frame.size.height / 2 - DWSettingQuitButtonWidth / 2, DWSettingQuitButtonWidth, DWSettingQuitButtonWidth)];
    [buttonQuit addTarget:self action:@selector(buttonQuitTap) forControlEvents:UIControlEventTouchUpInside];
    [_navigationBar addSubview:buttonQuit];
    
    [self.view addSubview:_navigationBar];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, DWSettingNavigationBarHeight, DWScreenWidth, DWScreenHeight - DWSettingNavigationBarHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark - handle tap gesture
- (void)buttonQuitTap {
    [self.delegate dismissViewController];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DWSettingSwitchTableViewCell *cell = [[DWSettingSwitchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingSwitchCell" title:@"开启日记密码与TouchID"];
    cell.switcher.tag = 0;
    cell.delegate = self;
    return cell;
}

#pragma mark - DWSettingSwitchCellDelegate
- (void)switcherValueChanged:(UISwitch *)sender {
    switch (sender.tag) {
        case 0: {
            if (sender.on) {
                DWPasswordViewController *passwordController = [[DWPasswordViewController alloc] init];
                passwordController.delegate = self;
                passwordController.isSettingMode = YES;
                [self presentViewController:passwordController animated:YES completion:nil];
                break;
            } else {
                DWUserInfo *userInfo = [[DWUserInfo alloc] init];
                userInfo.key = @"";
                userInfo.isLocked = NO;
                [self updateUserInfoIntoDataBase:userInfo completion:^{
                    [DWSettingStore sharedInstance].isLocked = NO;
                }];
            }
        }
        default:
            break;
    }
}

#pragma mark - DWPasswordViewControllerDelegate
- (void)dismissViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveKeyIntoDataBase:(NSString *)key {
    if (key) {
        DWUserInfo *userInfo = [[DWUserInfo alloc] init];
        userInfo.key = key;
        userInfo.isLocked = YES;
        [self updateUserInfoIntoDataBase:userInfo completion:^{
            [DWSettingStore sharedInstance].isLocked = YES;
        }];
    }
}

- (void)setSwitcherValue:(BOOL)value {
    // 暂时先这样处理
    DWSettingSwitchTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.switcher.on = value;
}

#pragma mark - private
- (void)updateUserInfoIntoDataBase:(DWUserInfo *)userInfo completion:(CompletionBlock)completion {
    dispatch_async(dispatch_get_main_queue(), ^{
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        NSManagedObjectContext *context = [delegate managedObjectContext];
        NSError *error;
        
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"UserInfo"];
        
        NSArray *objects = [context executeFetchRequest:request error:&error];
        
        NSManagedObject *theUserInfo = nil;
        if ([objects count] > 0) {
            theUserInfo = [objects objectAtIndex:0];
        } else {
            theUserInfo = [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo"
                                                        inManagedObjectContext:context];
        }
        [theUserInfo setValue:userInfo.key forKey:@"key"];
        [theUserInfo setValue:[NSNumber numberWithBool:userInfo.isLocked] forKey:@"isLocked"];
        
        [delegate saveContext];
        completion();
    });
}

@end
