//
//  UIView+Common.h
//  BlueMobiProject
//
//  Created by 朱 亮亮 on 14-4-28.
//  Copyright (c) 2014年 朱 亮亮. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  UIView 通用Category
 */
@interface UIView (Common)

/**
 *  获取左上角横坐标
 *
 *  @return 坐标值
 */
- (CGFloat)left;

/**
 *  获取左上角纵坐标
 *
 *  @return 坐标值
 */
@property (nonatomic) CGFloat top;

/**
 *  获取视图右下角横坐标
 *
 *  @return 坐标值
 */
- (CGFloat)right;

/**
 *  获取视图右下角纵坐标
 *
 *  @return 坐标值
 */
@property (nonatomic) CGFloat bottom;

/**
 *  获取视图宽度
 *
 *  @return 宽度值（像素）
 */
- (CGFloat)width;

/**
 *  获取视图高度
 *
 *  @return 高度值（像素）
 */
@property (nonatomic) CGFloat height;

/**
 *	@brief	删除所有子对象
 */
- (void)removeAllSubviews;


- (void)addConstraintWithItem:(UIView *)item ToTopMultiplier:(CGFloat)topMut constant:(CGFloat)topCon byTopView:(UIView *)topView;
- (void)addConstraintWithItem:(UIView *)item ToLeftMultiplier:(CGFloat)leftMut constant:(CGFloat)leftCon byLeftView:(UIView *)leftView;
- (void)addConstraintWithItem:(UIView *)item ToBottomMultiplier:(CGFloat)bottomMut constant:(CGFloat)bottomCon byBottomView:(UIView *)bottomView;
- (void)addConstraintWithItem:(UIView *)item ToRightMultiplier:(CGFloat)rightMut constant:(CGFloat)rightCon byRightView:(UIView *)rightView;

/**
 *  得到时间间隔
 */
- (NSString *)getDateIntervalFromData:(NSDate *)paramStartDate endDate:(NSDate*)paramEndDate;
@end
