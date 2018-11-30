//
//  TPCapitalViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/10.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPCapitalViewController.h"
#import "TPTokenKindViewController.h"
#import "TPNotiViewController.h"
#import "TPAddTokenViewController.h"
#import <WRNavigationBar/WRCustomNavigationBar.h>
#import "BCQMView.h"
#import "TPCurrencyRatio.h"

#import "TPAssetModel.h"
#import "TPCapitalCell.h"
#import "TPCapitalHeaderView.h"

#define NAVBAR_COLORCHANGE_POINT (-IMAGE_HEIGHT + StatusBarAndNavigationBarHeight*2)

#define IMAGE_HEIGHT 260

@interface TPCapitalViewController ()
@property (nonatomic, strong)  NSMutableArray<TPAssetModel *> *assetTopic;
@property (nonatomic, strong) TPCapitalHeaderView * headerView;

@property (nonatomic,strong) BCQMView *qmView;
@property (nonatomic) CGFloat ratio;
@end

@implementation TPCapitalViewController

static NSString  *TPCapitalCellCellId = @"CapitalCell";

-(BCQMView *)qmView
{
    if (!_qmView)
    {
        YYCache *listCache = [YYCache cacheWithName:TPCacheName];
        NSArray *listArr = (NSArray *)[listCache objectForKey:TPCurrencyRatioKey];
        
        _qmView = [[BCQMView alloc]initWithFrame:CGRectMake(KWidth /2 - 100/2,StatusBarAndNavigationBarHeight+ 60, 100, listArr.count * 36) style:UITableViewStylePlain];
        _qmView.layer.cornerRadius = 6;
        _qmView.layer.borderWidth = 1;
        _qmView.layer.borderColor = TPMainColor.CGColor;
        NSMutableArray *titArray = [NSMutableArray array];
        
        for (int i = 0 ; i <listArr.count ; i++)
        {
            TPCurrencyRatio *ratio = listArr[i];
            [titArray addObject:ratio.tokenName];
        }
        _qmView.titArr = titArray;
        
        TPWeakSelf;
        [self.qmView setShowMenuBlock:^(NSInteger currentIndex)
        {
            TPCurrencyRatio *ratioM = listArr[currentIndex];
            weakSelf.headerView.ratio = ratioM.ratio;
            weakSelf.headerView.nickName = ratioM.tokenName;
            weakSelf.ratio = ratioM.ratio;
            [weakSelf.baseTableView reloadData];
        }];
    }
    return _qmView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavgation];
    
    [self setNavBackImage];
    
    [self setUpTableView];
    
    [self balanceRequest];
    [self assetRequest];
}


-(void)assetRequest
{
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"asset" success:^(id responseObject, BOOL isCacheObject)
    {
        if ([responseObject[@"code"] isEqual:@200])
        {
            self.assetTopic = [TPAssetModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.baseTableView reloadData];
//            NSLog(@"self.assetTopic:%@",self.assetTopic);
        }
    }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
    {
        NSLog(@"error = %@", error);
    }];
}

-(void)balanceRequest
{
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"asset/balance" success:^(id responseObject, BOOL isCacheObject)
    {
        if ([responseObject[@"code"] isEqual:@200])
        {
//            NSLog(@"responseObject:%@",responseObject[@"data"]);
            [USER_DEFAULT setObject:responseObject[@"data"] forKey:TPBalanceDefaultKey];
            self.headerView.total = TPString(@"%@",responseObject[@"data"]);
        }
    }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
    {
        NSLog(@"error = %@", error);
    }];
}


-(void)setUpTableView
{
    TPCapitalHeaderView *headerView = [[TPCapitalHeaderView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    headerView.height = 142;
    self.headerView = headerView;
    self.baseTableView.tableHeaderView = headerView;
    self.baseTableView.backgroundColor = [UIColor clearColor];
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTableView.bounces = NO;
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(@(StatusBarAndNavigationBarHeight));
         make.left.equalTo(@0);
         make.width.equalTo(@(KWidth));
         make.height.equalTo(@(KHeight - StatusBarAndNavigationBarHeight - TAB_BAR_HEIGHT));
     }];
    
    headerView.chooseCurrencyBlock = ^{
        [self.qmView showMenuWithAnimation:YES];
    };
    
    
}

-(void)setNavBackImage
{
    UIImageView *navBack = [YFactoryUI YImageViewWithimage:[UIImage imageNamed:@"bg_nav_1"]];
    [self.view addSubview:navBack];
    [navBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@0);
        make.width.equalTo(@(KWidth));
        make.height.equalTo(@198);
    }];
    [self.view sendSubviewToBack:navBack];
}


-(void)setNavgation
{
    [self showSystemNavgation:NO];
    self.customNavBar.title = @"个人中心";
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    self.customNavBar.barBackgroundColor = TPMainColor;
    [self.customNavBar wr_setBottomLineHidden:YES];
    [self.customNavBar wr_setBackgroundAlpha:0];
    
    
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"note_icon_1"]];
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"add_icon_white"]];
    
    TPWeakSelf;
    [self.customNavBar setOnClickLeftButton:^
    {
        TPNotiViewController *notiVC = [[TPNotiViewController alloc] init];
        [weakSelf.navigationController pushViewController:notiVC animated:YES];
    }];
    
    [self.customNavBar setOnClickRightButton:^{
        TPAddTokenViewController *tokenVC = [[TPAddTokenViewController alloc] init];
        [weakSelf.navigationController pushViewController:tokenVC animated:YES];
    }];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.assetTopic.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPCapitalCell *cell = [tableView dequeueReusableCellWithIdentifier:TPCapitalCellCellId];
    if (!cell)
        cell = [[TPCapitalCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPCapitalCellCellId];
    cell.assetModel = self.assetTopic[indexPath.row];
    
    if (self.ratio)
    {
        cell.ratio = self.ratio;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    TPTokenKindViewController *kindVC = [[TPTokenKindViewController alloc] init];
    [self.navigationController pushViewController:kindVC animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        CGFloat alpha =  offsetY /100;

        [self.customNavBar wr_setBackgroundAlpha:alpha];
    }
    else
    {
        [self.customNavBar wr_setBackgroundAlpha:0];
    }
}

@end
