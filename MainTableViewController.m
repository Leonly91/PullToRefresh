//
//  MainTableViewController.m
//  PullToRefresh
//
//  Created by 林勇 on 16/1/16.
//  Copyright (c) 2016年 Leonly91. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()
{
    CGFloat _originOffsetY;
}
@property (nonatomic, strong) PullToRefreshHeaderView *pullToRefreshHeaderView;
//@property (nonatomic) CGFloat navigationBarHeight;
@end

@implementation MainTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60.00)];
    label.text = @"Pull";
    label.textAlignment = NSTextAlignmentCenter;
    //self.tableView.tableHeaderView = label;
    
    _pullToRefreshHeaderView = [[PullToRefreshHeaderView alloc] initWithFrame:CGRectMake(0.0, self.view.frame.origin.y - 80.0, CGRectGetWidth(self.view.bounds), 80.0f)];
    _pullToRefreshHeaderView.backgroundColor = [UIColor redColor];
    _pullToRefreshHeaderView.delegate = self;
    [self.view addSubview:_pullToRefreshHeaderView];
//    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.navigationItem.title = @"PullToRefresh";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.automaticallyAdjustsScrollViewInsets = YES;
    self.navigationController.navigationBar.backgroundColor = [UIColor greenColor];

    
    NSLog(@"navigation originOffsetY = %f, %f", self.tableView.frame.origin.y, self.tableView.contentOffset.y
          );
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self->_originOffsetY = fabs(self.tableView.contentOffset.y);
    
    NSLog(@"%@, offset.y = %f", NSStringFromSelector(_cmd), self->_originOffsetY);
}

#pragma UITableViewDelegate UITableDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Section - %lu", (long)section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = @"Hello";
    
    return cell;
}

#pragma PullToRefreshHeaderDelegate
-(NSDate *)refreshLastUpdateDate:(PullToRefreshHeaderView *)headerView
{
    return [NSDate date];
}


#pragma UIScrollViewDelegate delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%@, %f", NSStringFromSelector(_cmd), self.tableView.contentOffset.y);
    if (self.tableView.contentOffset.y > (-50.0f - self->_originOffsetY))
    {
        self.tableView.contentInset = UIEdgeInsetsMake(self->_originOffsetY, 0, 0, 0);
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //Show PullToRefreshHeaderViewr
    CGFloat offset = 60.0f + self->_originOffsetY;
    if (self.tableView.contentOffset.y < (offset * -1))
    {
        NSLog(@"%@, offset:%f", NSStringFromSelector(_cmd), self.tableView.contentOffset.y);
    
        self.tableView.contentInset = UIEdgeInsetsMake(offset, 0.0, 0.0, 0.0);
        [self.pullToRefreshHeaderView setState:PullToRefreshLoading];
    }
    
    NSLog(@"%@, offset.y = %f", NSStringFromSelector(_cmd), self.tableView.contentOffset.y);
}




@end
