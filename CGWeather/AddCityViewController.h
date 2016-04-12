//
//  AddCityViewController.h
//  CGWeather
//
//  Created by 王敏超 on 16/4/7.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import <UIKit/UIKit.h>
@class City;
@protocol AddCityViewControllerDelegate <NSObject>

- (void)addCityDealWithNewCity:(City*)city;

@end

@interface AddCityViewController : UITableViewController <UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate>

@property (nonatomic, weak) id<AddCityViewControllerDelegate> delegate;

@end
