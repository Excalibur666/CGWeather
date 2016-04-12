//
//  AppDelegate.m
//  CGWeather
//
//  Created by 王敏超 on 16/4/1.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "YRSideViewController.h"
#import "SetViewController.h"
#import "DataModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate{
    DataModel *_dataModel;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    MainViewController *mainViewController = [[MainViewController alloc] init];
    _dataModel = [[DataModel alloc] init];
    mainViewController.dataModel = _dataModel;
    
    //self.window.rootViewController = mainViewController;
    //self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
    
    // add sideViewController
    self.sideViewController = [[YRSideViewController alloc] init];
    
    self.sideViewController.rootViewController = mainViewController;
    self.sideViewController.leftViewShowWidth = 270;
    self.sideViewController.needSwipeShowMenu = NO;
    [self.sideViewController setRootViewMoveBlock:^(UIView *rootView, CGRect originFrame, CGFloat xoffset) {
        // just use simple move animation
        rootView.frame = CGRectMake(xoffset, originFrame.origin.y, originFrame.size.width, originFrame.size.height);
    }];

    self.window.rootViewController = self.sideViewController;
    
    return YES;
}

- (void)saveData{
    [_dataModel saveCityWeathers];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self saveData];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveData];
}

@end