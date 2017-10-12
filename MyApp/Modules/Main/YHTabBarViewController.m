//
//  YHTabBarViewController.m
//  MyApp
//
//  Created by 燕航 on 2017/10/8.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#import "YHTabBarViewController.h"
#import "meViewController.h"
#import "findTableViewController.h"
#import "WebViewController.h"
#import "homeViewController.h"
#import "YHTabBar.h"


@interface YHTabBarViewController ()<YHTabBarDelegate>
/** 存放子控制器的数组 */
//
@property(nonatomic,strong) NSMutableArray * Controllers;
@end

@implementation YHTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabBar];
   
    self.TabBar.delegate = self;
    [self.TabBar addImageView];
    
    [self setupControllers];
    
    // Do any additional setup after loading the view.
}

#pragma mark ********************装载控制器

-(void)setupControllers
{
    _Controllers = [[NSMutableArray alloc]init];
    homeViewController *home = [[homeViewController alloc]init];
    [self  configChildContrller:home tittile:@"首页" tabBarItemImage:(NSString *)@"tabBar_essence_icon" itemSelImage:@"tabBar_essence_click_icon"];
    
    WebViewController *web = [[WebViewController alloc]init];
    [self configChildContrller:(UIViewController *)web tittile: @"发现"tabBarItemImage:@"" itemSelImage:@""];
    
    findTableViewController *find = [[findTableViewController alloc]init];
    [self configChildContrller:find tittile:@"发现" tabBarItemImage:@"" itemSelImage:@""];
    
    meViewController *me = [[meViewController alloc]init];
    [self configChildContrller:me tittile:@"我的" tabBarItemImage:@"" itemSelImage:@""];
    
    self.viewControllers = self.Controllers;
    self.TabBar.itmeCount = _Controllers.count;
    
    
    
}

#pragma mark ********************配置子控制器的tabItem显示

- (void)configChildContrller:(UIViewController *)vc tittile:(NSString *)tittle tabBarItemImage:(NSString *)imageName itemSelImage:(NSString *)selName
{
    vc.tabBarItem.title = tittle;//跟上面一样效果
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.TabBar addTabBarItem:vc.tabBarItem];
    //包装导航控制器
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    vc.title = tittle;
    [_Controllers addObject:nav];
}
#pragma mark ********************装载tabBar

- (void)setupTabBar
{
    
    YHTabBar *tabBar = [[YHTabBar alloc]init];
    tabBar.frame = self.tabBar.bounds;
    tabBar.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _TabBar = tabBar;
    [self.tabBar addSubview:tabBar];
}



- (void)ChangeSelectIndexFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
