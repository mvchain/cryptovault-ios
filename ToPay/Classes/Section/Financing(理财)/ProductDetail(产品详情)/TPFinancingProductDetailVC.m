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
#import "TPProductDetailWebContainerCellEntity.h"
@interface TPFinancingProductDetailVC ()<UITableViewDelegate,UITableViewDataSource,YUCellDelegate>
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
    self.dataArrays = [[NSMutableArray<YUCellEntity *> alloc] init];
    
}
- (void)getDataFromHttp {
    __weak typeof (self) wsf = self;
    NSString *url = TPString(@"financial/%ld",(long)self.finModel.idField);
    yudef_weakSelf;
    
    [self yu_showLoading];
    
    API_GET_Financial_Id *getDetail = [[API_GET_Financial_Id alloc] init];
    getDetail.onSuccess = ^(id responseData) {
        FinProductDetailModel *model = [[FinProductDetailModel alloc]initWithDictionary:responseData];
        weakSelf.detailModel = model;
        TPFinancingProductDetailTotalCellEntity *head = [[TPFinancingProductDetailTotalCellEntity alloc] init];
        head.data = model;
        
        TPProductDetailWebContainerCellEntity *webContainer = [[TPProductDetailWebContainerCellEntity alloc] init];
        NSString *domain = [QuickGet getFinancingProductDetailWebDomainUrl];
        webContainer.url = [NSString stringWithFormat:@"%@?type=2&id=%ld",domain,(long)model.idField];
        [weakSelf.dataArrays addObject:head];
        [weakSelf.dataArrays addObject:webContainer];
        [self.tableView reloadData];
    };
    getDetail.onError = ^(NSString *reason, NSInteger code) {
        [self showErrorText:reason];
       
    };
    getDetail.onEndConnection = ^{
        [self yu_dismissLoading];
    };
    [getDetail sendRequestWithIdField:@(self.finModel.idField)];
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
    return [tableView cellByIndexPath:indexPath dataArrays:self.dataArrays delegate:self];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataArrays[indexPath.row].yu_cellHeight;
}
- (void)yu_cellMessageNotify:(NSString *)idf content:(id)content sender:(id)sender {
    if ([idf isEqualToString:@"web-height-update"]) {
        [self.tableView reloadData];
        
    }
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
