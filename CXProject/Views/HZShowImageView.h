//
//  HZShowImageView.h
//  MHProject
//
//  Created by 张好志 on 15/7/4.
//  Copyright (c) 2015年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZShowImageView : UIView

@property (nonatomic, assign) CGRect sourceFrame;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UILabel *pageLabel;
@property (nonatomic, strong) NSArray *imageArray;

//数组内需要  image对象或者url字符串
- (id)initWithFrame:(CGRect)frame withImageArray:(NSMutableArray *)array clickIndex:(NSInteger)index;
-(void)hidden;
-(void)show;



@end
