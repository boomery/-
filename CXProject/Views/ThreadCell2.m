//
//  ThreadCell2.m
//  CXProject
//
//  Created by ZhangChaoxin on 16/5/7.
//  Copyright © 2016年 ZhangChaoxin. All rights reserved.
//

#import "ThreadCell2.h"
#import "ThreadModel.h"
#import "HZShowImageView.h"

@implementation ThreadCell2
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //uid
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 20)];
        [self addSubview:nameLabel];
        nameLabel.font = [UIFont systemFontOfSize:13.5];
        _nameLabel = nameLabel;
        
        //时间
        UILabel *timeLabel = [[UILabel alloc] initForAutoLayout];
        [self addSubview:timeLabel];
        timeLabel.font = [UIFont systemFontOfSize:13.5];
        [timeLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:nameLabel withOffset:13];
        [timeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:nameLabel withOffset:0];
        [timeLabel autoSetDimension:ALDimensionHeight toSize:20];
        _timeLabel = timeLabel;
        
        //回复数
        UILabel *responseLabel = [[UILabel alloc] initForAutoLayout];
        [self addSubview:responseLabel];
        responseLabel.textAlignment = 2;
        responseLabel.font = [UIFont systemFontOfSize:13.5];
        [responseLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:-5];
        [responseLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:nameLabel withOffset:0];
        [responseLabel autoSetDimension:ALDimensionHeight toSize:20];
        [responseLabel autoSetDimension:ALDimensionWidth toSize:120];
        _responseLabel = responseLabel;
        
        //图片  高度100
        UIImageView *imageView = [[UIImageView alloc] initForAutoLayout];
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        imageView.backgroundColor = [UIColor whiteColor];
        [imageView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self withOffset:-5];
        [imageView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:5];
        [imageView autoSetDimension:ALDimensionWidth toSize:100];
        _aImageViewHeightConstraint = [imageView autoSetDimension:ALDimensionHeight toSize:0];
        
        //为imageView添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tap.numberOfTapsRequired = 1;
        [imageView addGestureRecognizer:tap];
        
        _aImageView = imageView;
        
        UILabel *contentLabel = [[UILabel alloc] initForAutoLayout];
        [self addSubview:contentLabel];
        contentLabel.numberOfLines = 0;
        contentLabel.font = [UIFont systemFontOfSize:13.5];
        [contentLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:5];
        [contentLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:-5];
        [contentLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:nameLabel withOffset:5];
        [contentLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:imageView withOffset:-5];
        _contentLabel = contentLabel;
    }
    return self;
}

- (void)tap:(UITapGestureRecognizer *)recognizer
{
    HZShowImageView *showImageView = [[HZShowImageView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT) withImageArray:@[PATH(_model.image)] clickIndex:0];
    [showImageView show];
}

- (void)setModel:(ThreadModel *)model
{
    _model = model;
    NSRange range = [model.uid rangeOfString:@"管理"];
    if (range.location != NSNotFound || self.isPo)
    {
        _nameLabel.textColor = [UIColor redColor];
    }
    else
    {
        _nameLabel.textColor = [UIColor blackColor];
    }
    _nameLabel.text = model.uid;
    _timeLabel.text = model.dateString;
    _responseLabel.text = [NSString stringWithFormat:@"No:%ld",(long)[model.theID integerValue]];
    _contentLabel.text = model.content;
    [_aImageView setImageWithURL:[NSURL URLWithString:PATH(model.thumb)] placeholderImage:[UIImage imageNamed:@"placeHolder.jpg"]];
    if (model.thumb.length == 0)
    {
        _aImageViewHeightConstraint.constant = 0;
    }
    else
    {
        _aImageViewHeightConstraint.constant = 100;
    }
}

+ (CGFloat)heightForThreadModel:(ThreadModel *)model
{
    if (model.thumb.length == 0)
    {
        return model.contentHeight + 50;
    }
    return model.contentHeight + 105 + 50;
}
@end
