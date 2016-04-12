//
//  DataModel.m
//  CGWeather
//
//  Created by 王敏超 on 16/4/5.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import "DataModel.h"
#import "Weather.h"
#import "City.h"
#import "MainViewController.h"

@implementation DataModel

- (instancetype)init{
    if (self = [super init]) {
        // load array in the plist, create a plist at first time
        [self loadCityWeathers];
        // read from shared domain
        [self registerDefaults];
        // handle first time
        [self handleFirstTime];
    }
    return self;
}

- (void)saveCityWeathers{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:self.cityWeathers forKey:@"CityWeathers"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

- (NSString*)documnetsDirectory{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    
    return documentsDirectory;
    
}

- (NSString*)dataFilePath{
    
    return [[self documnetsDirectory] stringByAppendingString:@"CityWeathers.plist"];
    
}

- (void)loadCityWeathers{
    NSString *path = [self dataFilePath];
    NSLog(@"%@", path);
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        // not first time
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        // decode the array saved in plist
        self.cityWeathers = [unarchiver decodeObjectForKey:@"CityWeathers"];
        [unarchiver finishDecoding];
        
    } else {
        // first time
        self.cityWeathers = [[NSMutableArray alloc] initWithCapacity:3];
    }
}

- (void)registerDefaults{
    // read from domain, set default contents at first time;
    NSDictionary *dictionary = @{@"FirstTime" : @YES};
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

- (void)handleFirstTime{
    BOOL firstTime = [[NSUserDefaults standardUserDefaults] boolForKey:@"FirstTime"];
    
    if (firstTime) {
        // these code only operated once, at first time
        // ask for core location permission
        // and init the cityWeathers
        City *location = [[City alloc] initWithCity:@"东莞" cityID:@"CN101281601" country:@"中国" province:@"广东"];
        City *bejing = [[City alloc] initWithCity:@"北京" cityID:@"CN101010100" country:@"中国" province:@"北京"];
        City *guangzhou = [[City alloc] initWithCity:@"广州" cityID:@"CN101280101" country:@"中国" province:@"广东"];
        
        Weather *weatherLocation = [[Weather alloc] initWithCity:location];
        Weather *weatherBeijing = [[Weather alloc] initWithCity:bejing];
        Weather *weatherGuangzhou = [[Weather alloc] initWithCity:guangzhou];
        
        [self.cityWeathers addObject:weatherLocation];
        [self.cityWeathers addObject:weatherBeijing];
        [self.cityWeathers addObject:weatherGuangzhou];
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FirstTime"];
    }
}




@end
