//
//  AppDelegate+AppSever.m
//  MyApp
//
//  Created by 燕航 on 2017/10/8.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#import "AppDelegate+AppSever.h"
#import "YHTabBarViewController.h"
@implementation AppDelegate (AppSever)


#pragma mark ********************初始化窗口
- (void)initWindow
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = YHRGBColor(236, 0, 152);
    
    
    [self.window makeKeyAndVisible];
    [[UIButton appearance] setExclusiveTouch:YES];
    [UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:[NSArray arrayWithObjects:[MBProgressHUD class], nil]].color = YHcolor;

}

#pragma mark ********************添加通知

- (void)initNotification
{
    [YHNotificationCenter addObserver:self selector:@selector(loginStatusChange:) name:YHNotificationLoginStatusChange object:nil];
    [YHNotificationCenter addObserver:self selector:@selector(netWorkStatusChange:) name:YHNotificationNetWorkStateChange object:nil];
    
}

- (void)loginStatusChange:(NSNotification *)notification
{
    
    if (1) {
        
        
    }
    else
    {
    }
}

- (void)networkStatusChange:(NSNotification *)notification
{
    
}

#pragma mark ********************友盟配置

- (void)initUmeng
{
    
}

#pragma mark ********************用户启动页面显示控制

- (void)initUserStatusManager{
    /*判断用户是否有过登录（用户个人信息里面），有的话直接跳转到登录主控制器，没有的话跳转到登录控制器(通过通知)
     */
    YHTabBarViewController *vc = [YHTabBarViewController new];
    self.mainTabBarController = vc;
   vc.view.backgroundColor = YHcolor;
    self.window.rootViewController = vc;
    
    
}

#pragma mark ********************广告显示
- (void)adStart{
    YHAdPagesView *adview = [[YHAdPagesView alloc] initWithFrame:YHAppWindow.bounds andTap:nil];
    [self.window addSubview:adview];
    
}

+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
@end
