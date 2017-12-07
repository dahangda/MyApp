//
//  BaseViewController.h
//  MyApp
//
//  Created by 燕航 on 2017/11/24.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
/**
 *  修改状态栏颜色
 */
@property (nonatomic, assign) UIStatusBarStyle StatusBarStyle;


@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UICollectionView * collectionView;
/**
 是否隐藏导航栏
 */
@property (nonatomic, assign) BOOL isHidenNaviBar;
/*是否显示返回按钮
 */
@property (nonatomic,assign) BOOL isShowLiftBack;

@end
