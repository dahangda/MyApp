//
//  NSString+Base64.h
//  MyApp
//
//  Created by 燕航 on 2017/10/2.
//  Copyright © 2017年 yanhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)
/**
返回base64编码的字符串内容
*/
- (NSString *)base64encode;

/**
 返回base64解码的字符串内容
 */
- (NSString *)base64decode;

/**
 返回服务器基本授权字符串
 
 示例代码格式如下：
 
 @code
 [request setValue:[@"admin:123456" basicAuthString] forHTTPHeaderField:@"Authorization"];
 @endcode
 */
- (NSString *)basicAuthString;

@end
