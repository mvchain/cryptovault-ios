
//
//  TPVRTViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/13.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPVRTViewController.h"
#import "TPVRTCell.h"
#import "TPMSCell.h"
#import "TPVRTModel.h"
#import "TPTranDetailViewController.h"
@interface TPVRTViewController ()

@property (nonatomic, strong) NSArray <TPVRTModel *> *VRTTopic;

@property (nonatomic) TPTransactionStyle transactionStyle;

@end

@implementation TPVRTViewController

static NSString  *TPVRTCellId = @"VRTCell";
static NSString  *TPMSCellId = @"MSCell";

- (instancetype) initWithChainStyle:( TPTransactionStyle )transactionStyle;
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _transactionStyle = transactionStyle;
    }
    return self;
}
- (void)viewWillDisappear:(BOOL)animated{
    // 覆盖，取消继承方法
}

- (void)viewWillAppear:(BOOL)animated {
       // 覆盖，取消继承方法
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(0);
         make.left.mas_equalTo(0);
         make.width.equalTo(@(KWidth));
         make.height.mas_equalTo(KHeight);
     }];
    
    
    [TPNotificationCenter addObserver:self selector:@selector(legalSwitch) name:TPLegalSwitchNotification object:nil];
    
    [self setupRefreshWithShowFooter:NO];
}
/*
 * 法币汇率切换通知
 */
-(void)legalSwitch
{
    [self.baseTableView reloadData];
}

-(void)loadNewTopics
{
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"transaction/pair" parameters:@{@"pairType":_transactionStyle == TPTransactionStyleVRT ? @1:@2} success:^(id responseObject, BOOL isCacheObject)
     {
         
         if ([responseObject[@"code"] isEqual:@200])
         {
             self.VRTTopic = [TPVRTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
             
             YYCache *listCache = [YYCache cacheWithName:TPCacheName];
             
             if (self.transactionStyle == TPTransactionStyleVRT)
             {
                 [listCache setObject:self.VRTTopic forKey:TPPairBalanceKey];
             }
                else
             {
                 [listCache setObject:self.VRTTopic forKey:TPPairVRTKey];
             }
             
             [self.baseTableView reloadData];
             RefreshEndHeader
         }
         
     }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
     {
         NSLog(@"error = %@", error);
         RefreshEndHeader
     }];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    [QuickDo prettyTableViewCellSeparate:@[@0,@2] cell:cell indexPath:indexPath]; // 美化分割线
 
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.VRTTopic.count + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        TPMSCell *msCell = [tableView dequeueReusableCellWithIdentifier:TPMSCellId];
        msCell = [[TPMSCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPMSCellId];
        return msCell;
    }
        else
    {
        TPVRTCell *cell = [tableView dequeueReusableCellWithIdentifier:TPVRTCellId];
        if (!cell)
            cell = [[TPVRTCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPVRTCellId currName:self.transactionStyle == TPTransactionStyleVRT ? @"VRT":@"余额"];
        
        cell.VRTModel = self.VRTTopic[indexPath.row - 1];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row == 0 ?  43 : 64;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)   return;
    
    TPTranDetailViewController *tranDetailVC = [[TPTranDetailViewController alloc] init];
    tranDetailVC.vrtTopic = self.VRTTopic[indexPath.row - 1];
    tranDetailVC.currName = self.transactionStyle == TPTransactionStyleVRT ? @"VRT":@"余额";
    [self.navigationController pushViewController:tranDetailVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
