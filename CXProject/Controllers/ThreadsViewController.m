//
//  ThreadsViewController.m
//  CXProject
//
//  Created by ZhangChaoxin on 16/5/7.
//  Copyright © 2016年 ZhangChaoxin. All rights reserved.
//

#import "ThreadsViewController.h"
#import "ThreadCell2.h"
#import "ThreadModel.h"
@implementation ThreadsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    PullingRefreshTableView *tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.pullingDelegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self requestTableDataWithRefresh:YES];
    _replysArray = [[NSMutableArray alloc] init];
    _pageNumber = 1;
}

#pragma mark - 数据请求
- (void)requestTableDataWithRefresh:(BOOL)refreshFlag
{
    __weak ThreadsViewController *weakSelf = self;
    if (refreshFlag)
    {
        weakSelf.tableView.contentOffset = CGPointMake(0, 0);
    }
    [NetworkAPI getThreadDetailgetListDetailWithModel:_model page:_pageNumber SuccessBlock:^(id returnData) {
        NSArray *questionList = returnData;
        if (questionList.count == 0)
        {
            if (refreshFlag)
            {
                [_replysArray removeAllObjects];
                [DialogHandler showInfoWithTitle:@"|-` )，没有回复"];
            }
            else
            {
                [DialogHandler showInfoWithTitle:@"|-` )，没有更多"];
                weakSelf.tableView.hasMoreData = NO;
                weakSelf.pageNumber --;
            }
        }
        else
        {
            [DialogHandler hideDlg];
            if (refreshFlag)
            {
                [_replysArray removeAllObjects];
            }
            else
            {
                weakSelf.tableView.hasMoreData = YES;
            }
            for (ThreadModel *model in questionList)
            {
                [_replysArray addObject:model];
            }
        }
        [weakSelf tableViewEndLoading];
        [weakSelf.tableView reloadData];
        [weakSelf tableViewEndLoading];
    } failureBlock:^(NSError *error) {
        [weakSelf tableViewEndLoading];
    } showHUD:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.replysArray.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";    
    ThreadCell2 *cell = (ThreadCell2 *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[ThreadCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];;
    }
    if (indexPath.row == 0)
    {
        cell.isPo = YES;
        cell.model = _model;
        return cell;
    }
    if (self.replysArray.count >= indexPath.row)
    {
        ThreadModel *model = self.replysArray[indexPath.row-1];
        cell.isPo = [self isPoWithModel:model];
        cell.model = model;
    }
    return cell;
}

- (BOOL)isPoWithModel:(ThreadModel *)model
{
    if ([model.uid isEqualToString:_model.uid])
    {
        return YES;
    }
    return NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        if (_model.thumb.length == 0)
        {
            return _model.contentHeight + 50;
        }
        return _model.contentHeight + 105 + 50;
    }
    if (self.replysArray.count >= indexPath.row)
    {
        return [ThreadCell2 heightForThreadModel:self.replysArray[indexPath.row-1]];
    }
    return 0;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
