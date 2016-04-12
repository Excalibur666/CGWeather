//
//  CustomView.m
//  CGWeather
//
//  Created by 王敏超 on 16/4/4.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import "CustomView.h"
#import "Weather.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomView


- (instancetype)init{
    if (self = [super init]) {
        [self setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    }
    return self;
}

- (void)moveDown:(CGFloat)height{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + height, self.frame.size.width, self.frame.size.height)];
    [UIView commitAnimations];
}

- (void)moveUp:(CGFloat)height{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y - height, self.frame.size.width, self.frame.size.height)];
    [UIView commitAnimations];
}

- (void)scaleDown:(CGFloat)height{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height + height)];
    [UIView commitAnimations];
}

- (void)scaleUp:(CGFloat)height{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - height)];
    [UIView commitAnimations];
}















/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
