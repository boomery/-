//
//  WXGMenuViewController.m
//  WXGSlideMenuDemo
//
//  Created by Nicholas Chow on 15/7/6.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGMenuViewController.h"
#import "WXGMenuCell.h"

@interface WXGMenuViewController ()

@property (nonatomic, copy) NSArray *menuModels;

@end

static NSString *const identifier = @"cell";

@implementation WXGMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[WXGMenuCell class] forCellReuseIdentifier:identifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    
    
    __weak WXGMenuViewController *weakSelf = self;
    [NetworkAPI getMainListSuccessBlock:^(id returnData) {
        weakSelf.menuModels = returnData;
        
        // 加载后默认点击第一行，让detailView显示第一行的内容
        weakSelf.menuDidClick(self.menuModels[0], NO);
        [weakSelf.tableView reloadData];
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WXGMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (self.menuModels.count > indexPath.row)
    {
        cell.model = self.menuModels[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MAX(80, CGRectGetHeight(self.tableView.bounds) / self.menuModels.count);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.menuDidClick) {
        self.menuDidClick(self.menuModels[indexPath.row], YES);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
