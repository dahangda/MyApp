//
//  YHTabBarItem.m
//  MyApp
//
//  Created by 燕航 on 2017/10/16.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#import "YHTabBarItem.h"

@implementation YHTabBarItem

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        //self.tabBarBadge = [[TabBarBadge alloc] init];
        //[self addSubview:self.tabBarBadge];
    }
    return self;
}


#pragma mark ********************初始化方法比例

- (instancetype)initWithItemImageRatio:(CGFloat)itemImageRatio {
    
    if (self = [super init]) {
        
        self.itemImageRatio = itemImageRatio;
    }
    return self;
}
#pragma mark-----------------title字体大小设置

- (void)setItemTitleFont:(UIFont *)itemTitleFont {
    
    _itemTitleFont = itemTitleFont;
    
    self.titleLabel.font = itemTitleFont;
}
#pragma mark-----------------title字体颜色设置
- (void)setItemTitleColor:(UIColor *)itemTitleColor {
    
    _itemTitleColor = itemTitleColor;
    
    [self setTitleColor:itemTitleColor forState:UIControlStateNormal];
}
#pragma mark-----------------title选择字体设置
- (void)setSelectedItemTitleColor:(UIColor *)selectedItemTitleColor {
    
    _selectedItemTitleColor = selectedItemTitleColor;
    
    [self setTitleColor:selectedItemTitleColor forState:UIControlStateSelected];
}
#pragma mark ********************依照给的item设置内部

- (void)setTabBarItem:(UITabBarItem *)tabBarItem {
    
    _tabBarItem = tabBarItem;
    self.titleLabel.font =YHFont(14);
    [self setTitle:tabBarItem.title forState:UIControlStateNormal];
    [self setImage:tabBarItem.image forState:UIControlStateNormal];
    [self setImage:tabBarItem.selectedImage forState:UIControlStateSelected];
    

}


#pragma mark - Reset TabBarItem

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGFloat imageX = 0.f;
    CGFloat imageY = 0.f;
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * 0.7;
    YHLog(@"itemImageRatio%f",self.itemImageRatio);
     YHLog(@"--------imagew%f----",imageW);
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat titleX = 0.f;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleY = contentRect.size.height * 0.7;
    YHLog(@"###%f###",contentRect.size.height);
    YHLog(@"titleY%f",titleY);
    CGFloat titleH = contentRect.size.height - titleY;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}
- (void)dealloc {
    
   // [self.tabBarItem removeObserver:self forKeyPath:@"badgeValue"];
    [self.tabBarItem removeObserver:self forKeyPath:@"title"];
    [self.tabBarItem removeObserver:self forKeyPath:@"image"];
    [self.tabBarItem removeObserver:self forKeyPath:@"selectedImage"];
}

@end
