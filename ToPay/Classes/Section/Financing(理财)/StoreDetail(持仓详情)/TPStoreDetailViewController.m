//
//  TPStoreDetailViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/23.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPStoreDetailViewController.h"
#import "MyStoreDetailBigInfoModel.h"
#import "TPStoreDetailProductIntroCellEntity.h"
#import "MyEveryDayIncomItemModel.h"
#import "TPNoMoreTableViewCellEntity.h"
#import "TPEveryIncomeTitleDayCellEntity.h"
#import "TPStoreEveryDayIncomeCellEntity.h"
@interface TPStoreDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *takeOutBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aylt_top;
@property (strong ,nonatomic) NSMutableArray<YUCellEntity *> *dataArrays;
@end
@implementation TPStoreDetailViewController
#pragma mark getHttpData
- (void)getParTakeDetailHttpData:(bool_id_block) complete{
//    /financial/partake/{id}
//    某理财持仓详情(传入理财记录id)
    NSString *url = TPString(@"financial/partake/%ld",(long)self.financial_id);
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer
                                                 url:url
                                             success:^(id responseObject, BOOL isCacheObject) {
                                                 NSDictionary *res = (NSDictionary *)responseObject;
                                                 if( [res[@"code"] intValue] == 200 ) {
                                                     [self initDataArray];
                                                     MyStoreDetailBigInfoModel *infoModel = [[MyStoreDetailBigInfoModel alloc]initWithDictionary:res[@"data"]];
                                                     self.dataArrays[0].data = infoModel;
                                                     complete(YES,nil);
                                                 }else {
                                                     [self showErrorText:TPString(@"错误：%@",res[@"message"])];
                                                       complete(NO,res[@"message"]);
                                                 }
                                                 
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        [self showErrorText:@"网络错误"];
        complete(NO,nil);
    }];
}

///financial/partake/{partakeId}/detail
//根据理财记录id持仓收益列表详情

- (void)getFinancialPartake:(NSInteger)pid complete:(bool_id_block)complete {
    NSString *url = TPString(@"financial/partake/%ld/detail",(long)self.financial_id);
    NSDictionary *postDict =@{@"id":@(pid),@"pageSize":@10};
    
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer
                                                 url:url
                                          parameters:postDict
                                             success:^(id responseObject, BOOL isCacheObject) {
                                                 NSDictionary *res = (NSDictionary *)responseObject;
                                                 if( [res[@"code"] intValue] == 200 ) {
                                                     NSArray *arr =res[@"data"];
                                                     for( NSDictionary *dic in arr ) {
                                                         MyEveryDayIncomItemModel *model = [[MyEveryDayIncomItemModel alloc]initWithDictionary:dic];
                                                         TPStoreEveryDayIncomeCellEntity *en = [[TPStoreEveryDayIncomeCellEntity alloc] init];
                                                         en.data = model;
                                                         [self.dataArrays addObject:en];
                                                     }
                                                     if (arr.count <10){
                                                         //　少于10,
                                                         if( arr.count ==0 && pid == 0  ){
                                                             //  无数据
                                                             TPNoMoreTableViewCellEntity *en =[[TPNoMoreTableViewCellEntity alloc] init];
                                                             en.data = @"fin";

                                                             [self.dataArrays addObject:en];

                                                         }
                                                         [self.tableView.mj_footer endRefreshingWithNoMoreData]; // 已经读取万
                                                     }else {
                                                        // 还可以继续尝试刷新
                                                         [self.tableView.mj_footer endRefreshing];
                                                     }
                                                     complete(YES,nil);

                                                 }else {
                                                     [self showErrorText:TPString(@"错误：%@",res[@"message"])];
                                                     complete(NO,res[@"message"]);
                                                     [self.tableView.mj_footer endRefreshing];
                                                 }
                                             } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
                                                 [self showErrorText:@"网络错误"];
                                                 [self.tableView.mj_footer endRefreshing];
                                                 complete(NO,nil);
                                             }];

}
// 提取理财收益
///financial/partake/{id}
- (void)takeoutIncome:(bool_id_block)complete{
    NSString *url = TPString(@"financial/partake/%ld",self.outModel.idField);
    [[WYNetworkManager sharedManager] sendPostRequest:WYJSONRequestSerializer url:url
                                           parameters:nil
                                              success:^(id responseObject, BOOL isCacheObject) {
                                                  NSDictionary *res = (NSDictionary *)responseObject;
                                                  if ([res[@"code"] intValue] == 200 ) {
                                                      [self showSuccessText:@"取出成功"];
                                                      [self TakeOutedStatus];
                                                      
                                                  }else {
                                                      [self showErrorText:res[@"message"]];
                                                      
                                                  }
    } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
        [self showErrorText:@"网络错误"];
    }];
    
}
- (void)initDataArray {
    self.dataArrays = [[NSMutableArray <YUCellEntity *> alloc]init];
    TPStoreDetailProductIntroCellEntity *en0 = [[TPStoreDetailProductIntroCellEntity alloc] init];

    TPEveryIncomeTitleDayCellEntity *en1 = [[TPEveryIncomeTitleDayCellEntity alloc] init];
    [self.dataArrays addObject:en0];
    [self.dataArrays addObject:en1];
}
#pragma mark sys
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpRefresh];
    [self setNav];
    [self.tableView noSeparatorLine];
    [self.takeOutBtn gradualChangeStyle];
    [self.tableView.mj_header beginRefreshing];
    _aylt_top.constant = self.customNavBar.y_Height;
    if (_isTakeouted) {
        [self TakeOutedStatus];
        
    }
}
- (void)firstPage {
    [self.tableView.mj_footer endRefreshing];
    
    [self getParTakeDetailHttpData:^(BOOL isSucc, id data) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        [self getFinancialPartake:0 complete:^(BOOL isSucc, id data) {
            [self.tableView reloadData];
        }];
    }];
}

- (void)nextPage {
    if( ![self.dataArrays.lastObject isKindOfClass: TPStoreEveryDayIncomeCellEntity.class] )return;
    MyEveryDayIncomItemModel *model = (MyEveryDayIncomItemModel *)self.dataArrays.lastObject.data;
    [self getFinancialPartake:model.idField complete:^(BOOL isSucc, id data) {
        [self.tableView reloadData];
    }];
}

- (void)TakeOutedStatus {
    self.takeOutBtn.enabled = NO;
    [self.takeOutBtn setTitle:@"已取出" forState:UIControlStateNormal];
}
- (void)setUpRefresh {
    __weak typeof (self) wsf = self;
    [self.tableView addHeaderWithBlock:^(MJRefreshHeader *header) {
        [wsf firstPage];
    }];
    [self.tableView addFooterWithBlock:^(MJRefreshFooter *footer) {
        [wsf nextPage];
    }];
}
- (void)setNav {
    self.customNavBar.title = TPString(@"%@持仓详情",self.outModel.name);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrays.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView cellByIndexPath:indexPath dataArrays:self.dataArrays];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataArrays[indexPath.row].yu_cellHeight;
}
- (IBAction)onTakeOutTap:(id)sender {
    [self takeoutIncome:^(BOOL isSucc, id data) {
        
    }];
}

#pragma mark lazy
yudef_lazyLoad(NSMutableArray<YUCellEntity *>, dataArrays, _dataArrays)
@end
