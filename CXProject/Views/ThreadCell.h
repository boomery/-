//
//  DetailCell.h
//  CXProject
//
//  Created by ZhangChaoxin on 16/5/6.
//  Copyright © 2016年 ZhangChaoxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ThreadModel;
@interface ThreadCell : UITableViewCell

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *responseLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *aImageView;

@property (nonatomic, strong) NSLayoutConstraint *aImageViewHeightConstraint;


@property (nonatomic, strong) ThreadModel *model;

+ (CGFloat)heightForThreadModel:(ThreadModel *)model;
@end
