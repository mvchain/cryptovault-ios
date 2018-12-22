//
//  TPAddTokenViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/21.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPAddTokenViewController.h"
#import "TPAddTokenCell.h"
#import "TPCurrencyList.h"
@interface TPAddTokenViewController ()
@property (nonatomic, strong)TPCurrencyList *currencyList;
@property (nonatomic, strong) NSMutableArray *assetNameArr;

@property (nonatomic, strong) NSMutableArray *addTokenIdArr;
@property (nonatomic, strong) NSMutableArray *removeTokenIdArr;
//@property (nonatomic, copy) NSMutableString *addToken, *removeToken;
@end

@implementation TPAddTokenViewController

static NSString  *TPAddTokenCellId = @"addTokenCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.addTokenIdArr = [NSMutableArray array];
    self.removeTokenIdArr = [NSMutableArray array];
    
    
    self.assetNameArr = [NSMutableArray array];
    for (int i = 0 ; i < self.assetTopic.count; i++)
    {
        TPAssetModel *asset = self.assetTopic[i];
        [self.assetNameArr addObject:asset.tokenName];
    }
    
    YYCache *listCache = [YYCache cacheWithName:TPCacheName];
    self.currencyList = (TPCurrencyList *)[listCache objectForKey:TPCurrencyListKey];

    [self setupNavigation];
    
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(@(StatusBarAndNavigationBarHeight));
         make.left.equalTo(@0);
         make.width.equalTo(@(KWidth));
         make.height.equalTo(@(KHeight - StatusBarAndNavigationBarHeight));
     }];
}

-(void)setupNavigation
{

//    [self showSystemNavgation:YES];
//    self.navigationItem.title = @"添加币种";
    self.customNavBar.title = @"添加币种";
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightClick) image:[UIImage imageNamed:@"serch_icon_black"]];
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"serch_icon_black"]];
    [self.customNavBar setOnClickRightButton:^
    {
         NSLog(@"搜索");
    }];
}


-(void)rightClick
{
    NSLog(@"搜索");
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.currencyList.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPAddTokenCell *cell = [tableView dequeueReusableCellWithIdentifier:TPAddTokenCellId];
    if (!cell)
        cell = [[TPAddTokenCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPAddTokenCellId withfilterData:self.assetNameArr];
    cell.clData = self.currencyList.data[indexPath.row];
    
    __block TPAddTokenCell *addTokenCell = cell;
    
    cell.operatingBlock = ^(BOOL isAdd, NSString *tokenId, NSString * tokenName)
    {
        [self operatingCurrencyIsAdd:isAdd WithTokenId:tokenId WithName:tokenName WithSelectCell:addTokenCell];
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

#pragma mark - 添加 移除 币种事件
-(void)operatingCurrencyIsAdd:(BOOL)isAdd WithTokenId:(NSString *)tokenId WithName:(NSString *)tokenName WithSelectCell:(TPAddTokenCell *)cell
{
    if (isAdd == NO)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:TPString(@"确定移除%@?",tokenName) preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *resetAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
          {
              cell.isRemoveToken = YES;
              
              [self sendTokenClcikAdd:@"" removeToken:tokenId];
          }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        //添加顺序和显示顺序相同
        [alertController addAction:cancelAction];
        [alertController addAction:resetAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return ; 
    }
        else
    {
        [self sendTokenClcikAdd:tokenId removeToken:@""];
    }
}


-(void)sendTokenClcikAdd:(NSString *)addToken removeToken:(NSString *)removeToken
{
    [[WYNetworkManager sharedManager] sendPutRequest:WYJSONRequestSerializer url:@"asset" parameters:@{@"addTokenIdArr":addToken,@"removeTokenIdArr":removeToken} success:^(id responseObject, BOOL isCacheObject)
       {
           if ([responseObject[@"code"] isEqual:@200])
           {
               
               [TPNotificationCenter postNotificationName:TPPutCurrencyNotification object:nil];

               NSLog(@"修改币种成功");
           }
       }
           failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
       {
//           NSLog(@"修改币种失败");
           [SVProgressHUD showErrorWithStatus:@"修改币种操作失败,请稍后尝试"];
       }];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}



-(void)dealloc
{
    [TPNotificationCenter removeObserver:self];
}


@end
