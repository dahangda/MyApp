//
//  YHTabBar.h
//  MyApp
//
//  Created by 燕航 on 2017/10/9.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHTabBarDelegate <NSObject>

@optional

- (void)ChangeSelectIndexFrom:(NSInteger)from to:(NSInteger)to;

@end



@interface YHTabBar : UIView
/** 代理 */
@property(nonatomic,weak) id<YHTabBarDelegate> delegate;
/*多少个itme
 */
@property(nonatomic,assign) NSInteger itmeCount;

/**
 *  TabBar item image ratio
 */
@property (nonatomic, assign) CGFloat itemImageRatio;









- (void)addImageView;
/**
 *  Add tabBar item
 */
- (void)addTabBarItem:(UITabBarItem *)item;
@end
