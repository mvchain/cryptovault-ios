//
//  TPUSDTViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/22.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPUSDTViewController.h"
#import "TPUSDTCell.h"
#import "TPTransactionModel.h"
#import "TPSellViewController.h"
@interface TPUSDTViewController ()

@property (nonatomic) NSInteger pairId;
@property (nonatomic, copy) NSString *transactionType;
@property (nonatomic, strong) NSMutableArray <TPTransactionModel *> *transactionTopic;
@end

@implementation TPUSDTViewController

static NSString  *TPUSDTCellId = @"USDTCell";

- (instancetype)initWithPairId:(NSString *)pairId WithTransactionType:(NSString *)transactionType
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        self.pairId = [pairId doubleValue];
        self.transactionType = transactionType;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.transactionTopic = [NSMutableArray<TPTransactionModel *> array];
    
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(@0);
         make.left.equalTo(@0);
         make.width.equalTo(@(KWidth));
         make.height.equalTo(self.view.mas_height);
     }];
   
    
    [self setupRefreshWithShowFooter:YES];

    [TPNotificationCenter addObserver:self selector:@selector(loadNewTopics) name:TPTakeOutSuccessNotification object:nil];
    
    self.customNavBar.hidden = YES;
    self.baseTableView.backgroundColor = [UIColor whiteColor];
}

-(void)loadNewTopics
{
    [self.baseTableView.mj_footer endRefreshing];
    
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"transaction" parameters:
     @{@"pageSize":@(10),
       @"pairId":@(self.pairId),
       @"transactionType":self.transactionType,
       @"type":@"0"} success:^(id responseObject, BOOL isCacheObject)
     {
         if ([responseObject[@"code"] isEqual:@200])
         {
             NSLog(@"%@",responseObject[@"data"]);
             self.transactionTopic = [TPTransactionModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
             
             if (self.transactionTopic.count == 0)
             {
                 [self showNoDataView:YES];

                 [self.noDataView mas_updateConstraints:^(MASConstraintMaker *make)
                 {
                     make.centerY.equalTo(self.view);
                 }];
             }
                else
             {
                 [self.baseTableView reloadData];
             }
             
             RefreshEndHeader
         }
     }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
     {
         NSLog(@" 获取挂单列表失败：error = %@", error);
         RefreshEndHeader
     }];
}

-(void)loadMoreTopics
{
    if( !( self.transactionTopic && self.transactionTopic.count >0 ) ) {
        [self.baseTableView.mj_footer endRefreshing];
        return;
    }
    TPTransactionModel *transM =  self.transactionTopic[self.transactionTopic.count-1];
    NSDictionary *dict =  @{@"id":transM.id,
                            @"pageSize":@(10),
                            @"pairId":@(self.pairId),
                            @"transactionType":self.transactionType,
                            @"type":@"1"};
    NSLog(@"%@",dict);
    
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"transaction" parameters:
     dict success:^(id responseObject, BOOL isCacheObject)
     {
         
         
         if ([responseObject[@"code"] isEqual:@200])
         {
             NSLog(@"%@",responseObject[@"data"]);
             
             NSMutableArray<TPTransactionModel *> *moreTopic = nil;
             
             moreTopic = [TPTransactionModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
             
             if (moreTopic.count == 0)
             {
                // [self showInfoText:@"数据已经拉到底了"];
                 [self.baseTableView.mj_footer endRefreshingWithNoMoreData];
                 
             }
                else
             {
                 [self.transactionTopic addObjectsFromArray:moreTopic];
                 [self.baseTableView reloadData];
                 RefreshEndFooter
             }
             
         }
     }
         failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
     {
         NSLog(@" 获取挂单列表失败：error = %@", error);
         RefreshEndFooter
     }];
}



#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.transactionTopic.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPUSDTCell *cell = [tableView dequeueReusableCellWithIdentifier:TPUSDTCellId];
    if (!cell)
        cell = [[TPUSDTCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPUSDTCellId transType:self.transactionType tokenName:self.tokenName];
    cell.transModel = self.transactionTopic[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int transType =  [self.transactionType  isEqualToString: @"1"] ?2:1;
    TPSellViewController *sellVC = [[TPSellViewController alloc] initWithPairId:TPString(@"%ld",(long)self.pairId)  WithTransType:transType publish:NO];
    sellVC.currName = self.currName;
    sellVC.cData = self.cData;
    sellVC.transModel = self.transactionTopic[indexPath.row];
    sellVC.isFromTableView = YES;
    [self.navigationController pushViewController:sellVC animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [QuickDo prettyTableViewCellSeparate:@[@(self.transactionTopic.count -1)] cell:cell indexPath:indexPath]; // 美观分割线
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



@end
