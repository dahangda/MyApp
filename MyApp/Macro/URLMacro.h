//
//  URLMacro.h
//  MyApp
//
//  Created by 燕航 on 2017/10/3.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#ifndef URLMacro_h
#define URLMacro_h
#define DevelopSever    1
#define TestSever       0
#define ProductSever    0

#if DevelopSever

/**开发服务器*/
#define URL_main @"http://www.baidu.com"


#elif TestSever

/**测试服务器*/
#define URL_main @"http://www.baidu.com"

#elif ProductSever

/**生产服务器*/
#define URL_main @"http://www.baidu.com"
#endif



#pragma mark - ——————— 详细接口地址 ————————

//测试接口
//NSString *const URL_Test = @"api/recharge/price/list";
#define URL_Test @"/api/cast/home/start"


#pragma mark - ——————— 用户相关 ————————
//自动登录
#define URL_user_auto_login @"/api/autoLogin"
//登录
#define URL_user_login @"/api/login"
//用户详情
#define URL_user_info_detail @"/api/user/info/detail"
//修改头像
#define URL_user_info_change_photo @"/api/user/info/changephoto"
//注释
#define URL_user_info_change @"/api/user/info/change"


#endif /* URLMacro_h */
