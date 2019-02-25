//
//  TPMyStoreTableViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/22.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPMyStoreTableViewController.h"
#import "MyStoreItemModel.h"
#import "TPMyStoreItemCellEntity.h"

#import "TPNoMoreTableViewCellEntity.h"
@interface TPMyStoreTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
yudef_property_strong(NSMutableArray<YUCellEntity *>, dataArrays);

@end

@implementation TPMyStoreTableViewController
#pragma mark sys
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setResresh];
    [self.tableView noSeparatorLine];
    [self.tableView.mj_header beginRefreshing];
    
}
- (void)setResresh {
     __weak typeof (self) wsf = self;
    [self.tableView addHeaderWithBlock:^(MJRefreshHeader *header) {
        [wsf firstPage];
    }];
    [self.tableView addFooterWithBlock:^(MJRefreshFooter *fotter) {
        [wsf nextPage];
    }];
}
- (void)firstPage {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self getMystoreListWithLastId:0 complete:^(bool isSucc) {
        if(self.dataArrays.count ==0 ){
            TPNoMoreTableViewCellEntity *nomore = [[TPNoMoreTableViewCellEntity alloc]init];
            [self.dataArrays addObject:nomore];
            [self.tableView reloadData];
        }
    }];
}
- (void)nextPage {
    if(self.dataArrays.count == 0)return;
    MyStoreItemModel *  lastItem = (MyStoreItemModel*)  self.dataArrays.lastObject.data;
    [self getMystoreListWithLastId:lastItem.idField complete:^(bool isSucc) {
    }];
    
}
- (void)getMystoreListWithLastId:(NSInteger) lastId complete:(void(^)(bool isSucc))complete {
    NSDictionary *postDict = @{@"id":@(lastId),@"financialType":@(self.financialType),@"pageSize":@10};
    __weak typeof (self) wsf = self;
    [[WYNetworkManager sharedManager]sendGetRequest:WYJSONRequestSerializer url:@"financial/partake" parameters:postDict success:^(id responseObject, BOOL isCacheObject) {
        NSDictionary *res = (NSDictionary *)responseObject;
        
        if( [res[@"code"] intValue] == 200 ) {
            if(lastId ==0) {
                wsf.dataArrays = [[NSMutableArray<YUCellEntity *> alloc]init];
            }
            NSArray *datas = res[@"data"];
            for (NSDictionary *dic in res[@"data"]) {
                MyStoreItemModel *model = [[MyStoreItemModel alloc] initWithDictionary:dic];
                TPMyStoreItemCellEntity *en = [[TPMyStoreItemCellEntity alloc] init];
                en.financialType = self.financialType;
                en.data = model;
                [wsf.dataArrays addObject:en];
            }
            if (datas.count<10) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else {
                [self.tableView.mj_footer endRefreshing];
            }
        }else {
            [self showErrorText:TPString(@"错误%@",res[@"message"])];
            [self.tableView.mj_footer endRefreshing];
            
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        complete(YES);
        
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        [self showErrorText:@"网络错误"];
        [self.tableView.mj_header endRefreshing];
         complete(NO);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView cellByIndexPath:indexPath dataArrays:self.dataArrays];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   YUCellEntity *en =  self.dataArrays[indexPath.row];
    return en.yu_cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.onTableViewDidSelect){
        self.onTableViewDidSelect((MyStoreItemModel *)self.dataArrays[indexPath.row].data, self.financialType);
        
    }
}
#pragma mark lazy
yudef_lazyLoad(NSMutableArray<YUCellEntity *>, dataArrays, _dataArrays)

@end
