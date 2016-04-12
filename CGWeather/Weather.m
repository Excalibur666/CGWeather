//
//  Weather.m
//  CGWeather
//
//  Created by 王敏超 on 16/4/4.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import "Weather.h"
#import "City.h"

@implementation Weather{
    NSDictionary *_weather;
    NSString *_requestUrl;
}

- (id)initWithCoder:(NSCoder*)aDecoder{
    if (self = [super init]) {
        self.city = [aDecoder decodeObjectForKey:@"City"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)aCoder{
    [aCoder encodeObject:self.city forKey:@"City"];
}


- (instancetype)initWithCity:(City *)city{
    if (self = [super init]) {
        self.city = city;
    }
    return self;
}

- (void)request:(NSString*)httpUrl{
    
    NSURL *url = [NSURL URLWithString:httpUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if (error) {
            NSLog(@"Httperror: %@%ld%@", error.localizedDescription, error.code, error.domain);
        } else {
            NSError *jsonError;
            NSJSONSerialization *returnJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            if (returnJson) {
                NSArray *tmp = [returnJson valueForKeyPath:WEATHER_DETAILS];
                _weather = tmp[0];
                
                // ui update must operated in main thread
                if ([NSThread isMainThread]) {
                    [self callVCToUpdateUI];
                } else{
                    [self performSelectorOnMainThread:@selector(callVCToUpdateUI) withObject:nil waitUntilDone:YES];

                }
            } else {
                //NSLog(@"jsonSerialization: %@", jsonError.localizedDescription);
                NSLog(@"%@", jsonError.localizedDescription);
            }
        }
    }];
}

- (void)updateWeatherData{
    // can't not use self.city.cityID as self.city may be nil
    _requestUrl = [NSString stringWithFormat:@"https://api.heweather.com/x3/weather?cityid=%@&key=%@", self.city.cityID, WEATHER_API_KEY];

    [self request:_requestUrl];
}

- (void)callVCToUpdateUI{
    [self.delegate weatherShouldUpdateUI:self];
}

#pragma mark lazy load


- (NSString*)currentTemperature{
    return [_weather valueForKeyPath:WEATHER_CURRENT_TEMPERATURE];
}

- (NSString*)weatherConditionCode{
    return [_weather valueForKeyPath:WEATHER_CONDITION_CODE];
}

- (NSString*)weatherConditionDesription{
    return [_weather valueForKeyPath:WEATHER_CONDITION_DESCRIPTION];
}

- (NSString*)maxTemperature{
    return [_weather valueForKeyPath:WEATHER_DAILY_FORECAST_MAX_TEMPERATURE][0];
}

- (NSString*)minTemperature{
    return [_weather valueForKeyPath:WEATHER_DAILY_FORECAST_MIN_TEMPERATURE][0];
}

- (NSArray*)hourlyForecastDate{
    return [_weather valueForKeyPath:WEATHER_HOURLY_FORECAST_DATE];
}

- (NSArray*)hourlyForecastTemp{
    return [_weather valueForKeyPath:WEATHER_HOURLY_FORECAST_TMP];
}

- (NSString*)dayWeatherConditionCode{
    return [_weather valueForKeyPath:WEATHER_DAILY_FORECAST_DAY_CONDITION_CODE][0];
}

- (NSString*)nightWeatherConditionCode{
    return [_weather valueForKeyPath:WEATHER_DAILY_FORECAST_NIGHT_CONDITION_CODE][0];
}

- (NSArray*)dailyForecastDate{
    return [_weather valueForKeyPath:WEATHER_DAILY_FORECAST_DATE];
}

- (NSArray*)dailyForecastCondition{
    return [_weather valueForKeyPath:WEATHER_DAILY_FORECAST_DAY_CONDITION_CODE];
}

- (NSArray*)dailyForecastMaxTemp{
    return [_weather valueForKeyPath:WEATHER_DAILY_FORECAST_MAX_TEMPERATURE];
}

- (NSArray*)dailyForecastMinTemp{
    return [_weather valueForKeyPath:WEATHER_DAILY_FORECAST_MIN_TEMPERATURE];
}

- (NSString*)bodyTemperature{
    return [_weather valueForKeyPath:WEATHER_BODY_TEMPERATURE];
}

- (NSString*)currentHumidity{
    return [_weather valueForKeyPath:WEATHER_CURRENT_HUMIDITY];
}

- (NSString*)visibility{
    return [_weather valueForKeyPath:WEATHER_VISIBILITY_RANGE];
}

- (NSString*)ultraviolet{
    return [_weather valueForKeyPath:WEATHER_ULTRAVIOLET_INDEX];
}

- (NSString*)pm25{
    return [_weather valueForKeyPath:WEATHER_PM25];
}

- (NSString*)quality{
    return [_weather valueForKeyPath:WEATHER_QUALITY];
}

- (NSString*)windSpeed{
    return [_weather valueForKeyPath:WEATHER_WIND_SPEED];
}

- (NSString*)windDirection{
    return [_weather valueForKeyPath:WEATHER_WIND_DIRECTION];
}

- (NSString*)windScale{
    return [_weather valueForKeyPath:WEATHER_WIND_SCALE];
}

- (NSString*)pressure{
    return [_weather valueForKeyPath:WEATHER_PRESSURE];
}

- (NSString*)localTime{
    return [[_weather valueForKeyPath:WEATHER_CITY_LOCAL_TIME] substringFromIndex:11];
}

@end
