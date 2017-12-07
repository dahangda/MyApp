//
//  UserManager.h
//  MyApp
//
//  Created by 燕航 on 2017/12/4.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

#define  YHHeaderHeight   (260*Iphone6ScaleWidth+YHStatusBarHeight)
#define isLogin [UserManager sharedUserManager].isLogined
#define curUser [UserManager sharedUserManager].curUserInfo
#define userManager [UserManager sharedUserManager]
typedef NS_ENUM(NSInteger, UserLoginType){
    kUserLoginTypeUnKnow = 0,//未知
    kUserLoginTypeWeChat,//微信登录
    kUserLoginTypeQQ,///QQ登录
    kUserLoginTypePwd,///账号登录
};

@interface UserManager : NSObject

@property (nonatomic, strong) UserInfo *curUserInfo;////当前用户
@property (nonatomic, assign) UserLoginType loginType;
@property (nonatomic, assign) BOOL isLogined;
SINGLETON_FOR_HEADER(UserManager);

@end
