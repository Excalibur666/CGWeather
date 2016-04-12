//
//  AddCityViewController.m
//  CGWeather
//
//  Created by 王敏超 on 16/4/7.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import "AddCityViewController.h"
#import "City.h"

@interface AddCityViewController ()
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSMutableArray *foundCities;
@property (strong, nonatomic) NSMutableArray *allCities;
@end

@implementation AddCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    //  When creating the search controller we do not need a separate search results controller as we will use the table view controller itself.
    //  Likewise we will also use the table view controller to update the search results by having it implement the UISearchResultsUpdating protocol.
    //  We do not want to dim the underlying content as we want to show the filtered results as the user types into the search bar.
    //  The UISearchController takes care of creating the search bar for us.
    //  The table view controller will also act as the search bar delegate for when the user changes the search scope.
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    
    // add the search bar view to the table view header
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    // Finally since the search view covers the table view when active we make the table view controller define the presentation context
    self.definesPresentationContext = YES;
    
    // configure searchbar ui
    [self.searchController.searchBar sizeToFit];
    [self.searchController.searchBar setBarStyle:UIBarStyleBlackTranslucent];
    [self.searchController.searchBar setTintColor:[UIColor whiteColor]];
    [self.searchController.searchBar setPlaceholder:@"输入城市名称"];
    //[self.searchController.searchBar]
    [self.searchController.searchBar setShowsCancelButton:YES animated:YES];
    UIButton *btn=[self.searchController.searchBar valueForKey:@"_cancelButton"];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    
    // configure tableView
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewDidAppear:(BOOL)animated{

//    [self viewDidAppear:animated];
    [self performSelector:@selector(showKeyboard) withObject:nil afterDelay:0.1];
}


- (void)showKeyboard{
    [self.searchController.searchBar becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated{
    NSLog(@"disappear");
}

#pragma mark UITableView DataSource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.foundCities.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FoundCityCell"];
    cell.backgroundColor = [UIColor blackColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    // draw seperate line
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(0.025 * self.view.frame.size.width, cell.frame.size.height * 0.98)];
    [path addLineToPoint:CGPointMake(0.975 * self.view.frame.size.width, cell.frame.size.height * 0.98)];
    [path closePath];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = path.CGPath;
    layer.strokeColor = [UIColor colorWithRed:23 green:23 blue:23 alpha:0.2].CGColor;
    [cell.layer addSublayer:layer];
    
    City *city = self.foundCities[indexPath.row];
    if (city.province && city.country) {
        cell.textLabel.text = [city.cityName stringByAppendingFormat:@"  %@  %@", city.province, city.country];
    } else if (!city.province && city.country) {
        cell.textLabel.text = [city.cityName stringByAppendingFormat:@"  %@", city.country];
    } else if (!city.province && !city.country) {
        cell.textLabel.text = city.cityName;
    }
    
    return cell;
}


- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    // select a row means city not nil
    NSLog(@"didSelectRowAtIndexPath");
    [self.searchController setActive:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate addCityDealWithNewCity:self.foundCities[indexPath.row]];
    
}


#pragma mark UISearchResultsUpdating delegate

// With the search controller configured the rest is mostly boilerplate code. We need to implement the UISearchResultsUpdating delegate to generate the new filtered results anytime the search text changes
- (void)updateSearchResultsForSearchController:(nonnull UISearchController *)searchController{
    [self.tableView reloadData];
}


#pragma mark UISearchBarDelegate


// called when text starts editing
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"searchBarTextDidBeginEditing");
}

// called when text changes (including clear)
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.foundCities removeAllObjects];
    
    for (City *city in self.allCities) {
        NSRange cityRange = [city.cityName rangeOfString:searchText options:NSCaseInsensitiveSearch];
        NSRange countryRange;
        NSRange provinceRange;
        if (city.country) {
            countryRange = [city.country rangeOfString:searchText options:NSCaseInsensitiveSearch];
        }
        
        if (city.province) {
            provinceRange = [city.province rangeOfString:searchText options:NSCaseInsensitiveSearch];
        }
  
        if (cityRange.location != NSNotFound || countryRange.location != NSNotFound || provinceRange.location != NSNotFound) {
            [self.foundCities addObject:city];
        }
    }
    //NSLog(@"%@", self.foundCities);
}

// called when text ends editing
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSLog(@"searchBarTextDidEndEditing");
}

// called when cancel button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark lazy loading

- (NSMutableArray*)foundCities{
    if (!_foundCities) {
        _foundCities = [[NSMutableArray alloc] init];
    }
    return _foundCities;
}

- (NSMutableArray*)allCities{
    if (!_allCities) {
        _allCities = [[NSMutableArray alloc] init];
        NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"citylist" ofType:@"json"]];
        NSError *error;
        NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        if (json) {
            // do something with jsonArray
            NSArray *citylistArray = [json valueForKey:@"city_info"];
            for (NSDictionary *citySource in citylistArray) {
                City *city = [[City alloc] init];
                city.cityName = [citySource valueForKey:@"city"];
                city.country = [citySource valueForKey:@"cnty"];
                city.cityID = [citySource valueForKey:@"id"];
                city.province = [citySource valueForKey:@"prov"];
                
                // attractions ID ends with 'A'
                if ([city.cityID characterAtIndex:city.cityID.length - 1] != 'A') {
                    [_allCities addObject:city];
                }
            }
        } else {
            NSLog(@"Couldn't load JSON from %@: %@", json, error);
        }

    }
    return _allCities;
}

//- (BOOL)prefersStatusBarHidden{
//    return YES;
//}


//#pragma mark UISearchControllerDelegate
//
//- (void)didPresentSearchController:(nonnull UISearchController *)searchController{
//    [searchController setActive:YES];
//    [searchController.searchBar becomeFirstResponder];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
