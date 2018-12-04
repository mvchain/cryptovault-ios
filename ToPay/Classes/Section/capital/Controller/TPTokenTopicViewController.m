//
//  TPTokenTopicViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/15.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPTokenTopicViewController.h"
#import "TPTokenCell.h"
@interface TPTokenTopicViewController ()

@end

@implementation TPTokenTopicViewController

static NSString  *TPTokenCellCellId = @"tokenCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupRequestTransactions];
    
    
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.width.equalTo(@(KWidth));
        make.height.equalTo(self.view.mas_height);
    }];
}

-(void)setupRequestTransactions
{
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"asset/transactions" parameters:@{@"tokenId":@"",@"transactionType":@"",@"type":@""} success:^(id responseObject, BOOL isCacheObject)
    {
        if ([responseObject[@"code"] isEqual:@200])
        {
//            self.assetTopic = [TPAssetModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//            [self.baseTableView reloadData];
        }
    }
        failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode)
    {
        <#code#>
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPTokenCell *cell = [tableView dequeueReusableCellWithIdentifier:TPTokenCellCellId];
    if (!cell)
        cell = [[TPTokenCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPTokenCellCellId];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  64;
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
