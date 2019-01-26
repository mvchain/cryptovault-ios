//
//  TPMyStoreViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/22.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPMyStoreViewController.h"
#import "TPMyStoreTableViewController.h"
#import "TPStoreDetailViewController.h"
#import "MyStoreItemModel.h"
@interface TPMyStoreViewController ()<SGPageTitleViewDelegate,SGPageContentScrollViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;
@property (strong, nonatomic) TPMyStoreTableViewController *tableVc0;
@property (strong, nonatomic) TPMyStoreTableViewController *tableVc1;
@property (strong, nonatomic) TPMyStoreTableViewController *tableVc2;

@end

@implementation TPMyStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    [self setNavTitleView];
    [self setNavConView];
    [self setEvent] ;
    // Do any additional setup after loading the view from its nib.
}
- (void)setUpNav {
    self.customNavBar.title = @"我的持仓";
}

- (void)setEvent {
    
    __weak typeof (self) wsf = self;
    _tableVc0.onTableViewDidSelect = ^(MyStoreItemModel *model, int financialType) {
        TPStoreDetailViewController * tp = [[TPStoreDetailViewController alloc]init];
        tp.financial_id = model.idField;
        tp.outModel = model;
        [wsf.navigationController pushViewController:tp animated:YES];
    } ;

    _tableVc1.onTableViewDidSelect = ^(MyStoreItemModel *model, int financialType) {
        TPStoreDetailViewController * tp = [[TPStoreDetailViewController alloc]init];
        tp.financial_id = model.idField;
        tp.outModel = model;
        [wsf.navigationController pushViewController:tp animated:YES];
    } ;
    _tableVc2.onTableViewDidSelect = ^(MyStoreItemModel *model, int financialType) {
        TPStoreDetailViewController * tp = [[TPStoreDetailViewController alloc]init];
        tp.financial_id = model.idField;
        tp.isTakeouted = YES;
        tp.outModel = model;
        [wsf.navigationController pushViewController:tp animated:YES];
    };
    
}
-(void)setNavConView
{
    TPMyStoreTableViewController *tableVc0 = [[TPMyStoreTableViewController alloc]init];
    tableVc0.financialType = 1;
    TPMyStoreTableViewController *tableVc1 =  [[TPMyStoreTableViewController alloc]init];
    tableVc1.financialType = 2;
    TPMyStoreTableViewController *tableVc2 =  [[TPMyStoreTableViewController alloc]init];
    tableVc2.financialType = 3;
    _tableVc0 = tableVc0;
    _tableVc1 = tableVc1;
    _tableVc2 = tableVc2;
    NSArray *childArr = @[tableVc0, tableVc1,tableVc2];
    CGFloat contentViewHeight = KHeight - StatusBarAndNavigationBarHeight - TAB_BAR_HEIGHT + (iPhoneX ? 10:0);
    self.pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight+44, KWidth, contentViewHeight) parentVC:self childVCs:childArr];
    _pageContentScrollView.delegatePageContentScrollView = self;
    [self.view addSubview:_pageContentScrollView];
}

-(void)setNavTitleView
{
    NSArray *titleArr = @[@"计息中", @"待提取",@"已提取"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorStyle =  SGIndicatorStyleDefault;
    configure.indicatorColor = TP59Color;
    configure.titleColor = TP8EColor;
    [configure setTitleSelectedColor:TP59Color];
    configure.titleFont = FONT(15);
    configure.showBottomSeparator = NO;
    configure.needBounces = NO;
  
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, self.customNavBar.height, KWidth, 44) delegate:self titleNames:titleArr configure:configure];

    [self.view addSubview:_pageTitleView];
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
