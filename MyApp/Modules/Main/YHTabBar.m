//
//  YHTabBar.m
//  MyApp
//
//  Created by 燕航 on 2017/10/9.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#import "YHTabBar.h"
#import "YHTabBarButton.h"
@interface YHTabBar()
/** 被选择的按钮 */
//
@property(nonatomic,strong) YHTabBarButton * selButton;
/** TabBar图片背景 */
//
@property(nonatomic,strong) UIImageView * imageView;

@end

@implementation YHTabBar
- (void)addImageView
{
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.image = [UIImage imageNamed:@"tabbar-light"];
    self.imageView = imgView;
    [self addSubview:imgView];
}




- (void)btnClick:(YHTabBarButton *)btn{
    
    
    // 响应代理方法 实现页面跳转
    if ([self.delegate respondsToSelector:@selector(ChangeSelectIndexFrom:to:)]) {
        [self.delegate ChangeSelectIndexFrom:_selButton.tag to:btn.tag];
    }
    
    // 设置按钮显示状态 并切换选中按钮
    _selButton.enabled = YES;
    _selButton = btn;
    btn.enabled = NO;
}


- (void)layoutSubviews
{
    UIImageView *imgView = self.subviews[0];
    imgView.frame = self.bounds;
    
    for (int i = 1; i<self.subviews.count; i++) { // $$$$$
        
        UIButton *btn = self.subviews[i];
        
        //        CGFloat btnW = self.frame.size.width/self.subviews.count;
        //        CGFloat btnH = self.frame.size.height;
        CGFloat btnW = [UIScreen mainScreen].bounds.size.width/5;
        CGFloat btnH = 49;
        CGFloat btnX = (i-1) * btnW;
        CGFloat btnY = 0;
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
