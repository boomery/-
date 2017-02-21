//
//  NSString+UrlEncode.h
//  CXProject
//
//  Created by ZhangChaoxin on 16/5/6.
//  Copyright © 2016年 ZhangChaoxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UrlEncode)

- (NSString *)encodedString:(NSString *)string;

- (NSString *)filterHTML:(NSString *)html;

@end
