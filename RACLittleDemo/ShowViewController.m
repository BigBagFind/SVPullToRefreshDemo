//
//  ShowViewController.m
//  RACLittleDemo
//
//  Created by 铁拳科技 on 16/10/13.
//  Copyright © 2016年 铁哥哥. All rights reserved.
//

#import "ShowViewController.h"
#import "SVPullToRefresh.h"

@interface ShowViewController ()


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;



@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 下啦刷新
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [self.scrollView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(pullDownAction:) forControlEvents:UIControlEventValueChanged];
    
    // 上啦加载更多
    [self.scrollView addInfiniteScrollingWithActionHandler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 如果已经加载完毕
            [self addNoMoreData];
            
            // 正常情况
            // Do any additional setup after refreshing
            // ...
            
            [self.scrollView.infiniteScrollingView stopAnimating];
            
        });
    }];
    
    
    
}

- (void)addNoMoreData {
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 375, 60);
    label.backgroundColor = [UIColor greenColor];
    label.text = @"没有更多了";
    label.textAlignment = NSTextAlignmentCenter;
    [self.scrollView.infiniteScrollingView setCustomView:label forState:SVInfiniteScrollingStateStopped];
    self.scrollView.infiniteScrollingView.enabled = NO;

}


- (void)pullDownAction:(UIRefreshControl *)control {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.scrollView.infiniteScrollingView.enabled = YES;
        [control endRefreshing];
    });
}


@end
