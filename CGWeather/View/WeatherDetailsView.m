//
//  WeatherDetailsView.m
//  CGWeather
//
//  Created by 王敏超 on 16/4/4.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import "WeatherDetailsView.h"

@implementation WeatherDetailsView{
    UILabel *_bodyTemp;
//    UILabel *_bodyTempTip;
    UILabel *_humidity;
//    UILabel *_humidityTip;
    UILabel *_visibilityRange;
//    UILabel *_visibilityRangeTip;
    UILabel *_ultravioletTip;
}

- (void)updateUIWithWeather:(Weather *)weather{
    _bodyTemp.text = [weather.bodyTemperature stringByAppendingString:@"°"];
    _humidity.text = [weather.currentHumidity stringByAppendingString:@"%"];
    _visibilityRange.text = [weather.visibility stringByAppendingString:@"公里"];
    _ultravioletTip.text = weather.ultraviolet ? weather.ultraviolet : @"--";
}


- (instancetype)initViewWithWidth:(CGFloat)width andHeight:(CGFloat)height withOffset:(CGFloat)offset{
    if (self = [super init]) {
        [self setFrame:CGRectMake(0.022 * width, 0.94 * height + offset, 0.956 * width, 0.363 * height)];
        [self setImage:[UIImage imageNamed:@"weatherDetails"]];
        
        // body temperature
        _bodyTemp = [[UILabel alloc] initWithFrame:CGRectMake(0.225 * CURRENT_VIEW_FRAME_WIDTH, 0.34 * CURRENT_VIEW_FRAME_HEIGHT, 0.225 * CURRENT_VIEW_FRAME_WIDTH, 0.136 * CURRENT_VIEW_FRAME_HEIGHT)];
        _bodyTemp.textColor = [UIColor whiteColor];
        _bodyTemp.font = [UIFont fontWithName:@".PingFang SC" size:20];
        _bodyTemp.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_bodyTemp];
//        _bodyTempTip = [[UILabel alloc] initWithFrame:CGRectMake(0.333 * CURRENT_VIEW_FRAME_WIDTH, 0.456 * CURRENT_VIEW_FRAME_HEIGHT, 0.118 * CURRENT_VIEW_FRAME_WIDTH, 0.121 * CURRENT_VIEW_FRAME_HEIGHT)];
//        _bodyTempTip.text = @"温暖";
//        _bodyTempTip.textColor = [UIColor whiteColor];
//        _bodyTempTip.font = [UIFont fontWithName:@".PingFang SC" size:18];
//        [self addSubview:_bodyTempTip];
        
        // humidity
        _humidity = [[UILabel alloc] initWithFrame:CGRectMake(0.719 * CURRENT_VIEW_FRAME_WIDTH, 0.345 * CURRENT_VIEW_FRAME_HEIGHT, 0.225 * CURRENT_VIEW_FRAME_WIDTH, 0.136 * CURRENT_VIEW_FRAME_HEIGHT)];
        _humidity.textColor = [UIColor whiteColor];
        _humidity.font = [UIFont fontWithName:@".PingFang SC" size:20];
        _humidity.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_humidity];
//        _humidityTip = [[UILabel alloc] initWithFrame:CGRectMake(0.801 * CURRENT_VIEW_FRAME_WIDTH, 0.456 * CURRENT_VIEW_FRAME_HEIGHT, 0.118 * CURRENT_VIEW_FRAME_WIDTH, 0.121 * CURRENT_VIEW_FRAME_HEIGHT)];
//        _humidityTip.text = @"适宜";
//        _humidityTip.textColor = [UIColor whiteColor];
//        _humidityTip.font = [UIFont fontWithName:@".PingFang SC" size:18];
//        [self addSubview:_humidityTip];
        
        // visibility Range
        _visibilityRange = [[UILabel alloc] initWithFrame:CGRectMake(0.222 * CURRENT_VIEW_FRAME_WIDTH, 0.704 * CURRENT_VIEW_FRAME_HEIGHT, 0.25 * CURRENT_VIEW_FRAME_WIDTH, 0.136 * CURRENT_VIEW_FRAME_HEIGHT)];
        _visibilityRange.textColor = [UIColor whiteColor];
        _visibilityRange.font = [UIFont fontWithName:@".PingFang SC" size:20];
        _visibilityRange.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_visibilityRange];
//        _visibilityRangeTip = [[UILabel alloc] initWithFrame:CGRectMake(0.333 * CURRENT_VIEW_FRAME_WIDTH, 0.83 * CURRENT_VIEW_FRAME_HEIGHT, 0.118 * CURRENT_VIEW_FRAME_WIDTH, 0.121 * CURRENT_VIEW_FRAME_HEIGHT)];
//        _visibilityRangeTip.text = @"一般";
//        _visibilityRangeTip.textColor = [UIColor whiteColor];
//        _visibilityRangeTip.font = [UIFont fontWithName:@".PingFang SC" size:18];
//        [self addSubview:_visibilityRangeTip];
        
        // ultraviolet
        _ultravioletTip = [[UILabel alloc] initWithFrame:CGRectMake(0.722 * CURRENT_VIEW_FRAME_WIDTH, 0.718 * CURRENT_VIEW_FRAME_HEIGHT, 0.225 * CURRENT_VIEW_FRAME_WIDTH, 0.136 * CURRENT_VIEW_FRAME_HEIGHT)];
        _ultravioletTip.textColor = [UIColor whiteColor];
        _ultravioletTip.font = [UIFont fontWithName:@".PingFang SC" size:20];
        _ultravioletTip.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_ultravioletTip];
        
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
