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

@property (nonatomic, strong) CLData *clData;

@end

@implementation TPTokenKindViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = TPF6Color;

    YYCache *listCache = [YYCache cacheWithName:TPCacheName];
    self.clData =  (CLData *)[listCache objectForKey:self.assetModel.tokenId];
    
    
    [self setupNavigationBar];
    
    [self setUpHeaderView];
    
    [self setupPageView];
    
    [self setUpBottomView];
}


-(void)setupNavigationBar
{
    self.customNavBar.title = self.assetModel.tokenName;
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back_icon_white"]];
    
    if ([self.clData.tokenType isEqualToString:@"2"])
    {
        [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"code_icon_white"]];
        
        TPWeakSelf;
        [self.customNavBar setOnClickRightButton:^
        {
            [weakSelf QRClick];
        }];
    }
    
    
    
    [self.customNavBar wr_setBackgroundAlpha:0];
    
    
}

-(void)QRClick
{
    NIMScannerViewController * scannerVC = [[NIMScannerViewController alloc] initWithCardName:@"hahaha" avatar:nil completion:^(NSString *stringValue)
    {
        NSLog(@"stringValue:%@",stringValue);
        if ([self.assetModel.tokenId isEqualToString:@"4"])
        {
            //USDT BTC
            if ([self isBTC:stringValue])
            [self pushTransferClick:stringValue];
            else
            [self shwoErrorPopVC];
        }
            else if (![self.assetModel.tokenId isEqualToString:@"4"])
        {
            //ETH
            if([self isETH:stringValue])
            [self pushTransferClick:stringValue];
            else
            [self shwoErrorPopVC];
        }
            else
        {
            [self shwoErrorPopVC];
        }
    }];
    
    [self.navigationController pushViewController:scannerVC animated:YES];
}

-(void)pushTransferClick:(NSString *)address
{
    TPChainTransferViewController *transferVC = [[TPChainTransferViewController alloc]init];
    transferVC.assetModel = self.assetModel;
    transferVC.address = address;
    [self.navigationController pushViewController:transferVC animated:YES];
}

-(void)shwoErrorPopVC
{
    [self showErrorText:@"无效地址"];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setUpHeaderView
{
    UIImageView *headImgV = [YFactoryUI YImageViewWithimage:[UIImage imageNamed:@"X_nextpage_bg"]];
    [self.view addSubview:headImgV];
    [self.view sendSubviewToBack:headImgV];
    [headImgV mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.top.equalTo(@0);
        make.width.equalTo(@(KWidth));
        make.height.equalTo(iPhoneX ? @198:@174);
    }];
    
    TPTokenHeaderView *headerView = [[TPTokenHeaderView alloc] init];
    headerView.assetModel = self.assetModel;
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
    NSArray *titleArr = @[@"全部", @"支出", @"收入"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleGradientEffect = YES;
    configure.titleColor = TP8EColor;
    configure.titleSelectedColor = TP59Color;
    configure.indicatorColor = TP59Color;
    configure.showBottomSeparator = NO;
    configure.needBounces = NO;
    // pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight + 110 + 12, self.view.frame.size.width, 44) delegate:self titleNames:titleArr configure:configure];
    self.pageTitleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_pageTitleView];
    
    
    
    TPTokenTopicViewController *allVC = [[TPTokenTopicViewController alloc] initWithTokenId:self.assetModel.tokenId WithTransactionType:TPTransactionTypeAll];
    
    
    
    TPTokenTopicViewController *transferVC = [[TPTokenTopicViewController alloc] initWithTokenId:self.assetModel.tokenId WithTransactionType:TPTransactionTypeTransferOut];
    TPTokenTopicViewController *transfer2VC = [[TPTokenTopicViewController alloc] initWithTokenId:self.assetModel.tokenId WithTransactionType:TPTransactionTypeTransfer];

    NSArray *childArr = @[allVC,transferVC,transfer2VC];
    
    CGFloat height = KHeight - StatusBarAndNavigationBarHeight - TAB_BAR_HEIGHT - 40;
    
    self.pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), self.view.frame.size.width, height) parentVC:self childVCs:childArr];
    _pageContentScrollView.delegatePageContentScrollView = self;
    [self.view addSubview:_pageContentScrollView];
}

-(void)setUpBottomView
{
    if ([self.clData.tokenType isEqualToString:@"1"])
    {
        return ;
    }
    
    TPTokenBottomView * bottomView = [[TPTokenBottomView alloc] initWithStyle:[self.clData.tokenType isEqualToString:@"0"] ? TPChainStyleDown : TPChainStyleUp];
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
         transferVC.assetModel = self.assetModel;
         [self.navigationController pushViewController:transferVC animated:YES];
     }];
    
    [bottomView setChainReceiptBlock:^
     {
         TPChainReceiptViewController *receiptVC = [[TPChainReceiptViewController alloc] init];
         receiptVC.assetModel = self.assetModel;
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
