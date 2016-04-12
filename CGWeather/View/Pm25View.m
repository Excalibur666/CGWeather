//
//  Pm25View.m
//  CGWeather
//
//  Created by 王敏超 on 16/4/4.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import "Pm25View.h"

@implementation Pm25View{
    UILabel *_pm25;
    UILabel *_quality;
    UIImageView *_pm25Indicator;
}


- (void)updateUIWithWeather:(Weather*)weather{
    NSString *pm25 = weather.pm25;
    _pm25.text = pm25 ? pm25 : @"--";
    _quality.text = [self getQualityWithPm25:pm25];
    
    if (pm25.integerValue >= 0 && pm25.integerValue < 200) {
        [_pm25Indicator setFrame:CGRectMake(0.003 * CURRENT_VIEW_FRAME_WIDTH + pm25.integerValue * CURRENT_VIEW_FRAME_WIDTH * 0.958 * 4 / 6 / 200 , _pm25Indicator.frame.origin.y, _pm25Indicator.frame.size.width, _pm25Indicator.frame.size.height)];
    } else if (pm25.integerValue >= 200 && pm25.integerValue < 300) {
        [_pm25Indicator setFrame:CGRectMake(0.003 * CURRENT_VIEW_FRAME_WIDTH + CURRENT_VIEW_FRAME_WIDTH * 0.958 * 4 / 6 + CURRENT_VIEW_FRAME_WIDTH * 0.958 * 1 / 6 * (300 - pm25.integerValue) / 100, _pm25Indicator.frame.origin.y, _pm25Indicator.frame.size.width, _pm25Indicator.frame.size.height)];
    } else if (pm25.integerValue >= 300 && pm25.integerValue < 500) {
        [_pm25Indicator setFrame:CGRectMake(0.003 * CURRENT_VIEW_FRAME_WIDTH + CURRENT_VIEW_FRAME_WIDTH * 0.958 * 5 / 6 + CURRENT_VIEW_FRAME_WIDTH * 0.958 * 1 / 6 * (500 - pm25.integerValue) / 200, _pm25Indicator.frame.origin.y, _pm25Indicator.frame.size.width, _pm25Indicator.frame.size.height)];
    } else {
        [_pm25Indicator setFrame:CGRectMake(0.003 * CURRENT_VIEW_FRAME_WIDTH, _pm25Indicator.frame.origin.y, _pm25Indicator.frame.size.width, _pm25Indicator.frame.size.height)];
    }
}

- (NSString*)getQualityWithPm25:(NSString*)pm25{
    NSInteger quality = pm25.integerValue;
    if (quality > 0 && quality < 50) {
        return @"优";
    } else if (quality >= 50 && quality < 100) {
        return @"良";
    } else if (quality >= 100 && quality < 150) {
        return @"轻度";
    } else if (quality >= 150 && quality < 200) {
        return @"中度";
    } else if (quality >= 200 && quality < 300) {
        return @"重度";
    } else if (quality >= 300 && quality < 500){
        return @"严重";
    } else {
        return @"--";
    }
}

- (instancetype)initViewWithWidth:(CGFloat)width andHeight:(CGFloat)height withOffset:(CGFloat)offset{
    if (self = [super init]) {
        [self setFrame:CGRectMake(0.022 * width, 1.32 * height + offset, 0.956 * width, 0.275 * height)];
        [self setImage:[UIImage imageNamed:@"pm25"]];
        
        // pm2.5
        _pm25 = [[UILabel alloc] initWithFrame:CGRectMake(0.742 * CURRENT_VIEW_FRAME_WIDTH, 0.077 * CURRENT_VIEW_FRAME_HEIGHT, 0.095 * CURRENT_VIEW_FRAME_WIDTH, 0.16 * CURRENT_VIEW_FRAME_HEIGHT)];
        _pm25.textColor = [UIColor whiteColor];
        _pm25.font = [UIFont fontWithName:@".PingFang SC" size:18];
        _pm25.textAlignment = NSTextAlignmentRight;
        [self addSubview:_pm25];
        
        // quality
        _quality = [[UILabel alloc] initWithFrame:CGRectMake(0.853 * CURRENT_VIEW_FRAME_WIDTH, 0.077 * CURRENT_VIEW_FRAME_HEIGHT, 0.118 * CURRENT_VIEW_FRAME_WIDTH, 0.16 * CURRENT_VIEW_FRAME_HEIGHT)];
        _quality.textColor = [UIColor whiteColor];
        _quality.font = [UIFont fontWithName:@".PingFang SC" size:18];
        _quality.textAlignment = NSTextAlignmentRight;
        [self addSubview:_quality];
        
        _pm25Indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pointPm2.5"]];
        [_pm25Indicator setFrame:CGRectMake(0.003 * CURRENT_VIEW_FRAME_WIDTH, 0.372 * CURRENT_VIEW_FRAME_HEIGHT, 0.039 * CURRENT_VIEW_FRAME_WIDTH, 0.077 * CURRENT_VIEW_FRAME_HEIGHT)];
        [self addSubview:_pm25Indicator];
                
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
