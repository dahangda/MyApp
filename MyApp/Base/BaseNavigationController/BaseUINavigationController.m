//
//  BaseUINavigationController.m
//  MyApp
//
//  Created by 燕航 on 2017/11/25.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#import "BaseUINavigationController.h"
#import "YHAnimatedTransition.h"
#import "YHTransitonProtocol.h"
@interface
BaseUINavigationController()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
/** 交互转场管理 **/
@property(nonatomic,strong) UIPercentDrivenInteractiveTransition * interactivePopTransition;
/** 手势 **/
@property(nonatomic,strong) UIScreenEdgePanGestureRecognizer * popRecognizer;
/** 是否开启pan手势返回 **/
@property(nonatomic,assign) BOOL isSystemSlidBack;
@end

@implementation BaseUINavigationController
- (UIPanGestureRecognizer *)popRecognizer
{   if(!_popRecognizer){
    //下面是全屏返回
    //        _popRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
    //边沿手势
    _popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
    _popRecognizer.edges = UIRectEdgeLeft;
  // 默认此手势禁止不开启
    [_popRecognizer setEnabled:NO];
}
    return _popRecognizer;
}


//APP生命周期中 只会执行一次
+ (void)initialize
{
    //导航栏主题 title文字属性
    UINavigationBar *navBar = [UINavigationBar appearance];
    //导航栏背景图
    //    [navBar setBackgroundImage:[UIImage imageNamed:@"tabBarBj"] forBarMetrics:UIBarMetricsDefault];
    //[navBar setBarTintColor:CNavBgColor];
    //[navBar setTintColor:CNavBgFontColor];
    //[navBar setTitleTextAttributes:@{NSForegroundColorAttributeName :CNavBgFontColor, NSFontAttributeName : [UIFont systemFontOfSize:18]}];
    
    //[navBar setBackgroundImage:[UIImage imageWithColor:CNavBgColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //[navBar setShadowImage:[UIImage new]];//去掉阴影线
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    
    //默认开启系统右划返回
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = self;
    
    [self.view addGestureRecognizer:self.popRecognizer];
}

#pragma mark ********************代理方法（UINavigationControllerDelegate）隐藏导航条问题
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ([viewController isKindOfClass:[BaseViewController class]]) {
        BaseViewController * vc = (BaseViewController *)viewController;
        if (vc.isHidenNaviBar) {
            [vc.navigationController setNavigationBarHidden:YES animated:animated];
        }else{
            [vc.navigationController setNavigationBarHidden:NO animated:animated];
        }
    }
    
}
#pragma mark ********************代理方法（UINavigationControllerDelegate）解决手势问题
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (_isSystemSlidBack) {
        self.interactivePopGestureRecognizer.enabled = YES;
        [_popRecognizer setEnabled:NO];
    }else{
         //只有在使用转场动画时，禁用系统手势，开启自定义右划手势
        self.interactivePopGestureRecognizer.enabled = NO;
        [_popRecognizer setEnabled:YES];
    }
}

#pragma mark ********************重写push方法隐藏tabbar

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        if ([viewController conformsToProtocol:@protocol(YHTransitonProtocol)] && [self isNeedTransition:viewController]) {
            viewController.hidesBottomBarWhenPushed = NO;
        }else{
            viewController.hidesBottomBarWhenPushed = YES;
        }
        
    }
    [super pushViewController:viewController animated:animated];
    // 修改tabBra的frame
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}


//判断VC是否需要实现Pinterest效果
-(BOOL)isNeedTransition:(UIViewController<YHTransitonProtocol> *)VC
{
    BOOL b = NO;
    if ([VC respondsToSelector:@selector(isNeedTransition)] && [VC isNeedTrantion]) {
        b = YES;
    }
    return b;
    
}

#pragma mark ********************返回指定的controller
-(BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated
{
    id vc = [self getViewControllerClass:ClassName];
    if(vc != nil && [vc isKindOfClass:[UIViewController class]])
    {
        [self popToViewController:vc animated:animated];
        return YES;
    }
    
    return NO;
}

/*!
 *  获得当前导航器要pop显示的视图
 *
 *  @param ClassName 要获取的视图的名称
 *
 *  @return 成功返回对应的对象，失败返回nil;
 */
-(instancetype)getViewControllerClass:(NSString *)ClassName
{
    Class classObj = NSClassFromString(ClassName);
    
    NSArray * szArray =  self.viewControllers;
    for (id vc in szArray) {
        if([vc isMemberOfClass:classObj])
        {
            return vc;
        }
    }
    return nil;
}

-(UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}
#pragma mark ————— 转场动画区 —————
//navigation切换是会走这个代理
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController<YHTransitonProtocol> *)fromVC toViewController:(UIViewController<YHTransitonProtocol> *)toVC
{
    NSLog(@"转场动画代理方法");
    self.isSystemSlidBack = YES;
    //如果来源VC和目标VC都实现协议，那么都做动画
    if ([fromVC conformsToProtocol:@protocol(YHTransitonProtocol)] && [toVC conformsToProtocol:@protocol(YHTransitonProtocol)]) {
        
        BOOL pinterestNedd = [self isNeedTransition:fromVC:toVC];
        YHAnimatedTransition *transion = [YHAnimatedTransition new];
        if (operation == UINavigationControllerOperationPush && pinterestNedd) {
            transion.isPush = YES;
            
            //暂时屏蔽带动画的右划返回
            self.isSystemSlidBack = NO;
            //            self.isSystemSlidBack = YES;
        }
        else if(operation == UINavigationControllerOperationPop && pinterestNedd)
          {
            //暂时屏蔽带动画的右划返回
            //            return nil;
            
            transion.isPush = NO;
            self.isSystemSlidBack = NO;
          }
        
        
    else{
            return nil;
        }
        
        return transion;
    }else if([toVC conformsToProtocol:@protocol(YHTransitonProtocol)]){
        //如果只有目标VC开启动画，那么isSystemSlidBack也要随之改变
        BOOL pinterestNedd = [self isNeedTransition:toVC];
        self.isSystemSlidBack = !pinterestNedd;
        return nil;
    }
    return nil;
}
//判断fromVC和toVC是否需要实现pinterest效果
-(BOOL)isNeedTransition:(UIViewController<YHTransitonProtocol> *)fromVC :(UIViewController<YHTransitonProtocol> *)toVC
{
    BOOL a = NO;
    BOOL b = NO;
//    if ([fromVC respondsToSelector:@selector(isNeedTransition)] && [fromVC isNeedTransition]) {
//        a = YES;
//    }
//    if ([toVC respondsToSelector:@selector(isNeedTransition)] && [toVC isNeedTransition]) {
//        b = YES;
//    }
    return (a && b) ;
    
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if (!self.interactivePopTransition)
    { return nil;
        
    }
    return self.interactivePopTransition;
}
- (void)handleNavigationTransition:(UIScreenEdgePanGestureRecognizer*)recognizer
{
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width);
    //    progress = MIN(1.0, MAX(0.0, progress));
    NSLog(@"右划progress %.2f",progress);
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        CGPoint velocity = [recognizer velocityInView:recognizer.view];
        
        if (progress > 0.5 || velocity.x >100) {
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        self.interactivePopTransition = nil;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
