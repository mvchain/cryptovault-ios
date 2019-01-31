//
//  TPFinancingProductDetailVC.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/22.
//  Copyright © 2019年 蒲公英. All rights reserved.
//
#import "TPFinancingProductDetailVC.h"
#import "TPFinancingTotalCellView.h"
#import "TPProductIntroduceCellEntity.h"
#import "TPFinancingTotalCellViewEntity.h"
#import "FinProductDetailModel.h"
#import "TPBuyProductViewController.h"
@interface TPFinancingProductDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alyt_table_top;
@property (weak, nonatomic) IBOutlet UIButton *buyinButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *atly_bottom;
yudef_property_strong(FinProductDetailModel, detailModel)
yudef_property_strong(NSMutableArray<YUCellEntity *>, dataArrays)
@end
@implementation TPFinancingProductDetailVC
#pragma mark getData
- (void)initData {
    TPFinancingTotalCellViewEntity *entity0 = [[TPFinancingTotalCellViewEntity alloc] init];
    TPProductIntroduceCellEntity *entity1 = [[TPProductIntroduceCellEntity alloc] init];
    TPProductIntroduceCellEntity *entity2 = [[TPProductIntroduceCellEntity alloc] init];
    entity1.title = @"产品介绍";
    entity2.title =@"参与规则";
    [self.dataArrays addObject:entity0];
    [self.dataArrays addObject:entity1];
    [self.dataArrays addObject:entity2];
    [self.tableView reloadData];
}
- (void)getDataFromHttp {
    __weak typeof (self) wsf = self;
    NSString *url = TPString(@"financial/%ld",(long)self.finModel.idField);
    [self yu_showLoading];
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer
                                                 url:url
                                          parameters:nil
                                             success:^(id responseObject, BOOL isCacheObject) {
                                                 NSDictionary *res = (NSDictionary *)responseObject;
                                                 if ([res[@"code"] intValue] == 200) {
                                                     
                                                     FinProductDetailModel *model = [[FinProductDetailModel alloc]initWithDictionary:res[@"data"]];
                                                     wsf.detailModel = model;
                                                     [wsf updateView];
                                                     
                                                 }else {
                                                     [self showErrorText:TPString(@"错误:%@",res[@"message"])];
                                                 }
                                                 [self yu_dismissLoading];
                                             }
                                             failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
                                                  [self showErrorText:@"网络错误"];
                                                 [self yu_dismissLoading];
                                             } ];
}
- (void)updateView {
    self.dataArrays[0].data = self.detailModel;
    TPProductIntroduceCellEntity *en0 = (TPProductIntroduceCellEntity *) self.dataArrays[1];
    en0.content = self.detailModel.content;
     TPProductIntroduceCellEntity *en1 = (TPProductIntroduceCellEntity *) self.dataArrays[2];
    en1.content = self.detailModel.rule;
    [self.tableView reloadData];
    
}
#pragma mark setUP
- (void)viewDidLoad {
    [super viewDidLoad];
    self.alyt_table_top.constant = self.customNavBar.height;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHex:@"#F5F5F5"];
    [self.buyinButton gradualChangeStyle];
    [self setUpNav];
    [self initData];
    [self getDataFromHttp];
    _atly_bottom.constant = [QuickGet getWhiteBottomHeight];
    
}
- (void)setUpNav {
    self.customNavBar.title = self.finModel.name;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrays.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView cellByIndexPath:indexPath dataArrays:self.dataArrays];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataArrays[indexPath.row].yu_cellHeight;
}
#pragma mark event
- (IBAction)submit:(id)sender {
    TPBuyProductViewController *buy = [[TPBuyProductViewController alloc]init];
    buy.productModel = self.detailModel;
    
    [self.navigationController pushViewController:buy animated:YES];
}
#pragma mark lazy
yudef_lazyLoad(NSMutableArray<YUCellEntity*>, dataArrays, _dataArrays)
@end
