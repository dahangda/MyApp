//
//  YHMacro.h
//  MyApp
//
//  Created by 燕航 on 2017/10/2.
//  Copyright © 2017年 yanhang. All rights reserved.
//
#import <Foundation/Foundation.h>
#ifndef YHMacro_h
#define YHMacro_h

#define prefix  YH

//字体
//#define YHFont(x)  [UIFont systemFontOfSize:x]
#pragma mark ********************字体区

#define YHSYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define YHBoldFont(x)  [UIFont boldSystemFontOfSize:x]

#pragma mark ********************颜色区

//颜色
#define YHRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define YHcolor [UIColor blueColor]
#define YHClearColor [UIColor clearColor]
#define YHWhiteColor [UIColor whiteColor]
#define YHRGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

#define YHRGB16Color(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//默认页面背景色
#define DaultViewBgColor [UIColor colorWithHexString:@"f2f2f2"]

#pragma mark ********************导入image
//定义UIImage取出路径
#define ImageWithFile(_pointer) [UIImage imageWithContentsOfFile:([[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%dx", _pointer, (int)[UIScreen mainScreen].nativeScale] ofType:@"png"])]

#pragma mark ********************log区
/**调试阶段打印log
非调试阶段不答应log，对应空的嘛。
 输出*/
#ifdef DEBUG
#define YHLog(...) NSLog(__VA_ARGS__)
#else
#define YHLog(...)
#endif

#pragma mark ********************硬件信息
#define YHScreen_W [UIScreen mainScreen].bounds.size.width
#define YHScreen_H [UIScreen mainScreen].bounds.size.height
#define YHCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
#define YHCurrentSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]

/** 适配*/
#define YHiOS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define YHiOS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define YHiOS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define YHiOS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define YHiOS_9_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define YHiOS_10_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define YHiOS_11_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)

/** 弱指针*/
#define YHWeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;

/** 加载本地文件*/
#define YHLoadImage(file,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]
#define YHLoadArray(file,type) [UIImage arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]
#define YHLoadDict(file,type) [UIImage dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]
/** 多线程GCD*/
#define YHGlobalGCD(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define YHMainGCD(block) dispatch_async(dispatch_get_main_queue(),block)

/** 数据存储*/
#define YHUserDefaults [NSUserDefaults standardUserDefaults]
#define YHCacheDir [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
#define YHDocumentDir [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define YHTempDir NSTemporaryDirectory()


//单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;
/*单粒化一个类
 */
#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}
/*获取系统对象
 */
#define YHApplication        [UIApplication sharedApplication]
#define YHAppWindow          [UIApplication sharedApplication].delegate.window
#define YHAppDelegate        [AppDelegate shareAppDelegate]
#define YHRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define YHUserDefaults       [NSUserDefaults standardUserDefaults]
#define YHNotificationCenter [NSNotificationCenter defaultCenter]
/*app屏幕尺寸
 */
//获取屏幕宽高
#define YHScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define YHScreenHeight [[UIScreen mainScreen] bounds].size.height
//获取屏幕尺寸
#define YHScreen_Bounds [UIScreen mainScreen].bounds
//获取屏幕的状态栏高
#define YHStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//导航栏高度
#define YHNavBarHeight 44.0
// tabbar 高度
#define YHTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
//
#define YHTopHeight (YHStatusBarHeight + YHNavBarHeight)
//缩放计算
#define Iphone6ScaleWidth YHScreenWidth/375.0
#define Iphone6ScaleHeight YHScreenHeight/667.0

//默认间距
#define YHNormalSpace 12.0f
/*常用方法宏
 */
//通知的发送

#define YHPostNotification(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];

/*用户相关的
 */

//登录状态改变通知
#define YHNotificationLoginStatusChange @"YloginStateChange"

//自动登录成功
#define YHNotificationAutoLoginSuccess @"YNotificationAutoLoginSuccess"

//被踢下线
#define YHNotificationOnKick @"YNotificationOnKick"

/*网络状态
 */

//网络状态变化
#define YHNotificationNetWorkStateChange @"YNotificationNetWorkStateChange"

#endif /* YHMacro_h */


