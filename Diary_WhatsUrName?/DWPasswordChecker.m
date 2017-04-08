//
//  DWPasswordChecker.m
//  Diary_WhatsUrName?
//
//  Created by 王冠宇 on 17/4/8.
//  Copyright © 2017年 王冠宇. All rights reserved.
//

#import "DWPasswordChecker.h"
#import "AppDelegate.h"

@interface DWPasswordChecker()

@property (copy, nonatomic) NSString *key;

@end

@implementation DWPasswordChecker

- (BOOL)checkPassword:(NSString *)password {
    if (!password) {
        return NO;
    }
    return [self.key isEqualToString:password];
}

- (NSString *)key {
    if (!_key) {
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"UserInfo"];
        NSError *error;
        NSArray *objects = [context executeFetchRequest:request
                                                  error:&error];
        if (objects == nil) {
            NSLog(@"There was an error!");
        }
        NSManagedObject *theUserInfo = nil;
        if ([objects count] > 0) {
            theUserInfo = [objects objectAtIndex:0];
            _key = [theUserInfo valueForKey:@"key"];
        }
    }
    return _key;
}

- (void)updateKey:(NSString *)key {
    if (key) {
        dispatch_async(dispatch_get_main_queue(), ^{
            AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
            NSManagedObjectContext *context = [appDelegate managedObjectContext];
            NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"UserInfo"];
            NSError *error;
            NSArray *objects = [context executeFetchRequest:request
                                                      error:&error];
            if (objects == nil) {
                NSLog(@"There was an error!");
            }
            NSManagedObject *theUserInfo = nil;
            if ([objects count] > 0) {
                theUserInfo = [objects objectAtIndex:0];
            } else {
                theUserInfo = [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo"
                                                            inManagedObjectContext:context];
            }
            [theUserInfo setValue:key forKey:@"key"];
            
            [appDelegate saveContext];
        });
    }
}

@end
