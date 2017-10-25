//
//  YHTabBarItem.h
//  MyApp
//
//  Created by 燕航 on 2017/10/16.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHTabBarItem : UIButton
/** 存属性 */
@property(nonatomic,strong) UITabBarItem * tabBarItem;
/**
 *  TabBar item title color
 */
@property (nonatomic, strong) UIColor *itemTitleColor;
/**
 *  TabBar selected item title color
 */
@property (nonatomic, strong) UIColor *selectedItemTitleColor;

/**
*  TabBar item title font
*/
@property (nonatomic, strong) UIFont *itemTitleFont;
/**
 *  TabBar item image ratio
 */


@property (nonatomic, assign) CGFloat itemImageRatio;


- (instancetype)initWithItemImageRatio:(CGFloat)itemImageRatio;
@end
