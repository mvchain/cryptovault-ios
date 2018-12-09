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
#import "TPExchangeRate.h"

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
        NSArray <TPExchangeRate *>*listArr = (NSArray<TPExchangeRate *> *)[listCache objectForKey:TPLegalCurrencyListKey];
        
        _qmView = [[BCQMView alloc]initWithFrame:CGRectMake(KWidth / 2 - 100 / 2,StatusBarAndNavigationBarHeight+ 60, 100, listArr.count * 36) style:UITableViewStylePlain];
        _qmView.layer.cornerRadius = 6;
        _qmView.layer.borderWidth = 1;
        _qmView.layer.borderColor = TPMainColor.CGColor;
        NSMutableArray *titArray = [NSMutableArray array];
        
        for (int i = 0 ; i <listArr.count ; i++)
        {
            TPExchangeRate *ratio = listArr[i];
            [titArray addObject:ratio.name];
        }
        _qmView.titArr = titArray;
        
        TPWeakSelf;
        [self.qmView setShowMenuBlock:^(NSInteger currentIndex)
        {
            TPExchangeRate *ratioM = listArr[currentIndex];
            weakSelf.headerView.ratio = [ratioM.value floatValue];
            weakSelf.headerView.nickName = ratioM.name;
            weakSelf.ratio = [ratioM.value floatValue];
            [weakSelf.baseTableView reloadData];
            
            [USER_DEFAULT setObject:ratioM.value forKey:TPNowLegalCurrencyKey];
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
    
    [TPNotificationCenter addObserver:self selector:@selector(currencyNotification) name:TPPutCurrencyNotification object:nil];
}

-(void)currencyNotification
{
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
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(@(StatusBarAndNavigationBarHeight));
         make.left.equalTo(@0);
         make.width.equalTo(@(KWidth));
         make.height.equalTo(@(KHeight - StatusBarAndNavigationBarHeight - TAB_BAR_HEIGHT + (iPhoneX ? 10:0)));
     }];
    
    headerView.chooseCurrencyBlock = ^{
        [self.qmView showMenuWithAnimation:YES];
    };
    
    
}

-(void)setNavBackImage
{
    UIImageView *navBack = [YFactoryUI YImageViewWithimage:[UIImage imageNamed:@"X_sta_nav_bg"]];
    [self.view addSubview:navBack];
    [navBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@0);
        make.width.equalTo(@(KWidth));
        make.height.equalTo(@(StatusBarAndNavigationBarHeight));
    }];
    [self.view sendSubviewToBack:navBack];
}


-(void)setNavgation
{
    [self showSystemNavgation:NO];
    self.customNavBar.title = @"VP Wallet";
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    self.customNavBar.barBackgroundColor = TPMainColor;
    [self.customNavBar wr_setBottomLineHidden:YES];
    [self.customNavBar wr_setBackgroundAlpha:0];
    
    
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"note_icon"]];
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"add_icon_white"]];
    
    TPWeakSelf;
    [self.customNavBar setOnClickLeftButton:^
    {
        TPNotiViewController *notiVC = [[TPNotiViewController alloc] init];
        [weakSelf.navigationController pushViewController:notiVC animated:YES];
    }];
    
    [self.customNavBar setOnClickRightButton:^{
        TPAddTokenViewController *tokenVC = [[TPAddTokenViewController alloc] init];
        tokenVC.assetTopic = weakSelf.assetTopic;
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
    kindVC.assetModel = self.assetTopic[indexPath.row];
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
