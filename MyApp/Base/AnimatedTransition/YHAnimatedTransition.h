//
//  YHAnimatedTransition.h
//  MyApp
//
//  Created by 燕航 on 2017/11/29.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHAnimatedTransition : NSObject<UIViewControllerAnimatedTransitioning>
/*是push反转是pop
 */
@property (nonatomic,assign) BOOL isPush;
/*转场时间
 */
@property (nonatomic,assign) NSTimeInterval animationDuration;

@end
