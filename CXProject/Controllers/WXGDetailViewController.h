//
//  WXGDetailViewController.h
//  WXGSlideMenuDemo
//
//  Created by Nicholas Chow on 15/7/6.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListModel;

@interface WXGDetailViewController : UIViewController

@property (nonatomic, strong) ListModel *model;

/**
 * 注册顶部按钮的点击事件
 */
@property (nonatomic, copy) void(^leftBarButtonDidClick)();

/**
 * 实现顶部按钮的滚动效果
 */
- (void)rotateLeftBarButtonWithScale:(CGFloat)scale;

@end
