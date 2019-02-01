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
#import "TPKLineModel.h"

#import "ToPay-Swift.h"
#import <Charts/Charts-Swift.h>

@interface CubicLineSampleFillFormatter : NSObject <IChartValueFormatter>

@end

@implementation CubicLineSampleFillFormatter

-(CGFloat)getFillLinePositionWithDataSet:(LineChartDataSet *)dataSet dataProvider:(id<LineChartDataProvider>)dataProvider
{
    return -10.f;
}

@end



@interface TPTranDetailViewController ()<SGPageContentScrollViewDelegate,ChartViewDelegate>
@property (nonatomic, strong) UIView  *headerView;

@property (nonatomic, strong) LineChartView *chartView;

@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;
@property (nonatomic) CGFloat contentViewY;
@property (nonatomic) CGFloat contentViewHeight;

@property (nonatomic, strong) CLData *cData;
@property (nonatomic, strong) TPKLineModel *KLineModel;
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
    
    
    [USER_DEFAULT setObject:self.currName forKey:TPCurrencyNameKey];
    
    
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
         make.height.equalTo(@([QuickGet getWhiteBottomHeight]));
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

- (void)setUpPageContentView
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
    CGFloat contentViewHeight = KHeight - self.contentViewY - 52;
    self.pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, self.contentViewY, self.view.frame.size.width, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentScrollView.delegatePageContentScrollView = self;
    [self.pageContentScrollView setPageContentScrollViewCurrentIndex:0];
    [self.view addSubview:_pageContentScrollView];
}

-(void)setUpSegment
{
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"出售订单",@"购买订单"]];
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
    
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"transaction/pair/kline" parameters:@{@"pairId":self.vrtTopic.pairId} success:^(id responseObject, BOOL isCacheObject)
    {
        NSLog(@"%@",responseObject[@"data"]);
        
        self.KLineModel = [TPKLineModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self setPriceView];
        [self setGraph];
        [self setDateView];
    }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
    {
        NSLog(@"获取K线数据失败");
    }];
}

-(void)setPriceView
{
    /** 设置标题试图 */
    NSMutableArray *titleViews = [NSMutableArray array];
    NSArray *tits = @[@"当前价格",@"24H最高",@"24H最低"];
    
    NSString *currPrice = TPString(@"%.4f",[self.KLineModel.valueY[self.KLineModel.valueY.count-1] floatValue]);
    
    double ts = [self.KLineModel.timeX[self.KLineModel.timeX.count-1] doubleValue];
    
    NSDate *lastDate = [self getLocateTime:ts];
    NSDate *BeforeDay = [NSDate dateWithTimeInterval:-24 * 60 * 60 sinceDate:lastDate];
    NSString *beforeTS = [self dateConversionTimeStamp:BeforeDay];
    
    NSMutableArray *beforeArr = [NSMutableArray array];
    for (NSInteger i = self.KLineModel.valueY.count-1 ; i >= 0; i--)
    {
        if (beforeTS == self.KLineModel.timeX[i])
        {
            break;
        }
            else
        {
            [beforeArr addObject:self.KLineModel.valueY[i]];
        }
    }
    
    CGFloat max = [[beforeArr valueForKeyPath:@"@max.floatValue"] floatValue];//求最大值
    CGFloat min = [[beforeArr valueForKeyPath:@"@min.floatValue"] floatValue];//求最小值
    
    
    for (int i = 0 ; i < tits.count ; i++)
    {
        TPDetailTitleView *deTitleView = [[TPDetailTitleView alloc] initWithTextAlignment:i == 0 ? NSTextAlignmentLeft : i == 1 ? NSTextAlignmentCenter:NSTextAlignmentRight];
        deTitleView.timeLab.text = tits[i];
        deTitleView.conLab.text = i == 0 ? TPString(@"%@ %@",currPrice,@"BZTB")  : TPString(@"%.4f %@",i == 1 ? max:min,@"BZTB");
        [self.headerView addSubview:deTitleView];
        [titleViews addObject:deTitleView];
    }
    [titleViews mas_makeConstraints:^(MASConstraintMaker *make) {make.height.equalTo(@59);}];
    [titleViews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:16 tailSpacing:16];
}


