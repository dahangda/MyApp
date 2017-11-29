//
//  YHTransitonProtocol.h
//  MyApp
//
//  Created by 燕航 on 2017/11/29.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YHTransitonProtocol <NSObject>
@optional

- (UIView *)targetTrantionView;
- (BOOL)isNeedTrantion;
@end
