
//
//  TPVRTViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/13.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPVRTViewController.h"
#import "TPVRTCell.h"
#import "TPVRTModel.h"
#import "TPTranDetailViewController.h"
@interface TPVRTViewController ()

@property (nonatomic, strong) NSArray <TPVRTModel *> *VRTTopic;

@property (nonatomic) TPTransactionStyle transactionStyle;

@end

@implementation TPVRTViewController

static NSString  *TPVRTCellId = @"VRTCell";

- (instancetype) initWithChainStyle:( TPTransactionStyle )transactionStyle;
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _transactionStyle = transactionStyle;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"transaction/pair" parameters:@{@"pairType":_transactionStyle == TPTransactionStyleVRT ? @1:@2} success:^(id responseObject, BOOL isCacheObject)
    {
//        NSLog(@"responseObject = %@", responseObject);
        if ([responseObject[@"code"] isEqual:@200])
        {
            self.VRTTopic = [TPVRTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];            
            [self.baseTableView reloadData];
        }
        
    }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
    {
        NSLog(@"error = %@", error);
    }];
    
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.equalTo(@(KWidth));
        make.height.mas_equalTo(KHeight);
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.VRTTopic.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPVRTCell *cell = [tableView dequeueReusableCellWithIdentifier:TPVRTCellId];
    if (!cell)
        cell = [[TPVRTCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPVRTCellId];
    
    cell.VRTModel = self.VRTTopic[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPTranDetailViewController *tranDetailVC = [[TPTranDetailViewController alloc] init];
    tranDetailVC.vrtTopic = self.VRTTopic[indexPath.row];
    [self.navigationController pushViewController:tranDetailVC animated:YES];
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
