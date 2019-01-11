//
//  TPTransactionViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/10.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPTransactionViewController.h"
#import "TPVRTViewController.h"
#import "TPBuyRecordViewController.h"
#import "TPNavigationBarTitleView.h"
@interface TPTransactionViewController ()<SGPageContentScrollViewDelegate,SGPageTitleViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;
@end
@implementation TPTransactionViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self showSystemNavgation:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(transRecord) image:[UIImage imageNamed:@"list_icon_black"] imageEdgeInsets:UIEdgeInsetsMake(0, 16, 0, -16)];
    [self showSystemNavgation:YES];
    [self setNavTitleView];
    [self setNavConView];
}

-(void)transRecord
{
    TPBuyRecordViewController *recordVC = [[TPBuyRecordViewController alloc] init];
    [self.navigationController pushViewController:recordVC animated:YES];
}

-(void)setNavConView
{
    TPVRTViewController *VRTVC = [[TPVRTViewController alloc] initWithChainStyle:TPTransactionStyleVRT];
    TPVRTViewController *balanceVC = [[TPVRTViewController alloc] initWithChainStyle:TPTransactionStyleBalance];
    NSArray *childArr = @[VRTVC, balanceVC];
    CGFloat contentViewHeight = KHeight - StatusBarAndNavigationBarHeight - TAB_BAR_HEIGHT + (iPhoneX ? 10:0);
    self.pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight, self.view.frame.size.width, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentScrollView.delegatePageContentScrollView = self;
    [self.view addSubview:_pageContentScrollView];
}

-(void)setNavTitleView
{
    NSArray *titleArr = @[@"VRT交易", @"余额交易"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorStyle =  SGIndicatorStyleDefault;
    configure.indicatorColor = TP59Color;
    configure.titleColor = TP8EColor;
    [configure setTitleSelectedColor:TP59Color];
    configure.titleFont = FONT(15);
    configure.showBottomSeparator = NO;
    configure.needBounces = NO;
    CGFloat titleVW = 250;
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, titleVW, 44) delegate:self titleNames:titleArr configure:configure];
    TPNavigationBarTitleView *view = [[TPNavigationBarTitleView alloc] initWithFrame:CGRectMake(0, 0, titleVW, 44)];
    self.navigationItem.titleView = view;
    [view addSubview:_pageTitleView];
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

@end
