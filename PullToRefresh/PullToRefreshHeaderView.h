//
//  PullToRefreshHeaderView.h
//  PullToRefresh
//
//  Created by 林勇 on 16/1/16.
//  Copyright (c) 2016年 Leonly91. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum{
    PullToRefreshPulling = 0,
    PullToRefreshNormal,
    PullToRefreshLoading,
}PullToRefreshState;

@interface PullToRefreshHeaderView : UIView
@property (nonatomic, strong) id delegate;
-(void)setState:(PullToRefreshState)aState;
@end


@protocol PullToRefreshHeaderDelegate

-(NSDate *)refreshLastUpdateDate:(PullToRefreshHeaderView *)headerView;

@end