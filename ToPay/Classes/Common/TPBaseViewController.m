//
//  TPBaseViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/13.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPBaseViewController.h"
#import "TPRefreshHeader.h"
#import "TPRefreshFooter.h"
#import "TPNoMoreTableViewCell.h"
#import "TPNoMoreTableViewCellEntity.h"
@interface TPBaseViewController ()

@end
@implementation TPBaseViewController

-(WRCustomNavigationBar *)customNavBar
{
    if (_customNavBar == nil) {
        _customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    }
    return _customNavBar;
}


-(void)showSystemNavgation:(BOOL)isShow
{
   self.navigationController.navigationBar.hidden = !isShow;
}

-(void)showNoDataView:(BOOL)isShow
{
//    self.noDataView.hidden = !isShow;
//    self.baseTableView.hidden = isShow;
    self.isNomoreData = YES;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _noMoreDataArray = [[NSMutableArray alloc]init];
    TPNoMoreTableViewCellEntity *en = [[TPNoMoreTableViewCellEntity alloc]init];
    [_noMoreDataArray addObject:en];
//    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavBar];
}

-(void)setupNavBar
{
    [self.view addSubview:self.customNavBar];
    // 设置自定义导航栏标题颜色
    self.customNavBar.titleLabelColor = TP59Color;
    self.customNavBar.titleLabelFont = [UIFont fontWithName:@"PingFangSC-Semibold" size:17];//FONT(17);
    if (self.navigationController.childViewControllers.count != 1) {
        [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back_icon_black"]];
    }
    TPWeakSelf;
    [self.customNavBar setOnClickLeftButton:^
    {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}
-(UIImageView *)noDataView
{
    if (_noDataView == nil) {
        _noDataView = [YFactoryUI YImageViewWithimage:[UIImage imageNamed:@"defeat_icon"]];
        [self.view addSubview:_noDataView];
        
        [_noDataView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.centerX.equalTo(self.view);
            make.centerY.equalTo(self.view).with.offset(-70);
            make.size.equalTo(@180);
        }];
    }
    return _noDataView;
}

-(UITableView *)baseTableView
{
    if (!_baseTableView)
    {
        _baseTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _baseTableView.delegate = self;
        _baseTableView.dataSource = self;
        _baseTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _baseTableView.backgroundColor = TPF6Color;
        _baseTableView.tableFooterView = [[UIView alloc]init];
        [_baseTableView registerCell: [TPNoMoreTableViewCell class]];
        [self.view addSubview:_baseTableView];
    }
    return _baseTableView;
}

- (void)setupRefreshWithShowFooter:(BOOL)isShowFooter
{
    self.baseTableView.mj_header = [TPRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.baseTableView.mj_header beginRefreshing];
    if (isShowFooter == YES)
    {
        MJRefreshAutoNormalFooter *au =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
        au.stateLabel.hidden = YES;
        
        self.baseTableView.mj_footer = au;
        
        
    }
}

-(void)loadNewTopics
{
    NSLog(@"加载新数据");
    
   [self.baseTableView.mj_header endRefreshing];
}

-(void)loadMoreTopics
{
    NSLog(@"加载更多数据");
    [self.baseTableView.mj_footer endRefreshing];
}

#pragma mark - Orientation
//-(UIInterfaceOrientationMask)supportedInterfaceOrientations { return UIInterfaceOrientationMaskPortrait; }
//- (BOOL)shouldAutorotate {return NO;}
//-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {return UIInterfaceOrientationPortrait;}

@end
