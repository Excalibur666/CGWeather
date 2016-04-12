//
//  City.m
//  CGWeather
//
//  Created by 王敏超 on 16/4/7.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import "City.h"

@implementation City

- (instancetype)initWithCity:(NSString *)cityName cityID:(NSString *)cityID country:(NSString *)country province:(NSString *)province{
    
    if (self = [self init]) {
        self.cityName = cityName;
        self.cityID = cityID;
        self.country = country;
        self.province = province;
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)aDecoder{
    if (self = [super init]) {
        self.cityName = [aDecoder decodeObjectForKey:@"CityName"];
        self.cityID = [aDecoder decodeObjectForKey:@"CityID"];
//        self.country = [aDecoder decodeObjectForKey:@"Country"];
//        self.province = [aDecoder decodeObjectForKey:@"Province"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)aCoder{
    [aCoder encodeObject:self.cityName forKey:@"CityName"];
    [aCoder encodeObject:self.cityID forKey:@"CityID"];
//    [aCoder encodeObject:self.country forKey:@"Country"];
//    [aCoder encodeObject:self.province forKey:@"Province"];
}

@end
