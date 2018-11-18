//
//  TPTokenKindViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/15.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPTokenKindViewController.h"
#import "TPTokenTopicViewController.h"
#import "NIMScannerViewController.h"
#import "TPTokenHeaderView.h"

@interface TPTokenKindViewController ()<SGPageTitleViewDelegate, SGPageContentScrollViewDelegate>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;

@end

@implementation TPTokenKindViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = TPF6Color;
    self.navigationItem.title = @"VP余额";
   
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(QRClick) image:[UIImage imageNamed:@"code_icon_1"]];
    
    [self setUpHeaderView];
    
    [self setupPageView];
}


-(void)QRClick
{
//    NSLog(@"QRView");
    NIMScannerViewController * scannerVC = [[NIMScannerViewController alloc] initWithCardName:@"hahaha" avatar:nil completion:^(NSString *stringValue)
    {
        NSLog(@"stringValue:%@",stringValue);
    }];
    
    [self.navigationController pushViewController:scannerVC animated:YES];
    
}

-(void)setUpHeaderView
{
    TPTokenHeaderView *headerView = [[TPTokenHeaderView alloc] init];
    [self.view addSubview:headerView];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@0);
        make.top.equalTo(@(StatusBarAndNavigationBarHeight));
        make.width.equalTo(@(KWidth));
        make.height.equalTo(@110);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)setupPageView
{
    NSArray *titleArr = @[@"全部", @"转出", @"转入"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleGradientEffect = YES;
    configure.titleColor = TP8EColor;
    configure.titleSelectedColor = TP59Color;
    configure.indicatorColor = TP59Color;
    configure.showBottomSeparator = NO;
    
    // pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight + 110 + 12, self.view.frame.size.width, 44) delegate:self titleNames:titleArr configure:configure];
    [self.view addSubview:_pageTitleView];
    
    TPTokenTopicViewController *allVC = [[TPTokenTopicViewController alloc] init];
    TPTokenTopicViewController *transferVC = [[TPTokenTopicViewController alloc] init];
    TPTokenTopicViewController *transfer2VC = [[TPTokenTopicViewController alloc] init];

    NSArray *childArr = @[allVC,transferVC,transfer2VC];
    
    CGFloat height = KHeight - StatusBarAndNavigationBarHeight - TAB_BAR_HEIGHT - 40;
    
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


@end
