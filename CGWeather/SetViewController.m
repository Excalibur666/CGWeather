//
//  SetViewController.m
//  CGWeather
//
//  Created by 王敏超 on 16/4/10.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import "SetViewController.h"
#import "MainViewController.h"
#import "YRSideViewController.h"
#import "AppDelegate.h"
#import "DataModel.h"
#import "Weather.h"
#import "City.h"

@interface SetViewController ()

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.view.backgroundColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModel.cityWeathers.count + 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"CityCell" forIndexPath:indexPath];
    
    
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"locationYellow"];
        cell.textLabel.font = [UIFont fontWithName:@".PingFang SC" size:15];
        cell.textLabel.text = @"编辑地点";
    } else if (indexPath.row <= self.dataModel.cityWeathers.count && indexPath.row > 0) {
        cell.imageView.image = [UIImage imageNamed:@"locationGray"];
        Weather *weather = self.dataModel.cityWeathers[indexPath.row - 1];
        cell.textLabel.font = [UIFont fontWithName:@".PingFang SC" size:15];
        cell.textLabel.text = weather.city.cityName;
    } else if (indexPath.row == self.dataModel.cityWeathers.count + 1) {
        // draw seperate line
        UIBezierPath *path = [[UIBezierPath alloc] init];
        [path moveToPoint:CGPointMake(20, cell.frame.size.height * 0.02)];
        [path addLineToPoint:CGPointMake(320, cell.frame.size.height * 0.02)];
        [path moveToPoint:CGPointMake(20, cell.frame.size.height * 0.98)];
        [path addLineToPoint:CGPointMake(320, cell.frame.size.height * 0.98)];
        [path closePath];
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        layer.path = path.CGPath;
        layer.strokeColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1].CGColor;
        [cell.layer addSublayer:layer];
        cell.textLabel.text = @"";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else if (indexPath.row == self.dataModel.cityWeathers.count + 2) {
        cell.textLabel.text = @"";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else if (indexPath.row == self.dataModel.cityWeathers.count + 3) {
        cell.textLabel.font = [UIFont fontWithName:@".PingFang SC" size:11];
        cell.textLabel.text = @"工具";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else if (indexPath.row == self.dataModel.cityWeathers.count + 4) {
        cell.textLabel.font = [UIFont fontWithName:@".PingFang SC" size:15];
        cell.textLabel.text = @"设置";
        
        // draw seperate line
        UIBezierPath *path = [[UIBezierPath alloc] init];
        [path moveToPoint:CGPointMake(0, cell.frame.size.height * 0.98)];
        [path addLineToPoint:CGPointMake(320, cell.frame.size.height * 0.98)];
        [path closePath];
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        layer.path = path.CGPath;
        layer.strokeColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1].CGColor;
        [cell.layer addSublayer:layer];

    }
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1];
    
    return cell;
}


- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (indexPath.row > 0 && indexPath.row <= self.dataModel.cityWeathers.count) {
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        MainViewController *mainViewController = (MainViewController*)delegate.sideViewController.rootViewController;
        [mainViewController moveToPage:indexPath.row - 1];
        [delegate.sideViewController hideSideViewController:YES];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
