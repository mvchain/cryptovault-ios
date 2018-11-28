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
@interface TPTranDetailViewController ()<SGPageContentScrollViewDelegate>
@property (nonatomic, strong) UIView  *headerView;
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;
@property (nonatomic) CGFloat contentViewY;
@property (nonatomic) CGFloat contentViewHeight;
@end

@implementation TPTranDetailViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self showSystemNavgation:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.navigationItem.title = @"BTC";
    [self showSystemNavgation:NO];
    
    
    self.customNavBar.title = @"BTC";
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"list_icon_1"]];
    TPWeakSelf;
    [self.customNavBar setOnClickRightButton:^
    {
        TPBuyRecordViewController *buyRecordVC = [[TPBuyRecordViewController alloc] init];
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
        TPSellViewController *SellVC = [[TPSellViewController alloc]init];
        [self.navigationController pushViewController:SellVC animated:YES];
    }];
    
    [bottomView setChainReceiptBlock:^
    {
        NSLog(@"发布购买订单");
        TPSellViewController *SellVC = [[TPSellViewController alloc]init];
        [self.navigationController pushViewController:SellVC animated:YES];
    }];
}

-(void)setUpPageContentView
{
    TPUSDTViewController *VRTVC = [[TPUSDTViewController alloc] init];
    VRTVC.view.frame = CGRectMake(0, 0, KWidth, self.contentViewHeight);
//    VRTVC.view.backgroundColor = YRandomColor;
    TPUSDTViewController *balanceVC = [[TPUSDTViewController alloc] init];
    balanceVC.view.frame = CGRectMake(0, 0, KWidth, self.contentViewHeight);
//    balanceVC.view.backgroundColor = YRandomColor;
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
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"购买USDT",@"出售USDT"]];
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
    self.headerView.backgroundColor = YRandomColor;
    [self.view addSubview:self.headerView];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@0);
        make.top.equalTo(@(12 + StatusBarAndNavigationBarHeight));
        make.height.equalTo(@240);
        make.width.equalTo(self.view.mas_width);
    }];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
