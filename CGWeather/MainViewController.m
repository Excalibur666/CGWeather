//
//  ViewController.m
//  CGWeather
//
//  Created by 王敏超 on 16/4/1.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import "MainViewController.h"
#import "YRSideViewController.h"
#import "SetViewController.h"
#import "WeatherKeyInfoView.h"
#import "WeatherPredictionView.h"
#import "WeatherDetailsView.h"
#import "Pm25View.h"
#import "WindView.h"
#import "DataModel.h"
#import "City.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "AppDelegate.h"

@interface MainViewController ()

@end

@implementation MainViewController{
    UIScrollView *_viewScroller;
    
    NSMutableArray *_glassScrollViews;
    NSMutableArray *_views;
    NSMutableArray *_navigationBarLocalTimeLabels;
}

# pragma mark init
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // init things
    _glassScrollViews = [[NSMutableArray alloc] init];
    _views = [[NSMutableArray alloc] init];
    _navigationBarLocalTimeLabels = [[NSMutableArray alloc] init];
    
    // prevent weird inset
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    // navigation bar work
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.userInteractionEnabled = NO;
    
    // backgroud
    self.view.backgroundColor = [UIColor blackColor];
    
    // create viewScroller
    CGFloat blackSideBarWidth = 2;
    _viewScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width + 2 * blackSideBarWidth, self.view.frame.size.height)];
    [_viewScroller setPagingEnabled:YES];
    [_viewScroller setDelegate:self];
    [_viewScroller setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:_viewScroller];
    
    // create views in the viewScroller, and set delegate for each weather obj
    for (Weather *weather in self.dataModel.cityWeathers) {
        [self addPageForWeather:weather];
        [weather setDelegate:self];
    }
    [self configureViewScroller];
}

#pragma mark UI things

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //[self moveToPage];
    
    // update weather for all cities
    [self updateUI];
    
    // update refresh time for all cities
    [self updateRefreshTime];
}

- (void)configureViewScroller{
    // _viewScroller.width is self.view.frame.width + 4
    [_viewScroller setContentSize:CGSizeMake(self.dataModel.cityWeathers.count * _viewScroller.frame.size.width, self.view.frame.size.height)];
    
    // move view2/view3/... to pages
    for (BTGlassScrollView *btGlassScrollView in _glassScrollViews) {
        NSUInteger index = [_glassScrollViews indexOfObject:btGlassScrollView];
        [btGlassScrollView setFrame:CGRectOffset(btGlassScrollView.bounds, _viewScroller.frame.size.width * index, 0)];
    }
}

- (void)moveToPage:(NSUInteger)page{
    self.page = page;
    [_viewScroller setContentOffset:CGPointMake(self.page * _viewScroller.frame.size.width, _viewScroller.contentOffset.y)];
}

- (UIView*)createCustomView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SELF_VIEW_FRAME_WIDTH, SELF_VIEW_FRAME_HEIGHT * 1.95)];
    
    [view addSubview:[[WeatherKeyInfoView alloc] initViewWithWidth:SELF_VIEW_FRAME_WIDTH andHeight:SELF_VIEW_FRAME_HEIGHT withOffset:CUSTOM_VIEW_OFFSET]];
    [view addSubview:[[WeatherPredictionView alloc] initViewWithWidth:SELF_VIEW_FRAME_WIDTH andHeight:SELF_VIEW_FRAME_HEIGHT withOffset:CUSTOM_VIEW_OFFSET]];
    [view addSubview:[[WeatherDetailsView alloc] initViewWithWidth:SELF_VIEW_FRAME_WIDTH andHeight:SELF_VIEW_FRAME_HEIGHT withOffset:CUSTOM_VIEW_OFFSET]];
    [view addSubview:[[Pm25View alloc] initViewWithWidth:SELF_VIEW_FRAME_WIDTH andHeight:SELF_VIEW_FRAME_HEIGHT withOffset:CUSTOM_VIEW_OFFSET]];
    [view addSubview:[[WindView alloc] initViewWithWidth:SELF_VIEW_FRAME_WIDTH andHeight:SELF_VIEW_FRAME_HEIGHT withOffset:CUSTOM_VIEW_OFFSET]];
    // as init, weather data is not ready
    view.alpha = 0;

    
    return view;
}

- (UINavigationBar*)createBarViewWithWeather:(Weather*)weather{
    
    NSUInteger index = [self.dataModel.cityWeathers indexOfObject:weather];
    UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(_viewScroller.frame.size.width * index, _viewScroller.contentOffset.y, SELF_VIEW_FRAME_WIDTH, DEFAULT_NAVIGATION_BAR_HEIGHT)];

    [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[UIImage new]];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:weather.city.cityName];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCity:)];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Hamburger Menu Icon"] style:UIBarButtonItemStylePlain target:self action:@selector(set:)];
    rightButton.tintColor = [UIColor whiteColor];
    leftButton.tintColor = [UIColor whiteColor];
    item.rightBarButtonItem = rightButton;
    item.leftBarButtonItem = leftButton;
    
    [bar pushNavigationItem:item animated:YES];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    headerView.backgroundColor = [UIColor clearColor];
    headerView.autoresizesSubviews = YES;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 200, 24)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@".PingFang SC" size:19];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.shadowColor = [UIColor darkGrayColor];
//    titleLabel.shadowOffset = CGSizeMake(0, -1);
    titleLabel.text = weather.city.cityName;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    [headerView addSubview:titleLabel];
