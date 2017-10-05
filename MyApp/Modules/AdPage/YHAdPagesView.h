//
//  YHAdPagesView.h
//  MyApp
//
//  Created by 燕航 on 2017/10/4.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TapBlock)(void);
@interface YHAdPagesView : UIView
- (instancetype)initWithFrame:(CGRect)frame andTap:(TapBlock)block;


@end
