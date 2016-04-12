//
//  WindView.m
//  CGWeather
//
//  Created by 王敏超 on 16/4/4.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import "WindView.h"

@implementation WindView{
    UILabel *_windDetails;
    UILabel *_pressure;
}

- (void)updateUIWithWeather:(Weather*)weather{
    _windDetails.text = [weather.windSpeed stringByAppendingFormat:@"公里/小时 %@ %@级", weather.windDirection, weather.windScale];
    _pressure.text = [weather.pressure stringByAppendingString:@"毫巴"];
}

- (instancetype)initViewWithWidth:(CGFloat)width andHeight:(CGFloat)height withOffset:(CGFloat)offset{
    if (self = [super init]) {
        [self setFrame:CGRectMake(0.022 * width, 1.61 * height + offset, 0.956 * width, 0.255 * height)];
        [self setImage:[UIImage imageNamed:@"wind"]];
        
        // wind details
        _windDetails = [[UILabel alloc] initWithFrame:CGRectMake(0.333 * CURRENT_VIEW_FRAME_WIDTH, 0.462 * CURRENT_VIEW_FRAME_HEIGHT, 0.65 * CURRENT_VIEW_FRAME_WIDTH, 0.152 * CURRENT_VIEW_FRAME_HEIGHT)];
        _windDetails.textColor = [UIColor whiteColor];
        _windDetails.font = [UIFont fontWithName:@".PingFang SC" size:16];
        [self addSubview:_windDetails];
        
        // pressure
        _pressure = [[UILabel alloc] initWithFrame:CGRectMake(0.712 * CURRENT_VIEW_FRAME_WIDTH, 0.862 * CURRENT_VIEW_FRAME_HEIGHT, 0.27 * CURRENT_VIEW_FRAME_WIDTH, 0.152 * CURRENT_VIEW_FRAME_HEIGHT)];
        _pressure.textColor = [UIColor whiteColor];
        _pressure.font = [UIFont fontWithName:@".PingFang SC" size:16];
        _pressure.textAlignment = NSTextAlignmentRight;
        [self addSubview:_pressure];
        
        // windmill rotate
        CABasicAnimation *fullRotation;
        fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        fullRotation.fromValue = @(0.0);
        fullRotation.toValue = @((360.0 * M_PI) / 180.0);
        fullRotation.duration = 3.5f;
        fullRotation.repeatCount = MAXFLOAT;
        
        UIImageView *bigWindmill = [[UIImageView alloc] initWithFrame:CGRectMake(0.05 * CURRENT_VIEW_FRAME_WIDTH, 0.331 * CURRENT_VIEW_FRAME_HEIGHT, 0.163 * CURRENT_VIEW_FRAME_WIDTH, 0.366 * CURRENT_VIEW_FRAME_HEIGHT)];
        [bigWindmill setImage:[UIImage imageNamed:@"bigWindmill"]];
        [bigWindmill.layer addAnimation:fullRotation forKey:@"rotation-animation"];
        bigWindmill.layer.anchorPoint = CGPointMake(0.39, 0.48);
        [self addSubview:bigWindmill];
        UIImageView *smallWindmill = [[UIImageView alloc] initWithFrame:CGRectMake(0.18 * CURRENT_VIEW_FRAME_WIDTH, 0.482 * CURRENT_VIEW_FRAME_HEIGHT, 0.124 * CURRENT_VIEW_FRAME_WIDTH, 0.276 * CURRENT_VIEW_FRAME_HEIGHT)];
        [smallWindmill setImage:[UIImage imageNamed:@"bigWindmill"]];
        [smallWindmill.layer addAnimation:fullRotation forKey:@"rotation-animation"];
        smallWindmill.layer.anchorPoint = CGPointMake(0.39, 0.48);
        [self addSubview:smallWindmill];
        
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
