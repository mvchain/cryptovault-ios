//
//  TPNotiViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2018/11/15.
//  Copyright © 2018年 蒲公英. All rights reserved.
//

#import "TPNotiViewController.h"
#import "TPNotiCell.h"
#import "TPNotificationModel.h"
@interface TPNotiViewController ()

@property (nonatomic, strong) NSArray<TPNotificationModel *> *notiTopic;

@end

@implementation TPNotiViewController

static NSString  *TPNotiCellCellId = @"notiCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.customNavBar.title = @"通知";
    self.baseTableView.backgroundColor = TPF6Color;
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(@0);
        make.top.equalTo(@(StatusBarAndNavigationBarHeight));
        make.width.equalTo(@(KWidth));
        make.height.equalTo(self.view.mas_height);
    }];
    [self setupRefreshWithShowFooter:YES];
}
#pragma mark - 请求
-(void)loadNewTopics
{
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer url:@"message" parameters:@{@"pageSize":@10,@"type":@0,@"timestamp":[self getNowTimeTimestamp]} success:^(id responseObject, BOOL isCacheObject)
    {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"code"] isEqual:@200])
        {
            self.notiTopic = [TPNotificationModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if (self.notiTopic.count == 0)
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
        NSLog(@"%@",error);
        RefreshEndHeader
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.notiTopic.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPNotiCell *cell = [tableView dequeueReusableCellWithIdentifier:TPNotiCellCellId];
    if (!cell)
        cell = [[TPNotiCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TPNotiCellCellId];
    cell.notiModel = self.notiTopic[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  76;
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
