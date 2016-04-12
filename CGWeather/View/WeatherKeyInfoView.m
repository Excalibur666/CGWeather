//
//  WeatherKeyInfoView.m
//  CGWeather
//
//  Created by 王敏超 on 16/4/4.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import "WeatherKeyInfoView.h"

@implementation WeatherKeyInfoView{
    UIImageView *_imageWeather;
    UILabel *_labelWeather;
    UILabel *_labelMaxTemp;
    UILabel *_labelMinTemp;
    UILabel *_labelCurrentTemp;
}

- (void)updateUIWithWeather:(Weather*)weather{
    _imageWeather.image = [UIImage imageNamed:weather.weatherConditionCode];
    _labelWeather.text = weather.weatherConditionDesription;
    _labelMaxTemp.text = [weather.maxTemperature stringByAppendingString:@"°"];
    _labelMinTemp.text = [weather.minTemperature stringByAppendingString:@"°"];
    _labelCurrentTemp.text = [weather.currentTemperature stringByAppendingString:@"°"];
}

- (instancetype)initViewWithWidth:(CGFloat)width andHeight:(CGFloat)height withOffset:(CGFloat)offset{
    
    if (self = [super init]) {
        // weather key info
        [self setFrame:CGRectMake(0, offset, width, 0.319 * height)];
        
        // weather info image
        _imageWeather = [[UIImageView alloc] initWithFrame:CGRectMake(0.066 * width, 0, width * 0.113, height * 0.05)];
        _imageWeather.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageWeather];
        
        // weather info description
        _labelWeather = [[UILabel alloc] initWithFrame:CGRectMake(width * 0.22, 0.005 * height, 0.5 * width, 0.05 * height)];
        [_labelWeather setTextColor:[UIColor whiteColor]];
        [_labelWeather setFont:[UIFont fontWithName:@".PingFang SC" size:19]];
        [self addSubview:_labelWeather];
        
        // imageMaxTempFlag
        UIImageView *imageMaxTempFlag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imageMaxTemFlag"]];
        [imageMaxTempFlag setFrame:CGRectMake(0.069 * width, 0.07 * height, 0.028 * width, 0.035 * height)];
        [self addSubview:imageMaxTempFlag];
        
        // max temperature
        _labelMaxTemp = [[UILabel alloc] initWithFrame:CGRectMake(0.163 * width, 0.07 * height, 0.12 * width, 0.05 * height)];
        [_labelMaxTemp setTextColor:[UIColor whiteColor]];
        [_labelMaxTemp setFont:[UIFont fontWithName:@".PingFang SC" size:20]];
        [self addSubview:_labelMaxTemp];
        
        // imageMinTempFlag
        UIImageView *imageMinTempFlag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imageMinTemFlag"]];
        [imageMinTempFlag setFrame:CGRectMake(0.319 * width, 0.07 * height, 0.025 * width, 0.035 * height)];
        [self addSubview:imageMinTempFlag];
        
        // min temperature
        _labelMinTemp = [[UILabel alloc] initWithFrame:CGRectMake(0.406 * width, 0.07 * height, 0.12 * width, 0.05 * height)];
        [_labelMinTemp setTextColor:[UIColor whiteColor]];
        [_labelMinTemp setFont:[UIFont fontWithName:@".PingFang SC" size:20]];
        [self addSubview:_labelMinTemp];
        
        // current temperature
        _labelCurrentTemp = [[UILabel alloc] initWithFrame:CGRectMake(0.031 * width, 0.08 * height, 0.7 * width, 0.25 * height)];
        [_labelCurrentTemp setTextColor:[UIColor whiteColor]];
        [_labelCurrentTemp setFont:[UIFont fontWithName:@"HelveticaNeue-Ultralight" size:130]];
        [self addSubview:_labelCurrentTemp];
                
        return self;
    } else {
        return nil;
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
