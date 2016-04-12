//
//  WeatherPredictionView.m
//  CGWeather
//
//  Created by 王敏超 on 16/4/4.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import "WeatherPredictionView.h"



@implementation WeatherPredictionView{
    NSMutableArray *_hours;
    NSMutableArray *_hourPredictionImages;
    NSMutableArray *_hourTemps;
    NSMutableArray *_weekdays;
    NSMutableArray *_dayPredictionImages;
    NSMutableArray *_dayMaxTemps;
    NSMutableArray *_dayMinTemps;
    NSMutableArray *_dotLines;
    
    UIButton *_changeShowDaysButton;
    BOOL _show5days;
}

- (void)updateUIWithWeather:(Weather *)weather{
    // update hour forecast
    NSInteger count = weather.hourlyForecastDate.count;
    for (int i = 0; i < count; i++) {
        UILabel *hour = _hours[i];
        UIImageView *hourPredictionImage = _hourPredictionImages[i];
        UILabel *hourTemp = _hourTemps[i];
        
        // date present like "2016-04-05 10:00"
        NSRange numberRange = {11, 2};
        NSInteger hourNumber = [weather.hourlyForecastDate[i] substringWithRange:numberRange].integerValue;
        
        if (hourNumber > 9) {
            // night
            hour.text = [NSString stringWithFormat:@"%ld:00", hourNumber];
            hourPredictionImage.image = [UIImage imageNamed:weather.nightWeatherConditionCode];
        } else {
            // day
            hour.text = [NSString stringWithFormat:@"0%ld:00", hourNumber];
            hourPredictionImage.image = [UIImage imageNamed:weather.dayWeatherConditionCode];
        }
        hourTemp.text = [weather.hourlyForecastTemp[i] stringByAppendingString:@"°"];
    }
    
    for (NSUInteger i = count; i < 24; i++) {
        UILabel *hour = _hours[i];
        UIImageView *hourPredictionImage = _hourPredictionImages[i];
        UILabel *hourTemp = _hourTemps[i];
        
        hour.text = nil;
        hourPredictionImage.image = nil;
        hourTemp.text = nil;
    }
    
    // update daily forecast
    for (int i = 0; i < 7; i++) {
        UILabel *weekday = _weekdays[i];
        UIImageView *dayPredictionImage = _dayPredictionImages[i];
        UILabel *dayMaxTemp = _dayMaxTemps[i];
        UILabel *dayMinTemp = _dayMinTemps[i];
        

        weekday.text= [self getWeekdayWithInteger:([self getDateComp].weekday + i > 7) ? ([self getDateComp].weekday + i - 7) : ([self getDateComp].weekday + i)];
        dayPredictionImage.image = [UIImage imageNamed:weather.dailyForecastCondition[i]];
        dayMaxTemp.text = [weather.dailyForecastMaxTemp[i] stringByAppendingString:@"°"];
        dayMinTemp.text = [weather.dailyForecastMinTemp[i] stringByAppendingString:@"°"];
    }
    
}

