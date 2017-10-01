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
#pragma mark ponit

@interface UIView (Frame)

@property (nonatomic,assign) CGFloat x;

@property (nonatomic,assign) CGFloat y;

@property(nonatomic,assign)  CGFloat centerX;

@property (nonatomic,assign) CGFloat centerY;



@property (nonatomic,assign) CGPoint origin;

#pragma mark size

@property (nonatomic,assign) CGFloat width;

@property (nonatomic,assign) CGFloat height;

@property (nonatomic,assign) CGSize size;

@end

