//
//  HZUtil.h
//  CXProject
//
//  Created by ZhangChaoxin on 16/5/4.
//  Copyright © 2016年 ZhangChaoxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZUtil : NSObject

//根据字体和字号和宽度获取高度
+ (CGFloat)getHeightWithString:(NSString *)str fontSize:(CGFloat)fontSize width:(CGFloat)width;
+ (CGFloat)getWidthWithString:(NSString *)str fontSize:(CGFloat)fontSize width:(CGFloat)width;

//获取图片的大小 (单位M)
+ (CGFloat)getImageSizeWithImage:(UIImage *)image;

@end
