//
//  AppDelegate.m
//  GuideBook
//
//  Created by Apple on 2020/3/11.
//  Copyright © 2020 Design. All rights reserved.
//

#import "AppDelegate.h"
#import "GuiBMainTabbarViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) NSMutableData *data;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [UIApplication sharedApplication].statusBarHidden = NO;
    // 设置主窗口,并设置根控制器
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    [self.window makeKeyAndVisible];
    GuiBMainTabbarViewController *rootViewController = [[GuiBMainTabbarViewController alloc] init];
    [self.window setRootViewController:rootViewController];
    return YES;
}

@end
