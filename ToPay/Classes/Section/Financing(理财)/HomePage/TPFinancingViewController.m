//
//  TPFinancingViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/19.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPFinancingViewController.h"
#import "TPFinancingTotalCellViewEntity.h"
#import "TPProductTableViewCellEntity.h"
#import "BlanaceResponse.h"
#import "TPFinancingProductDetailVC.h"
#import "FinancialProductModel.h"
#import "TPMyStoreViewController.h"
@interface TPFinancingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSMutableArray <YUCellEntity *> *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *atly_top;
@end

@implementation TPFinancingViewController

#pragma mark data

- (void)setUpData {
    _dataArray =[[NSMutableArray <YUCellEntity *> alloc] init];
    TPFinancingTotalCellViewEntity *entity  = [[TPFinancingTotalCellViewEntity alloc]init];
    [self.dataArray addObject:entity];

}
- (void)getTotalBlanceHttpData {
    // 获取余额度
    __weak typeof (self) wsf = self;
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer
                                                 url:@"financial/balance"
                                          parameters:nil
                                             success:^(id responseObject, BOOL isCacheObject) {
                                                 NSDictionary *res = (NSDictionary *)responseObject;
                                                 if ([res[@"code"] intValue] == 200) {
                                                     [wsf setUpData];
                                                     BlanaceResponse *resp = [[BlanaceResponse alloc] initWithDictionary:res[@"data"]];
                                                     self.dataArray[0].data = resp;
                                                     [wsf.tableView reloadData];
                                                     [wsf getFinancialProductListHttp:0]; // 开始读取列表
                                                 }else {
                                                     [self showErrorText:TPString(@"错误:%@",res[@"message"])];
                                                 }
                                                 [self.tableView.mj_header endRefreshing];
                                             }
                                             failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
                                                [self.tableView.mj_header endRefreshing];
                                             } ];
}

- (void)getFinancialProductListHttp:(NSInteger)iid  {
    NSDictionary *postDict = @{@"id":@(iid),@"pageSize":@10};
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer
                                                 url:@"financial"
                                          parameters:postDict
                                             success:^(id responseObject, BOOL isCacheObject) {
                                                 NSDictionary *res = (NSDictionary *)responseObject;
                                                 if ([res[@"code"] intValue] == 200) {
                                                     NSArray *arr =res[@"data"];
                                                     for(NSDictionary *dict in arr) {
                                                         FinancialProductModel *product = [[FinancialProductModel alloc] initWithDictionary:dict];
                                                         TPProductTableViewCellEntity *entity = [[TPProductTableViewCellEntity alloc]init];
                                                         entity.data = product;
                                                         [self.dataArray addObject:entity];
                                                     }
                                                     [self.tableView reloadData];
                                                     if (arr.count < 10 ) {
                                                         [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                                     }else {
                                                         [self.tableView.mj_footer endRefreshing];
                                                         
                                                     }
                                                 }else {
                                                     [self showErrorText:TPString(@"错误:%@",res[@"message"])];
                                                     [self.tableView.mj_footer endRefreshing];
                                                 }
                                             }
                                             failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
                                                 [self.tableView.mj_footer endRefreshing];
                                             } ];
}
//  下一页
- (void)nextPage {
    YUCellEntity *entity =   self.dataArray.lastObject;
    if(! [entity isKindOfClass:TPProductTableViewCellEntity.class] ) {
        return;
    }
    FinancialProductModel *model = (FinancialProductModel *)entity.data;
    [self getFinancialProductListHttp:model.idField];
}
#pragma mark sys method
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    [self setUpData];
    self.atly_top.constant = self.customNavBar.height;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setUpRefresh];
    [self.tableView.mj_header beginRefreshing];
   
   
}

- (void)setUpNav {
    self.customNavBar.title = @"BTC 理财";
     self.customNavBar.backgroundView.backgroundColor = [UIColor colorWithHex:@"#674aff"];
    self.customNavBar.titleLable.textColor = [UIColor whiteColor];
    [self.customNavBar wr_setBottomLineHidden:YES];
    
    
    [self.customNavBar.rightButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.customNavBar wr_setRightButtonWithTitle:@"我的持仓" titleColor:[UIColor whiteColor]];
    [self.customNavBar.rightButton y_setWidth:self.customNavBar.rightButton.y_Width +10];
    [self.customNavBar.rightButton y_setLeft:self.customNavBar.rightButton.y_LeftX -15];
    __weak typeof (self) wsf =self;
    [self.customNavBar setOnClickRightButton:^{
        TPMyStoreViewController *my = [[TPMyStoreViewController alloc]init];
        [wsf.navigationController pushViewController:my animated:YES];
        
    }];
    
    [self.tableView setRefreshBackGroundColor:[UIColor colorWithHex:@"#674aff"]];
    
}

- (void)setUpRefresh {
    __weak typeof (self) wsf = self;
    [self.tableView addHeaderWithBlock:^(MJRefreshHeader *header) {
         [wsf getTotalBlanceHttpData];
    }];
    
    [self.tableView addFooterWithBlock:^(MJRefreshFooter *header) {
        [wsf nextPage];
        
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView cellByIndexPath:indexPath dataArrays:self.dataArray];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataArray[indexPath.row].yu_cellHeight;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    yudef_exit_func_if(![self.dataArray[indexPath.row] isKindOfClass:TPProductTableViewCellEntity.class] )
    TPFinancingProductDetailVC *vc = [[TPFinancingProductDetailVC alloc] init];
    vc.finModel = (FinancialProductModel *)self.dataArray[indexPath.row].data;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark lazy load
yudef_lazyLoad(NSMutableArray <YUCellEntity *>, dataArray, _dataArray)

@end
