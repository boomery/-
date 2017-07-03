//
//  WXGDetailViewController.m
//  WXGSlideMenuDemo
//
//  Created by Nicholas Chow on 15/7/6.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGDetailViewController.h"
#import "ListModel.h"
#import "ThreadModel.h"
#import "ThreadCell.h"
#import "ThreadsViewController.h"
@interface WXGDetailViewController () <UITableViewDelegate, UITableViewDataSource, PullingRefreshTableViewDelegate>

@property (nonatomic, strong) PullingRefreshTableView *tableView;

@property (nonatomic, assign) int pageNumber;

@property (nonatomic, weak) UIImageView *detailIcon;

@property (nonatomic, weak) UIImageView *leftBarIcon;

@property (nonatomic, strong) NSMutableArray *threadsArray;

@end

@implementation WXGDetailViewController

//- (UIImageView *)detailIcon {
//    if (!_detailIcon) {
//        UIImageView *detailIcon = [[UIImageView alloc] init];
//        _detailIcon = detailIcon;
//        [self.view addSubview:detailIcon];
//    }
//    return _detailIcon;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // UIBarButtonItem的initWithCustomView:方法会对内部控件有特殊约束
    // 直接将leftBarIcon添加上去会无法实现滚动效果
    // 解决办法：将leftBarIcon包装在一个view里面
    UIView *wrapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftBarButtonClick)];
    [wrapView addGestureRecognizer:tap];
    
    UIImageView *leftBarIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Hamburger"]];
    self.leftBarIcon = leftBarIcon;
    
    [wrapView addSubview:leftBarIcon];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:wrapView];
    
    PullingRefreshTableView *tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.pullingDelegate = self;
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

// 使用自定义视图时，在初始化方法中通常无法获取真实的frame，所以我们经常在layoutSubviews方法中布局子控件，此处同理
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.detailIcon.frame = CGRectMake((CGRectGetWidth(self.view.bounds) - 320) * 0.5, (CGRectGetHeight(self.view.bounds) - 320) * 0.5, 320, 320);
}

// 顶部按钮点击事件
- (void)leftBarButtonClick {
    if (self.leftBarButtonDidClick) {
        self.leftBarButtonDidClick();
    }
}

// 顶部按钮滚动效果
- (void)rotateLeftBarButtonWithScale:(CGFloat)scale {
    CGFloat angle = M_PI_2 * (1 - scale);
    self.leftBarIcon.transform = CGAffineTransformMakeRotation(angle);
}

- (void)setModel:(ListModel *)model{
    _model = model;
    _pageNumber = 1;
    _threadsArray = [[NSMutableArray alloc] init];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self requestTableDataWithRefresh:YES];
    });
}

#pragma mark - 数据请求
- (void)requestTableDataWithRefresh:(BOOL)refreshFlag
{
    __weak WXGDetailViewController *weakSelf = self;
    if (refreshFlag)
    {
        weakSelf.tableView.contentOffset = CGPointMake(0, 0);
    }
    [NetworkAPI getListDetailgetListDetailWithModel:_model  page:_pageNumber SuccessBlock:^(id returnData) {
            NSArray *questionList = returnData;
            if (questionList.count == 0)
            {
                if (refreshFlag)
                {
                    [_threadsArray removeAllObjects];
                    [DialogHandler showInfoWithTitle:@"|-` )，没有"];
                }
                else
                {
                    [DialogHandler showInfoWithTitle:@"|-` )，没了"];
                    self.tableView.hasMoreData = NO;
                    self.pageNumber --;
                }
            }
            else
            {
                [DialogHandler hideDlg];
                if (refreshFlag)
                {
                    [_threadsArray removeAllObjects];
                }
                else
                {
                    self.tableView.hasMoreData = YES;
                }
                for (ThreadModel *model in questionList)
                {
                    [_threadsArray addObject:model];
                }
            }
  
        [self tableViewEndLoading];
        [self.tableView reloadData];
        
    } failureBlock:^(NSError *error) {
        [weakSelf tableViewEndLoading];
    } showHUD:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.threadsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    ThreadCell *cell = (ThreadCell *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[ThreadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];;
    }
    if (self.threadsArray.count > indexPath.row)
    {
        cell.model = self.threadsArray[indexPath.row];
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.threadsArray.count > indexPath.row)
    {
        return [ThreadCell heightForThreadModel:self.threadsArray[indexPath.row]];
    }
    return 0;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThreadsViewController *threads = [[ThreadsViewController alloc] init];
    threads.model = self.threadsArray[indexPath.row];
    [self.navigationController pushViewController:threads animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - PullingRefreshTableViewDelegate
-(void)tableViewEndLoading
{
    [self.tableView tableViewDidFinishedLoading];
}
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView
{
    self.pageNumber = 1;
    [self requestTableDataWithRefresh:YES];
}

- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView
{
    self.pageNumber ++;
    [self requestTableDataWithRefresh:NO];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.tableView tableViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.tableView tableViewDidEndDragging:scrollView];
}
- (NSDate *)pullingTableViewRefreshingFinishedDate
{
    return [NSDate date];
}
- (NSDate *)pullingTableViewLoadingFinishedDate
{
    return [NSDate date];
}
@end
