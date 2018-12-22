//
//  TPCFTopicViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/13.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPCFTopicViewController.h"
#import "TPBuyTokenViewController.h"
#import "TPCrowdConfig.h"
#import "TPCrowdfundCell.h"
#import "TPCroRecordModel.h"
#import "TPCrowdfundingModel.h"
#import "CountDown.h"
@interface TPCFTopicViewController ()
@property (nonatomic, strong) NSArray <TPCrowdfundingModel *> *croTopic;
@property (nonatomic, strong) NSArray <TPCroRecordModel *> *croRecordTopic;

@property (nonatomic, strong) CountDown *countD;

@property (nonatomic)NSInteger proType;

@end

@implementation TPCFTopicViewController

static NSString  *TPReservationCellCellId = @"ReservationCell";

-(TPCrowdfundStyle)type
{
    return 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.countD = [CountDown new];
    self.customNavBar.hidden = YES;
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTableView.backgroundColor = TPF6Color;
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(0);
         make.left.mas_equalTo(0);
         make.width.equalTo(@(KWidth));
         make.height.mas_equalTo(KHeight - StatusBarAndNavigationBarHeight - TAB_BAR_HEIGHT -  40);
//
     }];
    
    
    switch (self.type)
    {
            /** 预约 */
        case TPCrowdfundStyleReservation:
            self.proType = 1;
            break;
            
            /** 即将 */
        case TPCrowdfundStyleComingSoon:
            self.proType = 0;
            break;
            
            /** 已结束 */
        case TPCrowdfundStyleEnd:
            self.proType = 2;
            break;
            
            /** 记录 */
        case TPCrowdfundStyleRecord:
            self.proType = 3;
            break;
        default:
            break;
    }
    
    [self setupRefreshWithShowFooter:NO];
}

-(void)loadNewTopics
{
    if (self.proType == 3)
    {
        [self getRequestProjectReservation:self.proType];
    }
    else
    {
        [self getRequestProject:self.proType];
    }
}

/*
 * 获取项目列表
 */
-(void)getRequestProject:(NSInteger)proType
{
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"project" parameters:@{@"projectId":@"0",@"projectType":@(proType),@"type":@0,@"pageSize":@"10"} success:^(id responseObject, BOOL isCacheObject)
     {
         if ([responseObject[@"code"] isEqual:@200])
         {
             self.croTopic = [TPCrowdfundingModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
             if (self.croTopic.count == 0)
             {
                 [self showNoDataView:YES];
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
         NSLog(@"获取项目列表失败");
         RefreshEndHeader
     }];
}

/*
 * 获取众筹记录
 */
-(void)getRequestProjectReservation:(NSInteger)proType
{
    self.customNavBar.hidden = NO;
    self.customNavBar.title = @"众筹记录";
    
    
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"project/reservation" parameters:@{@"id":@"0",@"pageSize":@"10",@"type":@"0"} success:^(id responseObject, BOOL isCacheObject)
    {
        if ([responseObject[@"code"] isEqual:@200])
        {
            NSLog(@"获取参与的项目：%@",responseObject[@"data"]);
            
            self.croRecordTopic = [TPCroRecordModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if (self.croRecordTopic.count == 0)
                [self showNoDataView:YES];
            else
            {
                [self.baseTableView reloadData];
                [self.baseTableView mas_updateConstraints:^(MASConstraintMaker *make)
                 {
                     make.height.mas_equalTo(KHeight - StatusBarAndNavigationBarHeight);
                 }];
            
            }
            RefreshEndHeader
            NSLog(@"获取参与的项目列表成功");
        }
    }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
    {
        RefreshEndHeader
        NSLog(@"获取参与的项目列表失败");
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.croTopic.count ? self.croTopic.count:self.croRecordTopic.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPCrowdfundCell *cell = [tableView dequeueReusableCellWithIdentifier:TPReservationCellCellId];
    if (!cell)
        cell = [[TPCrowdfundCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPReservationCellCellId WithStyle:self.type countD:self.countD];
    
    
    
    if (self.croTopic.count)
    {
        cell.croModel = self.croTopic[indexPath.row];
    }
        else
    {
        cell.croRecordModel = self.croRecordTopic[indexPath.row];
    }
    
    cell.comView.participateBlock =
    ^{
        TPBuyTokenViewController *buyTokenVC = [[TPBuyTokenViewController alloc] initWithCroModel:self.croTopic[indexPath.row]];
        [self.navigationController pushViewController:buyTokenVC animated:YES];
    };
    
    cell.tag = indexPath.row;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == TPCrowdfundStyleRecord)
    {
        return  210;
    }
        else
    {
        return  220;
    }
}

-(void)dealloc
{
    [self.countD destoryTimer];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    TPBuyTokenViewController *buyTokenVC = [[TPBuyTokenViewController alloc] init];
//    [self.navigationController pushViewController:buyTokenVC animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
