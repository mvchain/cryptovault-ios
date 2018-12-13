//
//  TPBuyTopicViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/23.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPBuyTopicViewController.h"
#import "TPRecordModel.h"
@interface TPBuyTopicViewController ()
@property (nonatomic) TPStatusStyle statusStyle;

@property (nonatomic, strong) NSMutableArray <TPRecordModel *> *recordTopic;

@end

@implementation TPBuyTopicViewController

static NSString  *TPBuyTopicCellId = @"buyTopicCell";

- (instancetype) initWithChainStyle:(TPStatusStyle)statusStyle
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _statusStyle = statusStyle;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"transaction/partake" parameters:@{@"pageSize":@"10",
                     @"pairId":self.pairId,
                     @"status":@(self.statusStyle),
                     @"type":@"0"} success:^(id responseObject, BOOL isCacheObject)
    {
        if ([responseObject[@"code"] isEqual:@200])
        {
            NSLog(@"responseObject:%@",responseObject[@"data"]);
            
            self.recordTopic = [TPRecordModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.baseTableView reloadData];
        }
    }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
    {
        NSLog(@" 筛选已参与订单失败：error = %@", error);
    }];
    
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.width.equalTo(@(KWidth));
        make.height.equalTo(self.view.mas_height);
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recordTopic.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPProcessingCell *cell = [tableView dequeueReusableCellWithIdentifier:TPBuyTopicCellId];
    if (!cell)
        cell = [[TPProcessingCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPBuyTopicCellId WithStyle:_statusStyle];
   
    cell.record = self.recordTopic[indexPath.row];
    __block TPProcessingCell *proCell = cell;
    cell.withdrawalBlock = ^
    {
        
        [[WYNetworkManager sharedManager]sendDeleteRequest:WYJSONRequestSerializer url:TPString(@"transaction/%@",proCell.record.id) parameters:@{@"id":proCell.record.id} success:^(id responseObject, BOOL isCacheObject)
        {
            if ([responseObject[@"code"] isEqual:@200])
            {
                NSLog(@"撤单成功");
                [self.recordTopic removeObjectAtIndex:indexPath.row];
                [self.baseTableView reloadData];
            }
        }
            failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
        {
            NSLog(@"撤单失败 %@",error);
        }];
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_statusStyle == TPStatusStyleProcessing)
    return 168;
    else
    return 200;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    TPTranDetailViewController *tranDetailVC = [[TPTranDetailViewController alloc] init];
//    [self.navigationController pushViewController:tranDetailVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
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
