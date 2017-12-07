//
//  HeaderView.h
//  MyApp
//
//  Created by 燕航 on 2017/11/24.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
/**
 我的页面 头部 view
 */
@protocol headerViewDelegate <NSObject>

-(void)headerViewClick;
-(void)nickNameViewClick;

@end

@interface HeaderView : UIView
@property(nonatomic, strong) YYAnimatedImageView *headImgView; //头像
@property(nonatomic, strong) UserInfo *userInfo;//用户信息
/** 代理 */
@property(nonatomic,assign) id<headerViewDelegate>  delegate;
@end
