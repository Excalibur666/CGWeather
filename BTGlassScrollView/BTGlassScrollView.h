//
//  BTGlassScrollView.h
//  BTGlassScrollViewExample
//
//  Created by Byte on 10/18/13.
//  Copyright (c) 2013 Byte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+ImageEffects.h"

//default blur settings
#define DEFAULT_BLUR_RADIUS 14
#define DEFAULT_BLUR_TINT_COLOR [UIColor colorWithWhite:0 alpha:.3]
#define DEFAULT_BLUR_DELTA_FACTOR 1.4

//how much the background moves when scroll
#define DEFAULT_MAX_BACKGROUND_MOVEMENT_VERTICAL 30
#define DEFAULT_MAX_BACKGROUND_MOVEMENT_HORIZONTAL 150


//the value of the fading space on the top between the view and navigation bar
#define DEFAULT_TOP_FADING_HEIGHT_HALF 10
#define DEFAULT_NAVIGATION_BAR_HEIGHT 44

@protocol BTGlassScrollViewDelegate;

@interface BTGlassScrollView : UIView <UIScrollViewDelegate>
//width = 640 + 2 * DEFAULT_MAX_BACKGROUND_MOVEMENT_VERTICAL
//height = 1136 + DEFAULT_MAX_BACKGROUND_MOVEMENT_VERTICAL
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) UIImage *blurredBackgroundImage;//default blurred is provided, thus nil is acceptable
@property (nonatomic, assign) CGFloat viewDistanceFromBottom;//how much view is showed up from the bottom
@property (nonatomic, strong) UIView *foregroundView;//the view that will contain all the info
@property (nonatomic, assign) CGFloat topLayoutGuideLength;//set this only when using navigation bar of sorts.
@property (nonatomic, strong, readonly) UIScrollView *foregroundScrollView;//readonly just to get the scroll offsets
@property (nonatomic, strong) UINavigationBar *navigationBar;// contained by foregroud, could be drag down when scroll beyond top
@property (nonatomic, weak) id<BTGlassScrollViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame BackgroundImage:(UIImage *)backgroundImage blurredImage:(UIImage *)blurredImage viewDistanceFromBottom:(CGFloat)viewDistanceFromBottom foregroundView:(UIView *)foregroundView;
- (id)initWithFrame:(CGRect)frame BackgroundImage:(UIImage *)backgroundImage blurredImage:(UIImage *)blurredImage viewDistanceFromBottom:(CGFloat)viewDistanceFromBottom foregroundView:(UIView *)foregroundView navigationbar:(UINavigationBar*)navigationBar;// default navigation bar's height is 44
- (void)scrollHorizontalRatio:(CGFloat)ratio;//from -1 to 1
- (void)scrollVerticallyToOffset:(CGFloat)offsetY;
@end


@protocol BTGlassScrollViewDelegate <NSObject>
@optional
//use this to configure your foregroundView when the frame of the whole view changed
- (void)glassScrollView:(BTGlassScrollView *)glassScrollView didChangedToFrame:(CGRect)frame;
//do something when pull to refresh
- (void)dealWithPullToRefresh:(UIScrollView*)scrollView;
@end