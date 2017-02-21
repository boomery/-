//
//  WXGMenuCell.m
//  SlideMenu
//
//  Created by Nicholas Chow on 15/7/5.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGMenuCell.h"
#import "ListModel.h"

@interface WXGMenuCell ()

@property (nonatomic, weak) UIImageView *menuIcon;
@property (nonatomic, weak) UILabel *menuLabel;

@end

@implementation WXGMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *menuIcon = [[UIImageView alloc] init];
        self.menuIcon = menuIcon;
        [self addSubview:menuIcon];
        
        UILabel *menuLabel = [[UILabel alloc] init];
        menuLabel.textAlignment = 1;
        menuLabel.font = [UIFont systemFontOfSize:10];
        menuLabel.textColor = [UIColor whiteColor];
        self.menuLabel = menuLabel;
        [self addSubview:menuLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.menuIcon.frame = self.bounds;
    self.menuLabel.frame = self.bounds;
}

- (void)setModel:(ListModel *)model {
    _model = model;
    self.menuLabel.text = model.name;
    self.backgroundColor = [UIColor blackColor];
}

@end
