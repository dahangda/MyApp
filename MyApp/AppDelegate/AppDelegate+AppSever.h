//
//  AppDelegate+AppSever.h
//  MyApp
//
//  Created by 燕航 on 2017/10/8.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#import "AppDelegate.h"
#import "YHAdPagesView.h"
@interface AppDelegate (AppSever)

- (void)initWindow;

- (void)initNotification;

- (void)initUmeng;

- (void)initUserStatusManager;

- (void)adStart;
/**
 当前顶层控制器
 */
-(UIViewController*) getCurrentVC;

-(UIViewController*) getCurrentUIVC;
//单例
+ (AppDelegate *)shareAppDelegate;
@end
