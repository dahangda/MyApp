//  YHTabBar.m
//  MyApp
//
//  Created by 燕航 on 2017/10/9.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#import "YHTabBar.h"
@interface YHTabBar()

/** TabBar图片背景 */
@property(nonatomic,strong) UIImageView * imageView;
/** 被选择的按钮 */
@property(nonatomic,strong) YHTabBarItem * selItem;
/** 存放items **/
@property(nonatomic,strong) NSMutableArray * items;

@end

@implementation YHTabBar

- (NSMutableArray*)items{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

#pragma mark ********************bar背景图片

- (void)addImageView
{
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.image = [UIImage imageNamed:@"tabbar-light"];
    
    self.imageView = imgView;
    imgView.frame = self.bounds;
    [self addSubview:imgView];
}


#pragma mark ********************增加baritem

- (void)addTabBarItem:(UITabBarItem *)item
{    YHTabBarItem * tabBarItem= [[YHTabBarItem alloc]initWithItemImageRatio:self.itemImageRatio];
    tabBarItem.itemTitleFont          = self.itemTitleFont;
    tabBarItem.itemTitleColor         = self.itemTitleColor;
    tabBarItem.selectedItemTitleColor = self.selectedItemTitleColor;
    tabBarItem.tabBarItem = item;
     
    [tabBarItem addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:tabBarItem];
    [self.items addObject:tabBarItem];
    
    // 让第一个按钮默认为选中状态
    if (self.items.count == 1) {
        tabBarItem.tag = 1;
        [self btnClick:tabBarItem];
    }
    
    else
        tabBarItem.tag = self.items.count;
}

#pragma mark ********************监听bar的点击

- (void)btnClick:(YHTabBarItem *)btn{
    

    // 响应代理方法 实现页面跳转
    if ([self.delegate respondsToSelector:@selector(ChangeSelectIndexFrom:to:)]) {
        [self.delegate ChangeSelectIndexFrom:_selItem.tag to:btn.tag];
    }
    
    // 设置按钮显示状态 并切换选中按钮
    _selItem.enabled = YES;
    _selItem.selected =NO;
    self.selItem = btn;
    btn.enabled = NO;
    btn.selected = YES;
  

}

#pragma mark ********************自动布局

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
     CGFloat btnY = 0;
     CGFloat btnW = self.width/(self.items.count);
    CGFloat btnH = self.height;
    
    for (int i = 0; i<self.items.count; i++) {
        UIButton *btn = self.items[i];
        CGFloat btnX = i * btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
