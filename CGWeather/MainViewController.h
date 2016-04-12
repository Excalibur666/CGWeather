//
//  ViewController.h
//  CGWeather
//
//  Created by 王敏超 on 16/4/1.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//
#define SELF_VIEW_FRAME_WIDTH self.view.frame.size.width
#define SELF_VIEW_FRAME_HEIGHT self.view.frame.size.height
#define CUSTOM_VIEW_OFFSET 44
#define DEFAULT_NAVIGATION_BAR_HEIGHT 44

#import <UIKit/UIKit.h>
#import "BTGlassScrollView.h"
#import "Weather.h"
#import "AddCityViewController.h"
@class DataModel;

@interface MainViewController : UIViewController <UIScrollViewAccessibilityDelegate, WeatherDelegate, UINavigationBarDelegate, AddCityViewControllerDelegate, BTGlassScrollViewDelegate>

@property (nonatomic, strong) DataModel *dataModel;
@property (nonatomic) NSUInteger page;

- (void)moveToPage:(NSUInteger)page;

@end

