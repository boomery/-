//
//  HZUtil.m
//  CXProject
//
//  Created by ZhangChaoxin on 16/5/4.
//  Copyright © 2016年 ZhangChaoxin. All rights reserved.
//

#import "HZUtil.h"

@implementation HZUtil

+ (CGFloat)getHeightWithString:(NSString *)str fontSize:(CGFloat)fontSize width:(CGFloat)width
{
    NSString *detailStr = str;
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGSize ziTiSize = [detailStr boundingRectWithSize:CGSizeMake(width , 3000)options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    float height = ziTiSize.height;
    
    return height;
}

+ (CGFloat)getWidthWithString:(NSString *)str fontSize:(CGFloat)fontSize width:(CGFloat)width
{
    NSString *detailStr = str;
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGSize ziTiSize = [detailStr boundingRectWithSize:CGSizeMake(width , 3000)options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    float wid = ziTiSize.width;
    
    return wid;
}
//获取图片的大小 (单位M)
+ (CGFloat)getImageSizeWithImage:(UIImage *)image
{
    NSData *imgData = UIImageJPEGRepresentation(image,1.0);
    float length = imgData.length;
    
    float folderSize = 0.0;
    folderSize =length/(1024.0*1024.0);
    
    return folderSize;
}

@end
