//
//  YHAnimatedTransition.m
//  MyApp
//
//  Created by 燕航 on 2017/11/29.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#import "YHAnimatedTransition.h"
#import "YHTransitonProtocol.h"
@interface YHAnimatedTransition()
@property (nonatomic,assign) float animationScale;//缩放比例
@end

@implementation YHAnimatedTransition
- (instancetype)init
{
   self =  [super init];
   // if (self) {
    //    self.animationDuration = 0.3;
    //}
    return self ;
}
- (NSTimeInterval)animationDuration
{
    if (_animationDuration ) {
        _animationDuration = 0.3;
    }
    return _animationDuration;
}

#pragma mark ********************UIViewControllerAnimatedTransitioning代理方法

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext;
{
    return self.animationDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;
{
    if (_isPush) {
       [self pushAnimatedTransiton:transitionContext];
    }
    else
    {
        [self popAnimatedTransiton:transitionContext];
}
    
}
#pragma mark ********************pop与push主要的动画过程，场景内容

- (void)pushAnimatedTransiton:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //获取容器view
    UIView *containerView = [transitionContext containerView];
    //获取来源控制器（转场的开始的控制器）
    UIViewController<YHTransitonProtocol> *fromViewController =(UIViewController <YHTransitonProtocol>*)[transitionContext viewForKey:UITransitionContextFromViewKey];
    //获取目的控制器
    UIViewController<YHTransitonProtocol> *toViewController = (UIViewController <YHTransitonProtocol>*)[transitionContext viewForKey:UITransitionContextToViewKey];
    
    //获取两个控制器的view
    UIView *fromView = fromViewController.view;
    UIView *toView = toViewController.view;
    //转场动画的目标View
    UIView *fromCellView = [fromViewController targetTrantionView];
    UIView *toCellView = [toViewController targetTrantionView];
    //获取cell相对左上角坐标 计算相对坐标
    CGPoint fromViewPoint = [fromCellView convertPoint:CGPointZero toView:nil];
    
    //获取当前view相对窗口坐标
    CGPoint toViewPoint = [toCellView convertPoint:CGPointZero toView:nil];
    //toView.hidden = YES;
    
    //复制一个Cell用于显示动画效果
    __block UIImageView * snapShot =[[UIImageView alloc] initWithImage:[fromCellView snapshotImage]];
    snapShot.backgroundColor = [UIColor clearColor];
    [containerView addSubview:snapShot];
    
    [snapShot setOrigin:fromViewPoint];
    
    //计算缩放比例
    _animationScale = MAX([toViewController targetTrantionView].width, snapShot.width) / MIN([toViewController targetTrantionView].width, snapShot.width);
    CGRect originFrame = fromView.frame;
    [UIView animateWithDuration:self.animationDuration animations:^{
        //设置缩放变换 x,y分别放大多少倍
        snapShot.transform =  CGAffineTransformMakeScale(_animationScale,_animationScale);
        [snapShot setOrigin:toViewPoint];
        
        fromView.alpha = 0;
        fromView.transform = snapShot.transform;
                fromView.frame = CGRectMake(-(fromViewPoint.x)*_animationScale,
                                            -(fromViewPoint.y)*_animationScale + toViewPoint.y,
                                            fromViewController.view.frame.size.width,
                                            fromViewController.view.frame.size.height);
        YHAppDelegate.mainTabBarController.tabBar.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            //没有这句过滤动画就不会结束
            [snapShot removeFromSuperview];
            toView.hidden = NO;
            fromView.alpha = 1;
            fromViewController.view.transform = CGAffineTransformIdentity;
            fromViewController.view.frame = originFrame;
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }
    }];
}

- (void)popAnimatedTransiton:(id <UIViewControllerContextTransitioning>)transitionContext
{
    
}

  
@end
