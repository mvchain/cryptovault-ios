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
@interface TPUSDTViewController ()

@property (nonatomic) NSInteger pairId;
@property (nonatomic, copy) NSString *transactionType;
@property (nonatomic, strong) NSArray <TPTransactionModel *> *transactionTopic;
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
    
    
    NSLog(@"self.pairId：%ld",(long)self.pairId);
//    self.transactionType
    NSLog(@"transactionType：%@",self.transactionType);
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
            [self.baseTableView reloadData];
        }
    }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
    {
        NSLog(@" 获取挂单列表失败：error = %@", error);
    }];
    
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(@0);
         make.left.equalTo(@0);
         make.width.equalTo(@(KWidth));
         make.height.equalTo(self.view.mas_height);
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
        cell = [[TPUSDTCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPUSDTCellId];
    cell.transModel = self.transactionTopic[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



@end
