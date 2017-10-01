//
//  UIView+Frame.m
//  MyApp
//
//  Created by 燕航 on 2017/10/1.
//  Copyright © 2017年 yanhang. All rights reserved.
//
// CGSize,CGPoint ,CGRect 是结构体。因此不能用语法糖拿值，不能设置（赋值）值。结构体属性不能单个修改，但是可以整体修改

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)x
{
    return self.origin.x;
}

- (void)setX:(CGFloat)x
{
    self.origin = CGPointMake(x, self.origin.y);
}

- (CGFloat)y
{
    return self.origin.y;
}

- (void)setY:(CGFloat)y
{
    self.origin = CGPointMake(self.origin.x, y);
    
}

- (CGFloat)centerX
{
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
    
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.centerX, centerY);
}
- (CGPoint)origin
{
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin
{
    self.frame = CGRectMake(origin.x, origin.y, self.width, self.height);
    
}
- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    self.size = CGSizeMake(width, self.frame.size.height);
}

- (CGFloat)height
{
    return self.frame.size.height;
    
}

- (void)setHeight:(CGFloat)height
{
    self.size = CGSizeMake(self.width, height);
    
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    self.frame = CGRectMake(self.origin.x, self.origin.y, size.width, size.height);
    
}

@end