#pragma mark - 曲线填充图
-(void)setGraph
{
    _chartView = [[LineChartView alloc] init];
    [self.headerView addSubview:_chartView];
    [_chartView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@0);
        make.top.equalTo(@59);
        make.width.equalTo(@(KWidth));
        make.height.equalTo(@160);
    }];
    
    
    _chartView.delegate = self;
    [_chartView setViewPortOffsetsWithLeft:0.f top:20.f right:0.f bottom:0.f];
    _chartView.chartDescription.enabled = NO;
    
    _chartView.dragEnabled = YES;
    [_chartView setScaleEnabled:NO];
    _chartView.pinchZoomEnabled = NO;
    _chartView.drawGridBackgroundEnabled = NO;
    _chartView.maxHighlightDistance = 300.0;
    
//    _chartView.drawFilledEnabled
//    _chartView.data.dataSets
    _chartView.xAxis.enabled = YES;
    
    ChartYAxis *yAxis = _chartView.leftAxis;
    yAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f];
    [yAxis setLabelCount:6 force:NO];
    yAxis.labelTextColor = TP8EColor;//UIColor.whiteColor;
    yAxis.labelPosition = YAxisLabelPositionInsideChart;
    yAxis.drawGridLinesEnabled = NO;
    yAxis.axisLineColor = UIColor.blackColor;//UIColor.whiteColor;
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelTextColor =[UIColor blackColor];
    xAxis.drawGridLinesEnabled = NO;
    xAxis.labelCount = 5;
    
    
    _chartView.rightAxis.enabled = NO;
    _chartView.legend.enabled = NO;
    [self updateChartData];
    
    [_chartView animateWithXAxisDuration:2.0 yAxisDuration:2.0];
}

-(void)updateChartData
{
    [self setDataCount:(int)self.KLineModel.valueY.count  range:100.0];
}

- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    
    for (int i = 0 ; i < count; i++)
    {
        [yVals1 addObject:[[ChartDataEntry alloc] initWithX:i y:[self.KLineModel.valueY[i] doubleValue]]];
    }
    
    LineChartDataSet *set1 = nil;
    
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
        set1.values = yVals1;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
        else
    {
        set1 = [[LineChartDataSet alloc] initWithValues:yVals1 label:@"DataSet 1"];
        set1.drawFilledEnabled = YES;
        set1.mode = LineChartModeCubicBezier;
        set1.cubicIntensity = 0.2;
        set1.drawCirclesEnabled = NO;
        set1.lineWidth = 1.8;
        set1.circleRadius = 4.0;
        [set1 setCircleColor:UIColor.whiteColor];
        set1.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
        [set1 setColor:UIColor.whiteColor];
        set1.fillColor = [TPMainColor colorWithAlphaComponent:0.3];
        set1.fillAlpha = 1.f;
        set1.drawHorizontalHighlightIndicatorEnabled = NO;
        set1.fillFormatter = [[CubicLineSampleFillFormatter alloc] init];
        
        /*
         * 渐变
         */
        NSArray *gradientColors = @[(id)[UIColor whiteColor].CGColor,
                                    (id)[TPMainColor colorWithAlphaComponent:0.16].CGColor];
        CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
        set1.fill = [ChartFill fillWithLinearGradient:gradient angle:90.f];
        
        

        TPBalloonMarker *marker = [[TPBalloonMarker alloc]
                                 initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
                                 font: [UIFont systemFontOfSize:12.0]
                                 textColor: UIColor.whiteColor
                                 insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
        marker.chartView = _chartView;
        marker.minimumSize = CGSizeMake(80.f, 40.f);
        _chartView.marker = marker;
        
        
        
        LineChartData *data = [[LineChartData alloc] initWithDataSet:set1];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:9.f]];
        [data setDrawValues:NO];
        
        _chartView.data = data;
    }
}

-(void)setDateView
{
    double ts = [self.KLineModel.timeX[self.KLineModel.timeX.count-1] doubleValue];
    
    NSDate *lastDate = [self getLocateTime:ts];

    NSMutableArray *dates = [NSMutableArray array];
    
    for (int i = 7-1 ; i >= 0; i--)
    {
        NSDate *lastDay = [NSDate dateWithTimeInterval:-(24 * i) * 60 * 60 sinceDate:lastDate];

        NSString *dateText = [[self dateConversionTimeStamp:lastDay]  MDConversionTimeStamp];
        
        UILabel *dateLab = [YFactoryUI YLableWithText:dateText color:[UIColor colorWithHex:@"#E1E1E1"] font:FONT(11)];
        
        dateLab.textAlignment = NSTextAlignmentCenter;
        [self.headerView addSubview:dateLab];
        [dates addObject:dateLab];
        
        [dateLab mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.height.equalTo(@20);
            make.top.equalTo(self.chartView.mas_bottom);
        }];
    }
    
    [dates mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
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

#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}

-(void)recordClick
{
    
}

@end
