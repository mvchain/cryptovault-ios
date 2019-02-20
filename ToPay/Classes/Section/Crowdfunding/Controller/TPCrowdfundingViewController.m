//
//  TPCrowdfundingViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/10.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPCrowdfundingViewController.h"

//#import "TPCFTopicViewController.h"
#import "TPReservationViewController.h"
#import "TPComingSoonViewController.h"
#import "TPEndViewController.h"
#import "TPRecordViewController.h"
#import "TPIJoinedViewController.h"
#import "TPReleaseProjectViewController.h"
@interface TPCrowdfundingViewController ()<SGPageTitleViewDelegate, SGPageContentScrollViewDelegate>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;
@end

@implementation TPCrowdfundingViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showSystemNavgation:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    self.customNavBar.title = @"众筹";
    [self setupPageView];
    [self setNavItem];
}

-(void)setNavItem
{
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"order"]];
    [self.customNavBar wr_setBottomLineHidden:YES];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"facoin"]];
    TPWeakSelf;

    [self.customNavBar setOnClickRightButton:^{
        TPRecordViewController *recordVC = [[TPRecordViewController alloc] init];
        [weakSelf.navigationController pushViewController:recordVC animated:YES];
    }];
    [self.customNavBar setOnClickLeftButton:^{
        TPReleaseProjectViewController *re = [[TPReleaseProjectViewController alloc]init];
        [weakSelf.navigationController pushViewController:re animated:YES];
    }];
    
}

-(void)setupPageView
{
    NSArray *titleArr = @[@"预热中", @"预约中", @"已结束",@"已参与"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorAdditionalWidth = 10; // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    configure.titleGradientEffect = YES;
    configure.titleColor = TP8EColor;
    configure.titleSelectedColor = TP59Color;
    configure.indicatorColor = TP59Color;
    configure.showBottomSeparator = NO;
    configure.needBounces = NO;
    // pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight, self.view.frame.size.width, 40) delegate:self titleNames:titleArr configure:configure];
    self.pageTitleView.selectedIndex = 1;
    [self.view addSubview:_pageTitleView];
    TPComingSoonViewController *oneVC = [[TPComingSoonViewController alloc] init];
    TPReservationViewController *twoVC = [[TPReservationViewController alloc] init];
    TPEndViewController *threeVC = [[TPEndViewController alloc] init];
    TPIJoinedViewController *four = [[TPIJoinedViewController alloc]init];
    NSArray *childArr = @[oneVC,twoVC,threeVC,four];
    CGFloat height = KHeight - StatusBarAndNavigationBarHeight - TAB_BAR_HEIGHT - 40 + (iPhoneX ? 10:0);
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
