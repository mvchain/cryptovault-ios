//
//  TPBuyTopicViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/23.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPBuyTopicViewController.h"
#import "TPRecordModel.h"
#import "TPFliterModel.h"
#import "TPVRTModel.h"
@interface TPBuyTopicViewController ()
@property (nonatomic) TPStatusStyle statusStyle;

@property (nonatomic, strong) NSMutableArray <TPRecordModel *> *recordTopic;

@property (nonatomic, strong) NSMutableDictionary *param;
@property (nonatomic ,strong) TPFliterModel *fliterModel ;

@property (nonatomic, strong) NSMutableArray <TPVRTModel *> *pairTopic;
@property (nonatomic ,assign) BOOL alreadyViewDidload;

@end

@implementation TPBuyTopicViewController

static NSString  *TPBuyTopicCellId = @"buyTopicCell";

- (instancetype) initWithChainStyle:(TPStatusStyle)statusStyle
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _statusStyle = statusStyle;
        _param = [NSMutableDictionary dictionary];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondsToNotification:) name:Notifi_Name_Filter object:nil];
        _alreadyViewDidload = NO;
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.customNavBar.hidden = YES;
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(@0);
         make.top.equalTo(@0);
         make.width.equalTo(@(KWidth));
         make.height.equalTo(self.view.mas_height);
     }];
    YYCache *listCache = [YYCache cacheWithName:TPCacheName];
    NSArray *balanceArr = (NSArray *)[listCache objectForKey:TPPairBalanceKey];
    NSArray *VRTArr = (NSArray *)[listCache objectForKey:TPPairVRTKey];
    self.pairTopic = [NSMutableArray array];
    [self.pairTopic addObjectsFromArray:balanceArr];
    [self.pairTopic addObjectsFromArray:VRTArr];
    [self setupRefreshWithShowFooter:YES];
    [self loadNewTopics];
    
    _alreadyViewDidload = YES;
    
    
}
- (void)respondsToNotification:(NSNotification *)noti {
    id obj = noti.object;
    NSDictionary *dic = noti.userInfo;
    _fliterModel = dic[@"data"];
    if( _alreadyViewDidload ) {
        [self.baseTableView.mj_header beginRefreshing];
    }
   // NSLog(@"\n- self:%@ \n- obj:%@ \n- notificationInfo:%@", self, obj, dic);
}


-(void)loadNewTopics
{
    self.param[@"pageSize"] = @"10";
    self.param[@"status"] = @(self.statusStyle);
    self.param[@"type"] = @"0";
    if( self.fliterModel ) {
        self.param[@"transactionType"] = self.fliterModel.transcationType;
        self.param[@"pairId"] = self.fliterModel.pairId;
    }
//    if (self.pairId)
//    {
//        self.param[@"pairId"] = self.pairId;
//    }
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"transaction/partake" parameters:self.param success:^(id responseObject, BOOL isCacheObject)
     {
         if ([responseObject[@"code"] isEqual:@200])
         {
             NSLog(@"responseObject:%@",responseObject[@"data"]);
             
             self.recordTopic = [TPRecordModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
             if (self.recordTopic.count == 0)
             {
                  self.isNomoreData = YES;
             }
                else
             {
                 self.isNomoreData = NO;
                
             }
            [self.baseTableView reloadData];
            RefreshEndHeader
            RefreshEndFooter
         }
         else
             [self showErrorText:responseObject[@"message"]];
     }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
     {

         [self showErrorText:@"筛选参与订单失败"];
         RefreshEndHeader
         RefreshEndFooter
     }];
}

-(void)loadMoreTopics
{
    self.param[@"pageSize"] = @"10";
    self.param[@"status"] = @(self.statusStyle);
    self.param[@"type"] = @"1";
    if ( self.recordTopic.count <=0 ) {
        [self.baseTableView.mj_footer endRefreshingWithNoMoreData];
        
        return;
    }
    TPRecordModel *recordM = self.recordTopic[self.recordTopic.count - 1];
    self.param[@"id"] = recordM.id;
    if( self.fliterModel ) {
        self.param[@"transactionType"] = self.fliterModel.transcationType ;
        self.param[@"pairId"] = self.fliterModel.pairId;
    }
//    if (self.pairId)
//    {
//        self.param[@"pairId"] = self.pairId;
//    }
    
    
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"transaction/partake" parameters:self.param success:^(id responseObject, BOOL isCacheObject)
     {
         if ([responseObject[@"code"] isEqual:@200])
         {
             NSLog(@"responseObject:%@",responseObject[@"data"]);
             
             NSArray *recordTop;
             
             recordTop = [TPRecordModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
             if (recordTop.count == 0)
             {
                 [self showInfoText:@"数据已经拉到底了"];
             }
             else
             {
                 [self.recordTopic addObjectsFromArray:recordTop];
                 [self.baseTableView reloadData];
             }
             RefreshEndFooter
         }
         else
             [self showErrorText:responseObject[@"message"]];
     }
                                             failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
     {
         [self showErrorText:@"筛选参与订单失败"];
         RefreshEndFooter
     }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( self.isNomoreData ) {
        return 1;
    }
    
    return self.recordTopic.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ( self.isNomoreData ) {
        
        return  [tableView cellByIndexPath:indexPath dataArrays:self.noMoreDataArray];
        
    }
    
    TPProcessingCell *cell = [tableView dequeueReusableCellWithIdentifier:TPBuyTopicCellId];
    if (!cell)
        cell = [[TPProcessingCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPBuyTopicCellId WithStyle:_statusStyle pairArr:self.pairTopic];
   
    cell.record = self.recordTopic[indexPath.row];
    __block TPProcessingCell *proCell = cell;
    cell.withdrawalBlock = ^
    {
        [self withdrawalAlert:proCell index:indexPath tableView:tableView];
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

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)withdrawalAlert:(TPProcessingCell *)proCell index:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"撤单" message:@"您确定要撤销该单？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *resetAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
    {
        [self postWithdrawalRequest:proCell index:indexPath tableView:tableView];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    //添加顺序和显示顺序相同
    [alertController addAction:cancelAction];
    [alertController addAction:resetAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)postWithdrawalRequest:(TPProcessingCell *)proCell index:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    [[WYNetworkManager sharedManager]sendDeleteRequest:WYJSONRequestSerializer url:TPString(@"transaction/%@",proCell.record.id) parameters:@{@"id":proCell.record.id} success:^(id responseObject, BOOL isCacheObject)
     {
         if ([responseObject[@"code"] isEqual:@200])
         {
             NSLog(@"撤单成功");
             [self showSuccessText:@"已经撤单"];
             [self.recordTopic removeObjectAtIndex:indexPath.row];
             [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic]; //删除对应数据的cell
         }
            else
         {
             [self showErrorText:responseObject[@"message"]];
         }
     }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
     {
         NSLog(@"撤单失败 %@",error);
         [self showErrorText:@"撤单失败，稍后尝试"];
     }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

@end
