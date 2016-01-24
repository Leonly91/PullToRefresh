//
//  PullToRefreshHeaderView.m
//  PullToRefresh
//
//  Created by 林勇 on 16/1/16.
//  Copyright (c) 2016年 . All rights reserved.
//

#import "PullToRefreshHeaderView.h"
#import <UIKit/UIKit.h>

@interface PullToRefreshHeaderView ()
@property (nonatomic, strong) UILabel *lastUpdateDateLabel;
@property (nonatomic, strong) UILabel *statusLabel;

@end

@implementation PullToRefreshHeaderView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40.0f)];
        _statusLabel.textAlignment= NSTextAlignmentCenter;
        [self addSubview:_statusLabel];
        
        _lastUpdateDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 20.0f, self.frame.size.width, 40.0f)];
        _lastUpdateDateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lastUpdateDateLabel];
        
        [self setState:PullToRefreshNormal];
    }
    
    return self;
}

-(void)setState:(PullToRefreshState)aState
{
    switch (aState) {
        case PullToRefreshLoading:
            self.statusLabel.text = @"Loading......";
            break;
        case PullToRefreshPulling:
            self.statusLabel.text = @"Pull to refresh...";
            break;
        case PullToRefreshNormal:
            self.statusLabel.text = @"Pull to refresh...";
            self.lastUpdateDateLabel.text = @"Last Updated: ";
            break;
        default:
            break;
    }
}

@end
