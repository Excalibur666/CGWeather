//
//  AppDelegate.h
//  CGWeather
//
//  Created by 王敏超 on 16/4/1.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class YRSideViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) YRSideViewController *sideViewController;

@end

