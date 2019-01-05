//
//  TPBuyRecordViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/23.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPBuyRecordViewController.h"
#import "TPBuyTopicViewController.h"
#import "TPFilterViewController.h"
@interface TPBuyRecordViewController ()<SGPageTitleViewDelegate,SGPageContentScrollViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;
@end

@implementation TPBuyRecordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.customNavBar.title = @"交易记录";
    [self showSystemNavgation:NO];
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"filter_icon_black"]];
    
    NSLog(@"%@",[WYNetworkManager sharedManager].customHeaders);
    
    TPWeakSelf;
    [self.customNavBar setOnClickRightButton:^
    {
        TPFilterViewController *filterVC = [[TPFilterViewController alloc] init];
        [weakSelf.navigationController pushViewController:filterVC animated:YES];
    }];

    [self setupPageView];
}

-(void)setupPageView
{
    NSArray *titleArr = @[@"进行中的订单", @"成交记录"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorAdditionalWidth = 10; // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    configure.titleGradientEffect = YES;
    configure.titleColor = TP8EColor;
    configure.titleSelectedColor = TP59Color;
    configure.indicatorColor = TP59Color;
    configure.showBottomSeparator = NO;
    // pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight, self.view.frame.size.width, 40) delegate:self titleNames:titleArr configure:configure];
    [self.view addSubview:_pageTitleView];
    TPBuyTopicViewController *oneVC = [[TPBuyTopicViewController alloc] initWithChainStyle:TPStatusStyleProcessing];
    oneVC.pairId = self.pairId;
    TPBuyTopicViewController *twoVC = [[TPBuyTopicViewController alloc] initWithChainStyle:TPStatusStylecarryOut];
    twoVC.pairId = self.pairId;
    NSArray *childArr = @[oneVC,twoVC];
    CGFloat height = KHeight - StatusBarAndNavigationBarHeight - TAB_BAR_HEIGHT;
    self.pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), self.view.frame.size.width, height) parentVC:self childVCs:childArr];
    _pageContentScrollView.delegatePageContentScrollView = self;
    [self.view addSubview:_pageContentScrollView];
}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex
{
    [self.pageContentScrollView setPageContentScrollViewCurrentIndex:selectedIndex];
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex
{
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)recordClcik
{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
