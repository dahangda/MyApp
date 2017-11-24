//
//  UIView+Frame.h
//  MyApp
//
//  Created by 燕航 on 2017/10/1.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 设置／获取视图的位置，尺寸
 */


@interface UIView (Frame)
#pragma mark ponit---位置相关
@property (nonatomic,assign) CGFloat x;

@property (nonatomic,assign) CGFloat y;

@property(nonatomic,assign)  CGFloat centerX;

@property (nonatomic,assign) CGFloat centerY;



@property (nonatomic,assign) CGPoint origin;

#pragma mark size---尺寸相关

@property (nonatomic,assign) CGFloat width;

@property (nonatomic,assign) CGFloat height;

@property (nonatomic,assign) CGSize size;

@end

