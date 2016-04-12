//
//  Weather.h
//  CGWeather
//
//  Created by 王敏超 on 16/4/4.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#define WEATHER_DETAILS @"HeWeather data service 3.0"
#define WEATHER_STATUS @"status"

#define WEATHER_CURRENT_TEMPERATURE @"now.tmp"
#define WEATHER_MAX_TEMPERATURE @"daily_forecast.tmp.max"
#define WEATHER_MIN_TEMPERATURE @"daily_forecast.tmp.min"
#define WEATHER_CONDITION_CODE @"now.cond.code"
#define WEATHER_CONDITION_DESCRIPTION @"now.cond.txt"

#define WEATHER_HOURLY_FORECAST_DATE @"hourly_forecast.date"
#define WEATHER_HOURLY_FORECAST_TMP @"hourly_forecast.tmp"
#define WEATHER_DAILY_FORECAST_DATE @"daily_forecast.date"
#define WEATHER_DAILY_FORECAST_DAY_CONDITION_CODE @"daily_forecast.cond.code_d"
#define WEATHER_DAILY_FORECAST_NIGHT_CONDITION_CODE @"daily_forecast.cond.code_n"
#define WEATHER_DAILY_FORECAST_MAX_TEMPERATURE @"daily_forecast.tmp.max"
#define WEATHER_DAILY_FORECAST_MIN_TEMPERATURE @"daily_forecast.tmp.min"
#define WEATHER_BODY_TEMPERATURE @"now.fl"
#define WEATHER_CURRENT_HUMIDITY @"now.hum"
#define WEATHER_VISIBILITY_RANGE @"now.vis"
#define WEATHER_ULTRAVIOLET_INDEX @"suggestion.uv.brf"
#define WEATHER_PM25 @"aqi.city.pm25"
#define WEATHER_QUALITY @"aqi.city.qlty"
#define WEATHER_WIND_SPEED @"now.wind.spd"
#define WEATHER_WIND_DIRECTION @"now.wind.dir"
#define WEATHER_WIND_SCALE @"now.wind.sc"
#define WEATHER_PRESSURE @"now.pres"
#define WEATHER_CITY_LOCAL_TIME @"basic.update.loc"

#import <Foundation/Foundation.h>
#import "WeatherAPIKey.h"

@class MainViewController;
@class Weather;
@class City;

@protocol WeatherDelegate <NSObject>
// update UI after get data from API
- (void)weatherShouldUpdateUI:(Weather*)weather;
@end


@interface Weather : NSObject


- (instancetype)initWithCity:(City*)city;
- (void)updateWeatherData;//invoke by vc to update data

@property (nonatomic, strong) City *city;



@property (nonatomic, strong) NSString *weatherConditionCode;
@property (nonatomic, strong) NSString *weatherConditionDesription;
@property (nonatomic, strong) NSString *currentTemperature;
@property (nonatomic, strong) NSString *maxTemperature;
@property (nonatomic, strong) NSString *minTemperature;
@property (nonatomic, strong) NSString *dayWeatherConditionCode;
@property (nonatomic, strong) NSString *nightWeatherConditionCode;
@property (nonatomic, strong) NSArray *hourlyForecastDate;
@property (nonatomic, strong) NSArray *hourlyForecastTemp;
@property (nonatomic, strong) NSArray *dailyForecastDate;
@property (nonatomic, strong) NSArray *dailyForecastCondition;
@property (nonatomic, strong) NSArray *dailyForecastMaxTemp;
@property (nonatomic, strong) NSArray *dailyForecastMinTemp;
@property (nonatomic, strong) NSString *currentHumidity;
@property (nonatomic, strong) NSString *bodyTemperature;
@property (nonatomic, strong) NSString *visibility;
@property (nonatomic, strong) NSString *ultraviolet;
@property (nonatomic, strong) NSString *pm25;
@property (nonatomic, strong) NSString *quality;
@property (nonatomic, strong) NSString *windSpeed;
@property (nonatomic, strong) NSString *windDirection;
@property (nonatomic, strong) NSString *windScale;
@property (nonatomic, strong) NSString *pressure;
@property (nonatomic, strong) NSString *precipitation;
@property (nonatomic, strong) NSString *localTime;


@property (nonatomic, weak) id<WeatherDelegate> delegate;

@end