//    // deal with the location city
//    if (index == 0) {
//        UIImageView *locationIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"locationIcon"]];
//        [locationIcon setFrame:CGRectMake(60, 3, 16, 19)];
//        [titleLabel addSubview:locationIcon];
//    }
    
    
    UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, 200, 44 - 24)];
    subtitleLabel.backgroundColor = [UIColor clearColor];
    subtitleLabel.font = [UIFont fontWithName:@".PingFang SC" size:12];
    subtitleLabel.textAlignment = NSTextAlignmentCenter;
    subtitleLabel.textColor = [UIColor whiteColor];
//    subtitleLabel.shadowColor = [UIColor darkGrayColor];
//    subtitleLabel.shadowOffset = CGSizeMake(0, -1);
    subtitleLabel.text = weather.localTime;
    subtitleLabel.adjustsFontSizeToFitWidth = YES;
    [headerView addSubview:subtitleLabel];
    [_navigationBarLocalTimeLabels addObject:subtitleLabel];
    
    headerView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    
    item.titleView = headerView;
    
    return bar;
}


- (void)viewWillLayoutSubviews
{
    // if the view has navigation bar, this is a great place to realign the top part to allow navigation controller
    // or even the status bar
    for (BTGlassScrollView *btGlassScrollView in _glassScrollViews) {
        [btGlassScrollView setTopLayoutGuideLength:0];
    }
}


// invoked when contentOffset changed
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat ratio = scrollView.contentOffset.x/scrollView.frame.size.width;
    self.page = (int)floor(ratio);
    NSLog(@"%ld",self.page);
    for (int i = 0; i < _glassScrollViews.count; i++) {
        if (ratio > i - 1 && ratio < i + 1) {
            [_glassScrollViews[i] scrollHorizontalRatio:-ratio + i];
        }
    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    BTGlassScrollView *glass = [self currentGlass];
    for (BTGlassScrollView *btGlassScrollView in _glassScrollViews) {
        [btGlassScrollView scrollVerticallyToOffset:glass.foregroundScrollView.contentOffset.y];
    }
}

- (void)scrollViewDidScrollToTop:(nonnull UIScrollView *)scrollView{
    NSLog(@"top");
}

- (BTGlassScrollView *)currentGlass
{
    return _glassScrollViews[self.page];
}

- (void)addPageForWeather:(Weather*)weather{
    UIView *view = [self createCustomView];
    UINavigationBar *bar = [self createBarViewWithWeather:weather];
    
    // init each page and set delegate
    BTGlassScrollView *glassScrollView = [[BTGlassScrollView alloc] initWithFrame:self.view.frame BackgroundImage:[UIImage imageNamed:@"background2"] blurredImage:nil viewDistanceFromBottom:SELF_VIEW_FRAME_HEIGHT * 0.38 foregroundView:view navigationbar:bar];
    [glassScrollView setDelegate:self];
    
    [_viewScroller addSubview:glassScrollView];
    
    [_views addObject:view];
    [_glassScrollViews addObject:glassScrollView];
}

#pragma mark data things

- (void)updateUI{
    // update all weather
    for (Weather *weather in self.dataModel.cityWeathers) {
        [weather updateWeatherData];
    }
}

- (void)updateRefreshTime{
    for (BTGlassScrollView *btGlassScrollView in _glassScrollViews) {
        NSDateFormatter *refreshTime = [[NSDateFormatter alloc] init];
        [refreshTime setDateFormat:@"yyyy/MM/dd HH:mm"];
        [btGlassScrollView.foregroundScrollView.pullToRefreshView setSubtitle:[NSString stringWithFormat:@"更新时间：%@", [refreshTime stringFromDate:[NSDate date]]] forState:SVPullToRefreshStateAll];
    }
}

- (void)addWeatherWithCity:(City*)city{
    Weather *newWeather = [[Weather alloc] initWithCity:city];
    [newWeather setDelegate:self];
    
    [self.dataModel.cityWeathers addObject:newWeather];
    
    NSUInteger index = self.dataModel.cityWeathers.count - 1;
    [self addPageForWeather:self.dataModel.cityWeathers[index]];
    [self configureViewScroller];
    
    [self moveToPage:index];
}



- (void)addCity:(UIButton*)button{
    // init search view controller and set delegate
    AddCityViewController *addCityViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AddCity"];
    [addCityViewController setDelegate:self];
    
    [self presentViewController:addCityViewController animated:YES completion:nil];
}

- (void)set:(UIButton*)button{
    SetViewController *setViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Set"];
    setViewController.dataModel = self.dataModel;
    
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    YRSideViewController *sideViewController = delegate.sideViewController;
    delegate.sideViewController.leftViewController = setViewController;
    [sideViewController showLeftViewController:YES];
}

#pragma mark delegate method

// WeatherDelegate method
- (void)weatherShouldUpdateUI:(Weather*)weather{
    NSInteger index = [self.dataModel.cityWeathers indexOfObject:weather];
    
    UIView *view = _views[index];
    if (view.alpha == 0) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        view.alpha = 1;
        [UIView commitAnimations];
    }
    
    // update custom views about weather
    for (CustomView *customView in view.subviews) {
        [customView updateUIWithWeather:self.dataModel.cityWeathers[index]];
    }
    
    // update local time
    UILabel *localTime = _navigationBarLocalTimeLabels[index];
    localTime.text = weather.localTime;
}

// AddCityViewControllerDelegate method
- (void)addCityDealWithNewCity:(City *)city{
    // get city obj from AddCityViewController
    [self addWeatherWithCity:city];
}

// BTGlassScrollViewDelegate
- (void)dealWithPullToRefresh:(UIScrollView *)scrollView{
    __weak MainViewController *weekSelf = self;
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // update weather for all cities
        [weekSelf updateUI];
        
        // update refresh time for all cities
        [weekSelf updateRefreshTime];
        
        [scrollView.pullToRefreshView stopAnimating];
    });
}

@end
