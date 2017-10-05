//
//  ViewController.m
//  MyApp
//
//  Created by 燕航 on 2017/10/1.
//  Copyright © 2017年 yanhang. All rights reserved.
////颜色

#import "ViewController.h"

@interface ViewController ()
/** adImageView */
//
@property(nonatomic,strong) YHAdPagesView *adImageView;

@end

@implementation ViewController

- (void)viewDidLoad {

    
    YHAdPagesView *adImageView = [[YHAdPagesView alloc]initWithFrame:YHAppWindow.bounds andTap:nil];
    _adImageView = adImageView;
//     YHLog(@"---%@----",adImageView);
//    adImageView.backgroundColor = [UIColor colorWithRed:1/255 green:200/255 blue:255/255 alpha:1];
    [self.view addSubview:adImageView];
    YHLog(@"%@",adImageView);
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
