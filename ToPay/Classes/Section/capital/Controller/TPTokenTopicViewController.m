//
//  TPTokenTopicViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/15.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPTokenTopicViewController.h"
#import "TPTokenCell.h"
#import "TPTokenTopic.h"
#import "TPTransDetailViewController.h"
@interface TPTokenTopicViewController ()

@property (nonatomic, copy) NSString *tokenId;
@property (nonatomic) TPTransactionType transType;

@property (nonatomic, strong) NSMutableArray <TPTokenTopic *> *tokenTopics;

@end

@implementation TPTokenTopicViewController

static NSString  *TPTokenCellCellId = @"tokenCell";

- (instancetype)initWithTokenId:(NSString *)tokenId WithTransactionType:(TPTransactionType)type
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _tokenId = tokenId;
        _transType = type;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.customNavBar.hidden = YES;
    
//    [self setupRequestTransactions];
    
    
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.width.equalTo(@(KWidth));
        make.height.equalTo(@(KHeight - 174 - 44));
    }];
    
    [TPNotificationCenter addObserver:self selector:@selector(takeOutSuccessNoti) name:TPTakeOutSuccessNotification object:nil];
    [self setupRefreshWithShowFooter:YES];
}

-(void)takeOutSuccessNoti
{
    [self loadNewTopics];
}


-(void)loadNewTopics
{
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"asset/transactions" parameters:@{
                    @"tokenId":_tokenId,
                    @"transactionType":_transType == TPTransactionTypeTransfer ? @1 : (_transType == TPTransactionTypeTransferOut ? @2:@0),
                    @"type":@"0"} success:^(id responseObject, BOOL isCacheObject)
    {
        if ([responseObject[@"code"] isEqual:@200])
        {
//            NSLog(@"<<<<  %@  >>>>",responseObject[@"data"]);
            self.tokenTopics = [TPTokenTopic mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if (self.tokenTopics.count == 0)
            {
                self.isNomoreData = YES;
            }
                else
            {
                self.isNomoreData = NO;
                
            }
            [self.baseTableView reloadData];
             [self.baseTableView.mj_footer endRefreshing];
            RefreshEndHeader
            
            
        }
    }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
    {
        NSLog(@"error:%@",error);
        RefreshEndHeader
    }];
}

- (void)loadMoreTopics {
    if ( !self.tokenTopics ) {
        return;
    }
    TPTokenTopic *lastTopic =  self.tokenTopics.lastObject;
    if( !lastTopic ) return;
    NSDictionary * dic = @{
                           @"tokenId":_tokenId,
                           @"transactionType":_transType == TPTransactionTypeTransfer ? @1 : (_transType == TPTransactionTypeTransferOut ? @2:@0),
                           @"type":@"1",@"id":@([lastTopic.id integerValue]),@"pageSize":@10 };

    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"asset/transactions" parameters:dic success:^(id responseObject, BOOL isCacheObject)
     {
         if ([responseObject[@"code"] isEqual:@200])
         {
             NSMutableArray *marr = [TPTokenTopic mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
             if ( marr.count > 0  ) {
                 
                  [self.tokenTopics addObjectsFromArray:marr];
                  [self.baseTableView.mj_footer endRefreshing];
             }else
             {
                 [self.baseTableView.mj_footer endRefreshingWithNoMoreData];
             }
            
             [self.baseTableView reloadData];
           
         }
     }
                                             failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
     {
         NSLog(@"error:%@",error);
          RefreshEndFooter
     }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if( self.isNomoreData ) {
        return 1;
    }
    return self.tokenTopics.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( self.isNomoreData ) {
        
        return [tableView cellByIndexPath:indexPath dataArrays:self.noMoreDataArray];
        
    }
    TPTokenCell *cell = [tableView dequeueReusableCellWithIdentifier:TPTokenCellCellId];
    if (!cell)
        cell = [[TPTokenCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPTokenCellCellId];
    cell.tokenTopic = self.tokenTopics[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( self.isNomoreData ) {
        return 200;
    }
    return  64;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPTransDetailViewController *transDetailVC = [[TPTransDetailViewController alloc] init];
    transDetailVC.tokenTopic = self.tokenTopics[indexPath.row];
    [self.navigationController pushViewController:transDetailVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
