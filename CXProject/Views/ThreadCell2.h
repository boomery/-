//
//  ThreadCell2.h
//  CXProject
//
//  Created by ZhangChaoxin on 16/5/7.
//  Copyright © 2016年 ZhangChaoxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreadCell2 : UITableViewCell

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *responseLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *aImageView;

@property (nonatomic, strong) NSLayoutConstraint *aImageViewHeightConstraint;

@property (nonatomic, assign) BOOL isPo;

@property (nonatomic, strong) ThreadModel *model;

+ (CGFloat)heightForThreadModel:(ThreadModel *)model;

@end
