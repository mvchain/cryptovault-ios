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
#import "TPFinancingProductDetailTotalCellEntity.h"
#import "API_GET_Financial_Id.h"
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
    TPFinancingProductDetailTotalCellEntity *entity0 = [[TPFinancingProductDetailTotalCellEntity alloc] init];
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
    NSLog(@"%@",[TPLoginUtil userInfo].token);
    
    [self yu_showLoading];
    yudef_weakSelf;
    
    API_GET_Financial_Id *getDetail = [[API_GET_Financial_Id alloc] init];
    getDetail.onSuccess = ^(id responseData) {
        FinProductDetailModel *model = [[FinProductDetailModel alloc]initWithDictionary:responseData];
        NSLog(@"%@",responseData);
        
        weakSelf.detailModel = model;
        [weakSelf updateView];
    };
    getDetail.onError = ^(NSString *reason, NSInteger code) {
        [self showErrorText:reason];
       
    };
    getDetail.onEndConnection = ^{
        [self yu_dismissLoading];
    };
    [getDetail sendRequestWithIdField:@(self.finModel.idField)];
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
