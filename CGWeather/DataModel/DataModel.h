//
//  DataModel.h
//  CGWeather
//
//  Created by 王敏超 on 16/4/5.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MainViewController;

@interface DataModel : NSObject

@property (nonatomic, strong) NSMutableArray *cityWeathers;

- (instancetype)init;
- (void)saveCityWeathers;

@end
