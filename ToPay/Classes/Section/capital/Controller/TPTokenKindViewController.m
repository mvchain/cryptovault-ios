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

#import "TPChainTakeViewController.h"
#import "TPChainTransferViewController.h"
#import "TPChainReceiptViewController.h"
#import "TPTokenHeaderView.h"
#import "TPTokenBottomView.h"

#import "TPCurrencyList.h"
@interface TPTokenKindViewController ()<SGPageTitleViewDelegate, SGPageContentScrollViewDelegate>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;

@end

@implementation TPTokenKindViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = TPF6Color;

    [self setupNavigationBar];
    
    [self setUpHeaderView];
    
    [self setupPageView];
    
    [self setUpBottomView];
}


-(void)setupNavigationBar
{
    self.customNavBar.title = self.assetModel.tokenName;//@"VP余额";
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back_icon_white"]];
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"code_icon_white"]];
    [self.customNavBar wr_setBackgroundAlpha:0];
    
    TPWeakSelf;
    [self.customNavBar setOnClickRightButton:^{
        [weakSelf QRClick];
    }];
}

-(void)QRClick
{
    NIMScannerViewController * scannerVC = [[NIMScannerViewController alloc] initWithCardName:@"hahaha" avatar:nil completion:^(NSString *stringValue)
    {
        NSLog(@"stringValue:%@",stringValue);
    }];
    
    [self.navigationController pushViewController:scannerVC animated:YES];
}

-(void)setUpHeaderView
{
    UIImageView *headImgV = [YFactoryUI YImageViewWithimage:[UIImage imageNamed:iPhoneX ?@"X_nextpage_bg":@"bg_otherpage"]];
    [self.view addSubview:headImgV];
    [self.view sendSubviewToBack:headImgV];
    [headImgV mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.top.equalTo(@0);
        make.width.equalTo(@(KWidth));
        make.height.equalTo(iPhoneX ? @198:@174);
    }];
    
    TPTokenHeaderView *headerView = [[TPTokenHeaderView alloc] init];
    [self.view addSubview:headerView];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@0);
        make.top.equalTo(@(StatusBarAndNavigationBarHeight));
        make.width.equalTo(@(KWidth));
        make.height.equalTo(@(110));
    }];
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
    self.pageTitleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_pageTitleView];
    
    CGFloat VCH = KHeight - 172 - StatusBarAndNavigationBarHeight - 100;
    
    TPTokenTopicViewController *allVC = [[TPTokenTopicViewController alloc] initWithTokenId:self.assetModel.tokenId WithTransactionType:TPTransactionTypeAll];
//    allVC.view.frame = CGRectMake(0, 0, KWidth, VCH);
    TPTokenTopicViewController *transferVC = [[TPTokenTopicViewController alloc] initWithTokenId:self.assetModel.tokenId WithTransactionType:TPTransactionTypeTransferOut];
//    transferVC.view.frame = CGRectMake(0, 0, KWidth, VCH);
    TPTokenTopicViewController *transfer2VC = [[TPTokenTopicViewController alloc] initWithTokenId:self.assetModel.tokenId WithTransactionType:TPTransactionTypeTransfer];
//    transfer2VC.view.frame = CGRectMake(0, 0, KWidth, VCH);

    NSArray *childArr = @[allVC,transferVC,transfer2VC];
    
    CGFloat height = KHeight - StatusBarAndNavigationBarHeight - TAB_BAR_HEIGHT - 40;
    
    self.pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), self.view.frame.size.width, height) parentVC:self childVCs:childArr];
    _pageContentScrollView.delegatePageContentScrollView = self;
    [self.view addSubview:_pageContentScrollView];
}

-(void)setUpBottomView
{
    YYCache *listCache = [YYCache cacheWithName:TPCacheName];
    CLData *clData =  (CLData *)[listCache objectForKey:self.assetModel.tokenId];
    
    if ([clData.tokenType isEqualToString:@"1"])
    {
        return ;
    }

    NSLog(@"tokenType:%@",clData.tokenType);
    
    TPTokenBottomView * bottomView = [[TPTokenBottomView alloc] initWithStyle:[clData.tokenType isEqualToString:@"0"] ? TPChainStyleUp : TPChainStyleDown];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@(49 + HOME_INDICATOR_HEIGHT));
        make.bottom.equalTo(self.view);
    }];
    
    [bottomView setChainTakeBlock:^
    {
        TPChainTakeViewController *takeOutVC = [[TPChainTakeViewController alloc] init];
        [self.navigationController pushViewController:takeOutVC animated:YES];
    }];
    
    [bottomView setChainTransferBlock:^
     {
         TPChainTransferViewController *transferVC = [[TPChainTransferViewController alloc] init];
         [self.navigationController pushViewController:transferVC animated:YES];
     }];
    
    [bottomView setChainReceiptBlock:^
     {
         TPChainReceiptViewController *receiptVC = [[TPChainReceiptViewController alloc] init];
         [self.navigationController pushViewController:receiptVC animated:YES];
     }];
}


#pragma mark - SGPageTitleViewDelegate

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex
{
    [self.pageContentScrollView setPageContentScrollViewCurrentIndex:selectedIndex];
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex
{
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}




@end
