//
//  MeViewController.m
//  MyApp
//
//  Created by 燕航 on 2017/11/24.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#import "MeViewController.h"
#import "MeTableViewCell.h"
#import "HeaderView.h"
#import "ProfileViewController.h"
#import "SetingViewController.h"
#import "UserManager.h"

//#define  YHHeaderHeight   (260*Iphone6ScaleWidth+YHStatusBarHeight)
//#define isLogin [UserManager sharedUserManager].isLogined
//#define curUser [UserManager sharedUserManager].curUserInfo
//#define userManager [UserManager sharedUserManager]

@interface MeViewController()<UITableViewDelegate,UITableViewDataSource,headerViewDelegate>
/** 导航视图**/
@property(nonatomic,strong) UIView * navView;
/** 头视图 **/
@property(nonatomic,strong) HeaderView * headerView;
/** 数据源 **/
@property(nonatomic,strong) NSArray * dataSource;
//{
//    NSArray *dataSource;
//   // UIView *navView;
//    //HeaderView *headerView;
//}
@end

@implementation MeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.isHidenNaviBar = YES;
    self.StatusBarStyle = UIStatusBarStyleLightContent;
    self.isShowLiftBack = NO;//每个根视图需要设置该属性为NO，否则会出现导航栏异常
    
     [self addUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getRequset];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //    self.navigationController.delegate = self.navigationController;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    [self ysl_removeTransitionDelegate];
}
-(BOOL)isNeedTransition{
    return YES;
}
#pragma mark ————— 拉取数据 —————
- (void)getRequset
{
   
_headerView.userInfo = curUser;

}
#pragma mark ***********************headerViewDelegate
-(void)headerViewClick{
    //    [self ysl_addTransitionDelegate:self];
    ProfileViewController *profileVC = [ProfileViewController new];
    profileVC.headerImage = _headerView.headImgView.image;
    [self.navigationController pushViewController:profileVC animated:YES];
}


-(void)nickNameViewClick{
    [self.navigationController pushViewController:[BaseViewController new] animated:YES];
}

#pragma mark ********************UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeTableViewCell" forIndexPath:indexPath];
    cell.cellData = _dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            NSLog(@"点击了 我的钱包");
            break;
        case 1:
            NSLog(@"点击了 我的任务");
            break;
        case 2:
            NSLog(@"点击了 我的好友");
            break;
        case 3:
            NSLog(@"点击了 我的等级");
            break;
        default:
            break;
    }
}

#pragma mark ********************SCroView代理

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y ;
    CGFloat totalOffsetY = scrollView.contentInset.top + offset;
    
    NSLog(@"offset    %.f   totalOffsetY %.f",offset,totalOffsetY);
    //    if (totalOffsetY < 0) {
    _headerView.frame = CGRectMake(0, offset, self.view.width, YHHeaderHeight- totalOffsetY);
    //    }
    
}

#pragma mark ********************创建页面addUI

-(void)addUI{
    
    [self createNav];
    _headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, -YHHeaderHeight, YHScreenWidth, YHHeaderHeight)];
    _headerView.delegate = self;
    
    self.tableView.height = YHScreenHeight - YHTabBarHeight;
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    [self.tableView registerClass:[MeTableViewCell class] forCellReuseIdentifier:@"MeTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, -YHHeaderHeight, YHScreenWidth, YHHeaderHeight)];
    _headerView.delegate = self;
    
    self.tableView.contentInset = UIEdgeInsetsMake(_headerView.height, 0, 0, 0);
    [self.tableView addSubview:_headerView];
    [self.view addSubview:self.tableView];
    
  
    
    NSDictionary *myWallet = @{@"titleText":@"我的钱包",@"clickSelector":@"",@"title_icon":@"qianb",@"detailText":@"10.00",@"arrow_icon":@"arrow_icon"};
    NSDictionary *myMission = @{@"titleText":@"我的任务",@"clickSelector":@"",@"title_icon":@"renw",@"arrow_icon":@"arrow_icon"};
    NSDictionary *myFriends = @{@"titleText":@"我的好友",@"clickSelector":@"",@"title_icon":@"haoy",@"arrow_icon":@"arrow_icon"};
    NSDictionary *myLevel = @{@"titleText":@"我的等级",@"clickSelector":@"",@"title_icon":@"dengji",@"detailText":@"LV10",@"arrow_icon":@"arrow_icon"};
    
    _dataSource = @[myWallet,myMission,myFriends,myLevel];
    [self.tableView reloadData];
}

#pragma mark ********************创建导航器createNav

-(void)createNav{
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YHScreenWidth, YHTopHeight)];
    _navView.backgroundColor = YHClearColor;
    
    UILabel * titlelbl = [[UILabel alloc] initWithFrame:CGRectMake(0, YHStatusBarHeight, YHScreenWidth/2, YHNavBarHeight )];
    titlelbl.centerX = _navView.width/2;
    titlelbl.textAlignment = NSTextAlignmentCenter;
    titlelbl.font= YHSYSTEMFONT(17);
    titlelbl.textColor = YHWhiteColor;
    titlelbl.text = self.title;
    [_navView addSubview:titlelbl];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"设置" forState:UIControlStateNormal];
    btn.titleLabel.font = YHSYSTEMFONT(16);
    [btn setTitleColor:YHWhiteColor forState:UIControlStateNormal];
    [btn sizeToFit];
    btn.frame = CGRectMake(_navView.width - btn.width - 15, YHStatusBarHeight, btn.width, 40);
    [btn setTitleColor:YHWhiteColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeSetting) forControlEvents:UIControlEventTouchUpInside];
    
    [_navView addSubview:btn];
    
    [self.view addSubview:_navView];
}

- (void)changeSetting{
    
    SetingViewController *settingVC = [SetingViewController new];
    [self.navigationController pushViewController:settingVC animated:YES];
}
@end
