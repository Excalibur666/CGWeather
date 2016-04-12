//
//  City.h
//  CGWeather
//
//  Created by 王敏超 on 16/4/7.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *cityID;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *province;

- (instancetype)initWithCity:(NSString*)cityName cityID:(NSString*)cityID country:(NSString*)country province:(NSString*)province;
@end
