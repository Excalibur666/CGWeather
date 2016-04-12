//
//  CustomView.h
//  CGWeather
//
//  Created by 王敏超 on 16/4/4.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//
#define CURRENT_VIEW_FRAME_WIDTH self.frame.size.width
#define CURRENT_VIEW_FRAME_HEIGHT self.frame.size.height


#import <UIKit/UIKit.h>
#import "Weather.h"

@interface CustomView : UIImageView

- (instancetype)init;
- (instancetype)initViewWithWidth:(CGFloat)width andHeight:(CGFloat)height withOffset:(CGFloat)offset;
- (void)updateUIWithWeather:(Weather*)weather;
- (void)moveDown:(CGFloat)height;
- (void)moveUp:(CGFloat)height;
- (void)scaleDown:(CGFloat)height;
- (void)scaleUp:(CGFloat)height;

@property (nonatomic, strong) Weather *_weather;


@end
