//
//  TPTranDetailViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/21.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPTranDetailViewController.h"
#import "TPTokenBottomView.h"
#import "TPUSDTViewController.h"
#import "TPBuyRecordViewController.h"
#import "TPSellViewController.h"
#import "TPCurrencyList.h"
#import "TPDetailTitleView.h"

#import "AAChartKit.h"

@interface TPTranDetailViewController ()<SGPageContentScrollViewDelegate,AAChartViewDidFinishLoadDelegate>
@property (nonatomic, strong) UIView  *headerView;

@property (nonatomic, strong) AAChartModel *aaChartModel;
@property (nonatomic, strong) AAChartView  *aaChartView;


@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;
@property (nonatomic) CGFloat contentViewY;
@property (nonatomic) CGFloat contentViewHeight;

@property (nonatomic, strong) CLData *cData;
@end

@implementation TPTranDetailViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    YYCache *listCache = [YYCache cacheWithName:TPCacheName];
    self.cData = (CLData *)[listCache objectForKey:self.vrtTopic.tokenId];
    
    self.customNavBar.title = TPString(@"%@/%@",self.cData.tokenName,self.currName);
    [self showSystemNavgation:NO];
    TPWeakSelf;
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"list_icon_black"]];
    
    [self.customNavBar setOnClickRightButton:^
    {
        TPBuyRecordViewController *buyRecordVC = [[TPBuyRecordViewController alloc] init];
        buyRecordVC.pairId = weakSelf.vrtTopic.pairId;
        [weakSelf.navigationController pushViewController:buyRecordVC animated:YES];
    }];
    
    
    
    
    [self setUpHeaderView];
    [self setUpSegment];
    [self setUpPageContentView];
    [self setUpBottomView];
}

-(void)setUpBottomView
{
    TPTokenBottomView *bottomView = [[TPTokenBottomView alloc] initWithStyle:TPChainStyleUp];
    bottomView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.10].CGColor;
    bottomView.layer.shadowOffset = CGSizeMake(0,0);
    bottomView.layer.shadowRadius = 10;
    bottomView.layer.shadowOpacity = 1;
    bottomView.titleArray = @[@"发布出售订单",@"发布购买订单"];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(@0);
         make.right.equalTo(@0);
         make.height.equalTo(@(49 + HOME_INDICATOR_HEIGHT));
         make.bottom.equalTo(self.view);
     }];


    [bottomView setChainTransferBlock:^
    {
        NSLog(@"发布出售订单");
        TPSellViewController *SellVC = [[TPSellViewController alloc]initWithPairId:self.vrtTopic.pairId WithTransType:TPTransactionTypeTransferOut publish:YES];
        SellVC.currName = self.currName;
        SellVC.cData = self.cData;
        [self.navigationController pushViewController:SellVC animated:YES];
    }];
    
    [bottomView setChainReceiptBlock:^
    {
        NSLog(@"发布购买订单");
        TPSellViewController *SellVC = [[TPSellViewController alloc]initWithPairId:self.vrtTopic.pairId WithTransType:TPTransactionTypeTransfer publish:YES];
        SellVC.currName = self.currName;
        SellVC.cData = self.cData;
        [self.navigationController pushViewController:SellVC animated:YES];
    }];
}

-(void)setUpPageContentView
{
    TPUSDTViewController *VRTVC = [[TPUSDTViewController alloc] initWithPairId:self.vrtTopic.pairId WithTransactionType:@"2" ];
    VRTVC.cData = self.cData;
    VRTVC.currName = self.currName;
    VRTVC.tokenName = self.cData.tokenName;
    
    TPUSDTViewController *balanceVC = [[TPUSDTViewController alloc] initWithPairId:self.vrtTopic.pairId WithTransactionType:@"1"];
    balanceVC.cData = self.cData;
    balanceVC.currName = self.currName;
    balanceVC.tokenName = self.cData.tokenName;
    
    NSArray *childArr = @[VRTVC, balanceVC];
    
    self.contentViewY = StatusBarAndNavigationBarHeight + 12 + 240 + 48 + 2;
    CGFloat contentViewHeight = KHeight - self.contentViewY - TAB_BAR_HEIGHT;
    
    self.pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, self.contentViewY, self.view.frame.size.width, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentScrollView.delegatePageContentScrollView = self;
    [self.pageContentScrollView setPageContentScrollViewCurrentIndex:0];
    [self.view addSubview:_pageContentScrollView];
}