- (NSString*)getWeekdayWithInteger:(NSInteger)i{
    switch (i) {
        case 1:
            return @"星期日";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return nil;
}

- (instancetype)initViewWithWidth:(CGFloat)width andHeight:(CGFloat)height withOffset:(CGFloat)offset{
    
    if (self = [super init]) {
        // init instance variable
        _hours = [[NSMutableArray alloc] init];
        _hourPredictionImages = [[NSMutableArray alloc] init];
        _hourTemps = [[NSMutableArray alloc] init];
        _weekdays = [[NSMutableArray alloc] init];
        _dayPredictionImages = [[NSMutableArray alloc] init];
        _dayMaxTemps = [[NSMutableArray alloc] init];
        _dayMinTemps = [[NSMutableArray alloc] init];
        _dotLines = [[NSMutableArray alloc] init];
        
        // background build
        [self setFrame:CGRectMake(0.022 * width, 0.3 * height + offset, 0.956 * width, 0.623 * height)];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        self.userInteractionEnabled = YES;
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0.033 * CURRENT_VIEW_FRAME_WIDTH, 0.028 * CURRENT_VIEW_FRAME_HEIGHT, 0.118 * CURRENT_VIEW_FRAME_WIDTH, 0.051 * CURRENT_VIEW_FRAME_HEIGHT)];
        [title setText:@"预报"];
        [title setTextColor:[UIColor whiteColor]];
        [title setFont:[UIFont fontWithName:@".PingFang SC" size:18]];
        [self addSubview:title];
        
        // draw line
        UIBezierPath *line = [[UIBezierPath alloc] init];
        [line moveToPoint:CGPointMake(0.033 * CURRENT_VIEW_FRAME_WIDTH, 0.09 * CURRENT_VIEW_FRAME_HEIGHT)];
        [line addLineToPoint:CGPointMake(0.967 * CURRENT_VIEW_FRAME_WIDTH, 0.09 * CURRENT_VIEW_FRAME_HEIGHT)];
        [line closePath];
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.path = line.CGPath;
        lineLayer.strokeColor = [UIColor colorWithWhite:1.f alpha:0.8].CGColor;
        lineLayer.lineWidth = 1.f;
        [self.layer addSublayer:lineLayer];
        
        // draw dot line
        UIBezierPath *dotLine = [[UIBezierPath alloc] init];
        [dotLine moveToPoint:CGPointMake(0.039 * CURRENT_VIEW_FRAME_WIDTH, 0.308 * CURRENT_VIEW_FRAME_HEIGHT)];
        [dotLine addLineToPoint:CGPointMake(0.961 * CURRENT_VIEW_FRAME_WIDTH, 0.308 * CURRENT_VIEW_FRAME_HEIGHT)];
        [dotLine closePath];
        CAShapeLayer *dotLineLayer = [CAShapeLayer layer];
        dotLineLayer.path = dotLine.CGPath;
        dotLineLayer.lineWidth = 1.f;
        dotLineLayer.lineDashPattern = @[@1, @2];
        dotLineLayer.strokeColor = [UIColor colorWithRed:151 green:151 blue:151 alpha:0.3].CGColor;
        [self.layer addSublayer:dotLineLayer];
        
        // every (3)hours weather prediction
        UIScrollView *everyHourPredictionScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.033 * CURRENT_VIEW_FRAME_WIDTH, 0.119 * CURRENT_VIEW_FRAME_HEIGHT, 0.934 * CURRENT_VIEW_FRAME_WIDTH, 0.172 * CURRENT_VIEW_FRAME_HEIGHT)];
        // 24 hours prediction
        everyHourPredictionScrollView.contentSize = CGSizeMake(24 * 0.144 * CURRENT_VIEW_FRAME_WIDTH, 0.172 * CURRENT_VIEW_FRAME_HEIGHT);
        everyHourPredictionScrollView.showsHorizontalScrollIndicator = NO;
        
        for (NSInteger i = 0; i < 24; i++) {
            UIView *eachHourPredictionView = [[UIView alloc] initWithFrame:CGRectMake(i * 0.144 * CURRENT_VIEW_FRAME_WIDTH, 0, 0.144 * CURRENT_VIEW_FRAME_WIDTH, 0.172 * CURRENT_VIEW_FRAME_HEIGHT)];
            UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0.1 * eachHourPredictionView.frame.size.width, 0, 0.8 * eachHourPredictionView.frame.size.width, eachHourPredictionView.frame.size.height)];
            
            // hour
            UILabel *hour = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, contentView.frame.size.width, 0.33 * contentView.frame.size.height)];
            hour.font = [UIFont fontWithName:@".PingFang SC" size:13];
            hour.textColor = [UIColor whiteColor];
            hour.textAlignment = NSTextAlignmentCenter;
            [_hours addObject:hour];
            [contentView addSubview:hour];
            
            // hourPredictionImage
            UIImageView *hourPredictionImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0.33 * contentView.frame.size.height, contentView.frame.size.width, 0.33 * contentView.frame.size.height)];
            hourPredictionImage.contentMode = UIViewContentModeScaleAspectFit;
            [_hourPredictionImages addObject:hourPredictionImage];
            [contentView addSubview:hourPredictionImage];
            
            // hourTemp
            UILabel *hourTemp = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.66* contentView.frame.size.height, contentView.frame.size.width, 0.33 * contentView.frame.size.height)];
            hourTemp.font = [UIFont fontWithName:@".PingFang SC" size:13];
            hourTemp.textColor = [UIColor whiteColor];
            hourTemp.textAlignment = NSTextAlignmentCenter;
            [_hourTemps addObject:hourTemp];
            [contentView addSubview:hourTemp];
            
            [eachHourPredictionView addSubview:contentView];
            [everyHourPredictionScrollView addSubview:eachHourPredictionView];
        }
        [self addSubview:everyHourPredictionScrollView];
        
        // 5 day / 7 day weather prediction, as the api only support 7 days prediction
        UIView *dayPredictionView = [[UIView alloc] initWithFrame:CGRectMake(0.039 * CURRENT_VIEW_FRAME_WIDTH, 0.303 * CURRENT_VIEW_FRAME_HEIGHT, 0.925 * CURRENT_VIEW_FRAME_WIDTH, 0.545 * CURRENT_VIEW_FRAME_HEIGHT)];
        for (int i = 0; i < 7; i++) {
            UIView *everyDayPredictionView = [[UIView alloc] initWithFrame:CGRectMake(0, (0.059 + 0.2 * i) * dayPredictionView.frame.size.height, dayPredictionView.frame.size.width, 0.156 * dayPredictionView.frame.size.height)];
            
            // weekday
            UILabel *weekday = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0.191 * everyDayPredictionView.frame.size.width, 0.781 * everyDayPredictionView.frame.size.height)];
            weekday.textColor = [UIColor whiteColor];
            weekday.font = [UIFont fontWithName:@".PingFang SC" size:18];
            [_weekdays addObject:weekday];
            [everyDayPredictionView addSubview:weekday];
            
            // dayPredictionImage
            UIImageView *dayPredictionImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.47 * everyDayPredictionView.frame.size.width, 0.12 * everyDayPredictionView.frame.size.height, 0.10 * everyDayPredictionView.frame.size.width, 0.7 * everyDayPredictionView.frame.size.height)];
            dayPredictionImage.contentMode = UIViewContentModeScaleAspectFit;
            [_dayPredictionImages addObject:dayPredictionImage];
            [everyDayPredictionView addSubview:dayPredictionImage];
            
            // dayMaxTemp
            UILabel *dayMaxTemp = [[UILabel alloc] initWithFrame:CGRectMake(0.752 * everyDayPredictionView.frame.size.width, 0, 0.103 * everyDayPredictionView.frame.size.width, 0.781 * everyDayPredictionView.frame.size.height)];
            dayMaxTemp.textColor = [UIColor whiteColor];
            dayMaxTemp.font = [UIFont fontWithName:@".PingFang SC" size:18];
            [_dayMaxTemps addObject:dayMaxTemp];
            [everyDayPredictionView addSubview:dayMaxTemp];
            
            // dayMinTemp
            UILabel *dayMinTemp = [[UILabel alloc] initWithFrame:CGRectMake(0.897 * everyDayPredictionView.frame.size.width, 0, 0.103 * everyDayPredictionView.frame.size.width, 0.781 * everyDayPredictionView.frame.size.height)];
            dayMinTemp.textColor = [UIColor colorWithRed:125/255.f green:176/255.f blue:229/255.f alpha:1];
            dayMinTemp.font = [UIFont fontWithName:@".PingFang SC" size:18];
            [_dayMinTemps addObject:dayMinTemp];
            [everyDayPredictionView addSubview:dayMinTemp];
            
            // dotLine
            UIBezierPath *dotLine = [UIBezierPath bezierPath];
            [dotLine moveToPoint:CGPointMake(0, 0.98 * everyDayPredictionView.frame.size.height)];
            [dotLine addLineToPoint:CGPointMake(everyDayPredictionView.frame.size.width, 0.98 * everyDayPredictionView.frame.size.height)];
            [dotLine closePath];
            CAShapeLayer *dotLineLayer = [CAShapeLayer layer];
            dotLineLayer.path = dotLine.CGPath;
            dotLineLayer.lineWidth = 1.f;
            dotLineLayer.lineDashPattern = @[@1, @2];
            dotLineLayer.strokeColor = [UIColor colorWithRed:151 green:151 blue:151 alpha:0.3].CGColor;
            [_dotLines addObject:dotLineLayer];
            [everyDayPredictionView.layer addSublayer:dotLineLayer];
            
            [dayPredictionView addSubview:everyDayPredictionView];
        }
        // let the last two days hidden
        for (int i = 5; i < 7; i++) {
            UIView *weekdayView = _weekdays[i];
            [weekdayView.superview setAlpha:0];
        }
        [self addSubview:dayPredictionView];
        
        _changeShowDaysButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changeShowDaysButton setFrame:CGRectMake(0.042 * CURRENT_VIEW_FRAME_WIDTH, 0.9 * CURRENT_VIEW_FRAME_HEIGHT, 0.176 * CURRENT_VIEW_FRAME_WIDTH, 0.048 * CURRENT_VIEW_FRAME_HEIGHT)];
        [_changeShowDaysButton setImage:[UIImage imageNamed:@"5days"] forState:UIControlStateNormal];
        _show5days = YES;
        [_changeShowDaysButton addTarget:self action:@selector(changeShowDays:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_changeShowDaysButton];
        
        
        return self;
    } else {
        return nil;
    }
    
}

