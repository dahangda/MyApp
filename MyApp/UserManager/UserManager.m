//
//  UserManager.m
//  MyApp
//
//  Created by 燕航 on 2017/12/4.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager
SINGLETON_FOR_CLASS(UserManager);

-(instancetype)init{
    self = [super init];
    if (self) {
        //被踢下线
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onKick)
                                                     name:YHNotificationOnKick
                                                   object:nil];
    }
    return self;
}
- (void)onKick{
    
}
@end