-(void)setUpSegment
{
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[TPString(@"购买%@",self.cData.tokenName),TPString(@"出售%@",self.cData.tokenName)]];
    segment.selectedSegmentIndex = 0;
    segment.tintColor = TPMainColor;
    [segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:FONT(13)
                                                           forKey:NSFontAttributeName];
    [segment setTitleTextAttributes:attributes
                           forState:UIControlStateNormal];
    [self.view addSubview:segment];
    self.segment = segment;
    [segment mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.headerView.mas_bottom).with.offset(12);
         make.centerX.equalTo(self.view);
         make.height.equalTo(@36);
         make.width.equalTo(@(KWidth - 30));
     }];
}



-(void)setUpHeaderView
{
    self.headerView = [[UIView alloc] init];
    self.headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@0);
        make.top.equalTo(@(12 + StatusBarAndNavigationBarHeight));
        make.height.equalTo(@240);
        make.width.equalTo(self.view.mas_width);
    }];
    
    
    /** 设置标题试图 */
    NSMutableArray *titleViews = [NSMutableArray array];
    NSArray *tits = @[@"当前价格",@"24H最高",@"24H最低"];
    for (int i = 0 ; i < tits.count ; i++)
    {
        TPDetailTitleView *deTitleView = [[TPDetailTitleView alloc] initWithTextAlignment:i == 0 ? NSTextAlignmentLeft : i == 1 ? NSTextAlignmentCenter:NSTextAlignmentRight];
        deTitleView.timeLab.text = tits[i];
        deTitleView.conLab.text = @"1234568.12 VRT";
        [self.headerView addSubview:deTitleView];
        [titleViews addObject:deTitleView];
    }
    [titleViews mas_makeConstraints:^(MASConstraintMaker *make) {make.height.equalTo(@59);}];
    [titleViews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:16 tailSpacing:16];
    
    
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"transaction/pair/kline" parameters:@{@"pairId":self.vrtTopic.pairId} success:^(id responseObject, BOOL isCacheObject)
    {
        NSLog(@"%@",responseObject[@"data"]);
    }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
    {
        NSLog(@"获取K线数据失败");
    }];
    
    
    [self setGraph];
}

#pragma mark - 曲线填充图

-(void)setGraph
{
    self.aaChartView = [[AAChartView alloc] init];
    
    [self.headerView addSubview:self.aaChartView];
    
    [self.aaChartView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(@0);
         make.top.equalTo(@59);
         make.width.equalTo(@(KWidth));
         make.height.equalTo(@180);
     }];
    //    self.aaChartView.delegate = self;
    self.aaChartView.scrollEnabled = NO;
    self.aaChartView.isClearBackgroundColor = YES;
    
    
    self.aaChartModel = AAChartModel.new
    .chartTypeSet(AAChartTypeAreaspline) //.titleSet(@"主标题")
    .yAxisLineWidthSet(@0)
    .colorsThemeSet(@[@"#fe117c",@"#ffc069",@"#06caf4",@"#7dffc0"])//设置主体颜色数组
    .yAxisTitleSet(@"")//设置 Y 轴标题
    .tooltipValueSuffixSet(@"℃")//设置浮动提示框单位后缀
    .backgroundColorSet(@"#4b2b7f")
    .yAxisGridLineWidthSet(@0)//y轴横向分割线宽度为0(即是隐藏分割线)
    .seriesSet(@[AASeriesElement.new
                 .dataSet(@[@7.0, @6.9, @9.5, @14.5, @18.2, @21.5, @25.2, @26.5, @23.3, @18.3, @13.9, @9.6])]
               );
    
    
    [self configureTheStyleForDifferentTypeChart]; //为不同类型图表设置样式
    
    
    [self.aaChartView aa_drawChartWithChartModel:_aaChartModel];
}


-(void)configureTheStyleForDifferentTypeChart
{
    _aaChartModel.markerSymbolStyle = AAChartSymbolStyleTypeInnerBlank;//设置折线连接点样式为:内部白色
    _aaChartModel.gradientColorsThemeEnabled = true;//启用渐变色
    _aaChartModel.animationType = AAChartAnimationEaseOutQuart;//图形的渲染动画为 EaseOutQuart 动画
    _aaChartModel.xAxisCrosshairWidth = @0.9;//Zero width to disable crosshair by default
    _aaChartModel.xAxisCrosshairColor = @"#FFE4C4";//(浓汤)乳脂,番茄色准星线
    _aaChartModel.xAxisCrosshairDashStyleType = AALineDashSyleTypeLongDashDot;
}


#pragma mark - action

-(void)change:(UISegmentedControl *)sender
{
    [self.pageContentScrollView setPageContentScrollViewCurrentIndex:sender.selectedSegmentIndex];
}

#pragma mark - SGPageContentScrollViewDelegate
- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex
{
    self.segment.selectedSegmentIndex = targetIndex;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)recordClick
{
//    NSLog(@"记录页面");
    
}

@end