- (void)changeShowDays:(UIButton*)button{
    BOOL behindThisView = NO;
    if (_show5days) {
        for (CustomView *view in self.superview.subviews) {
            if (behindThisView) {
                // show the animate
                [view moveDown:self.superview.frame.size.height * 0.07];
            }
            
            if (view == self) {
                behindThisView = YES;
                [view scaleDown:self.superview.frame.size.height * 0.07];
            }
        }
        _show5days = NO;
    } else {
        for (CustomView *view in self.superview.subviews) {
            
            if (behindThisView) {
                // show the animate
                [view moveUp:self.superview.frame.size.height * 0.07];
            }
            if (view == self) {
                behindThisView = YES;
                [view scaleUp:self.superview.frame.size.height * 0.07];
            }
        }
        _show5days = YES;
    }
}

- (NSDateComponents*)getDateComp{
    NSDate *date = [NSDate date];
    NSCalendar *chineseCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    NSDateComponents *dateComps = [chineseCal components:NSHourCalendarUnit | NSWeekdayCalendarUnit fromDate:date];
    return dateComps;
}

- (void)scaleDown:(CGFloat)height{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height + height)];
    [_changeShowDaysButton setFrame:CGRectMake(_changeShowDaysButton.frame.origin.x, _changeShowDaysButton.frame.origin.y + height, _changeShowDaysButton.frame.size.width, _changeShowDaysButton.frame.size.height)];
    [_changeShowDaysButton setImage:[UIImage imageNamed:@"7days"] forState:UIControlStateNormal];
    for (int i = 5; i < 7; i++) {
        UIView *weekdayView = _weekdays[i];
        [weekdayView.superview setAlpha:1];
    }
    
    [UIView commitAnimations];
}

- (void)scaleUp:(CGFloat)height{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - height)];
    [_changeShowDaysButton setFrame:CGRectMake(_changeShowDaysButton.frame.origin.x, _changeShowDaysButton.frame.origin.y - height, _changeShowDaysButton.frame.size.width, _changeShowDaysButton.frame.size.height)];
    [_changeShowDaysButton setImage:[UIImage imageNamed:@"5days"] forState:UIControlStateNormal];
    // let the last two days hidden
    for (int i = 5; i < 7; i++) {
        UIView *weekdayView = _weekdays[i];
        [weekdayView.superview setAlpha:0];
    }
    
    [UIView commitAnimations];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
