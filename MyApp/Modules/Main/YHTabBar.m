//  YHTabBar.m
//  MyApp
//
//  Created by 燕航 on 2017/10/9.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#import "YHTabBar.h"
#import "YHTabBarItem.h"
@interface YHTabBar()
/** 被选择的按钮 */
@property(nonatomic,strong) YHTabBarItem * selItem;

/** TabBar图片背景 */
@property(nonatomic,strong) UIImageView * imageView;

@end

@implementation YHTabBar

#pragma mark ********************bar背景图片

- (void)addImageView
{
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.image = [UIImage imageNamed:@"tabbar-light"];
    self.imageView = imgView;
    [self addSubview:imgView];
}


#pragma mark ********************增加baritem

- (void)addTabBarItem:(UITabBarItem *)item
{    YHTabBarItem * tabBarItem= [[YHTabBarItem alloc]initWithItemImageRatio:self.itemImageRatio];
    
    tabBarItem.tabBarItem = item;
     
    [tabBarItem addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:tabBarItem];
}

#pragma mark ********************监听bar的点击

- (void)btnClick:(YHTabBarItem *)btn{
    
    
    // 响应代理方法 实现页面跳转
    if ([self.delegate respondsToSelector:@selector(ChangeSelectIndexFrom:to:)]) {
        [self.delegate ChangeSelectIndexFrom:_selItem.tag to:btn.tag];
    }
    
    // 设置按钮显示状态 并切换选中按钮
    _selItem.enabled = YES;
    _selItem = btn;
    btn.enabled = NO;
}

#pragma mark ********************自动布局

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    UIImageView *imgView = self.subviews[1];
    imgView.frame = self.bounds;
     CGFloat btnY = 0;
     CGFloat btnW = self.width/(self.subviews.count-1);
    YHLog(@"selfCount%d",self.subviews.count);
    YHLog(@"self.width-------%f",(self.width));
    YHLog(@"self.btnW-----%f",btnW);
    
    CGFloat btnH = self.height;
    for (int i = 1; i<self.subviews.count; i++) { // $$$$$
        YHLog(@"%@",self.subviews[i]);
        UIButton *btn = self.subviews[i];
        CGFloat btnX = (i-1) * btnW;
        YHLog(@"self.btnX-----%f",btnX);
        
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        // 绑定tag 便于后面使用
        btn.tag = i-1;
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
