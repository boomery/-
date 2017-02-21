//
//  ThreadsViewController.h
//  CXProject
//
//  Created by ZhangChaoxin on 16/5/7.
//  Copyright © 2016年 ZhangChaoxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ThreadModel;
@interface ThreadsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, PullingRefreshTableViewDelegate>

@property (nonatomic, strong) PullingRefreshTableView *tableView;
@property (nonatomic, strong) ThreadModel *model;
@property (nonatomic, assign) int pageNumber;
@property (nonatomic, strong) NSMutableArray *replysArray;

@end
