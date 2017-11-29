//
//  AppDelegate.h
//  MyApp
//
//  Created by 燕航 on 2017/10/1.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHTabBarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/** 主要控制器 **/
@property(nonatomic,strong) YHTabBarViewController * mainTabBarController;

@end

