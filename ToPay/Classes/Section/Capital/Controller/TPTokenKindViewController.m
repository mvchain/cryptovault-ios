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
@property (nonatomic, strong) TPTokenHeaderView *headerView;
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
    
    [self RequestTransaction];
    
}
// bug fix
-(void)RequestTransaction
{
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"asset/transaction" parameters:@{@"tokenId":self.assetModel.tokenId} success:^(id responseObject, BOOL isCacheObject)
     {
         if ([responseObject[@"code"] isEqual:@200])
         {
             NSLog(@"%@",responseObject[@"data"]);
             NSDictionary *dic = responseObject[@"data"];

             TPAssetModel *assetmodel = self.headerView.assetModel;
             assetmodel.value = [dic[@"balance"] doubleValue];
             
             self.headerView.assetModel = assetmodel ;
             
         }
     }
                                             failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
     {
         NSLog(@"划账失败 %@",error);
     }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self RequestTransaction];
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

- (void)QRClick
{
    NIMScannerViewController * scannerVC = [[NIMScannerViewController alloc] initWithCardName:@"hahaha" avatar:nil completion:^(NSString *stringValue)
    {
        if ([ self.assetModel.tokenId isEqualToString:@"4"])
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
    scannerVC.tokenid = self.assetModel.tokenId;

    [self presentViewController:scannerVC animated:YES completion:^{
        
    }];
    
}

- (void)pushTransferClick:(NSString *)address
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

- (void)setUpHeaderView
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
    self.headerView = headerView;
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
    NSArray *titleArr = @[@"转账", @"理财", @"交易",@"众筹"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleGradientEffect = YES;
    configure.titleColor = TP8EColor;
    configure.titleSelectedColor = TP59Color;
    configure.indicatorColor = TP59Color;
    configure.showBottomSeparator = NO;
    configure.needBounces = NO;
    // pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight + 110 , self.view.frame.size.width, 44) delegate:self titleNames:titleArr configure:configure];
    self.pageTitleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_pageTitleView];
    TPTokenTopicViewController *allVC = [[TPTokenTopicViewController alloc] initWithTokenId:self.assetModel.tokenId WithTransactionType:0];
    allVC.classfiy = TransClassfiyBlock;
    TPTokenTopicViewController *transferVC = [[TPTokenTopicViewController alloc] initWithTokenId:self.assetModel.tokenId WithTransactionType:4];
    transferVC.classfiy = 4;
    TPTokenTopicViewController *transfer2VC = [[TPTokenTopicViewController alloc] initWithTokenId:self.assetModel.tokenId WithTransactionType:1];
    transfer2VC.classfiy = 1;
    TPTokenTopicViewController *transfer3VC = [[TPTokenTopicViewController alloc] initWithTokenId:self.assetModel.tokenId WithTransactionType:2];
    transfer3VC.classfiy = 2;
    
    NSArray *childArr = @[allVC,transferVC,transfer2VC,transfer3VC];
    CGFloat height = KHeight - CGRectGetMaxY(_pageTitleView.frame);
    if (![self.clData.tokenType isEqualToString:@"1"])
    {
        height-=52;
    }
    self.pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), self.view.frame.size.width, height) parentVC:self childVCs:childArr];
    _pageContentScrollView.delegatePageContentScrollView = self;
    [self.view addSubview:_pageContentScrollView];
}
- (void)setUpBottomView
{
    if ([self.clData.tokenType isEqualToString:@"1"])
    {
        return ;
    }
    TPTokenBottomView * bottomView = [[TPTokenBottomView alloc] initWithStyle:TPChainStyleUp];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@([QuickGet getWhiteBottomHeight]));
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
