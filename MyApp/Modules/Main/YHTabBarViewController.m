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
   
    [self setupControllers];
    [self configTabBar];
    // Do any additional setup after loading the view.
}



-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
       [self removeOriginControls];
}



#pragma mark ————— 取出系统自带的tabbar并把里面的按钮删除掉 —————
- (void)removeOriginControls {
    
    [self.tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * obj, NSUInteger idx, BOOL * stop) {
        
        if ([obj isKindOfClass:[UIControl class]]) {
            
            [obj removeFromSuperview];
        }
    }];
}




#pragma mark ********************配置自定义tabbar
- (void)configTabBar{
    self.TabBar.itmeCount = _Controllers.count;
    
    [self.Controllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIViewController *VC = (UIViewController *)obj;
        
       UIImage *selectedImage = VC.tabBarItem.selectedImage;
        VC.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        
        [self.TabBar addTabBarItem:VC.tabBarItem];
        YHLog(@"%id",VC.tabBarItem);
    }];
    
}



#pragma mark ********************装载控制器

-(void)setupControllers
{
    _Controllers = [[NSMutableArray alloc]init];
    
    homeViewController *home = [[homeViewController alloc]init];
    [self  configChildContrller:home tittile:@"首页" tabBarItemImage:(NSString *)@"tabBar_essence_click_icon" itemSelImage:@"tabBar_essence_icon"];
    
    WebViewController *web = [[WebViewController alloc]init];
    [self configChildContrller:(UIViewController *)web tittile: @"灵感"tabBarItemImage:@"tabbar_icon_found_normal" itemSelImage:@"tabbar_icon_found_highlight"];
    
    findTableViewController *find = [[findTableViewController alloc]init];
    [self configChildContrller:find tittile:@"发现" tabBarItemImage:@"tabBar_new_icon" itemSelImage:@"tabBar_new_click_icon"];
    
    meViewController *me = [[meViewController alloc]init];
    [self configChildContrller:me tittile:@"我的" tabBarItemImage:@"tabbar_icon_me_normal" itemSelImage:@"tabbar_icon_me_highlight"];
    
   // self.viewControllers = self.Controllers;
    
  
    
    
    
}

#pragma mark ********************配置子控制器的tabItem显示

- (void)configChildContrller:(UIViewController *)vc tittile:(NSString *)tittle tabBarItemImage:(NSString *)imageName itemSelImage:(NSString *)selName
{
    vc.tabBarItem.title = tittle;//跟上面一样效果
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
   UIImage *selimage =  [[UIImage imageNamed:selName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = selimage;
    [_Controllers addObject:vc];
    //包装导航控制器
    vc.title = tittle;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    
    [self addChildViewController:nav];
}




#pragma mark ********************装载tabBar

- (void)setupTabBar
{
    
    YHTabBar *YHtabBar = [[YHTabBar alloc]init];
    YHtabBar.frame = self.tabBar.bounds;
    YHtabBar.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    [YHtabBar addImageView];
    YHtabBar.delegate = self;
    _TabBar = YHtabBar;
    self.TabBar.itemImageRatio = 0.7;
    self.TabBar.itemTitleFont          = YHFont(10);
    self.TabBar.itemTitleColor         = YHRGBColor(42, 42, 55);
    self.TabBar.selectedItemTitleColor =YHRGBColor(244, 0, 0);
    [self.tabBar addSubview:YHtabBar];
    
   
}


- (void)ChangeSelectIndexFrom:(NSInteger)from to:(NSInteger)to

{
    //YHTabBarItem *selectItem = self.TabBar.items[to-1];
    //selectItem.enabled = NO;
    self.selectedIndex = to-1;
    
    
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
