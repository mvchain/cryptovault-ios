//
//  TPMVCBanTableViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/4/3.
//  Copyright © 2019 蒲公英. All rights reserved.
//

#import "TPMVCBanTableViewController.h"
#import "YUPageListView.h"
#import "TPMVCBankSelectListView.h"
#import "API_GET_Transaction.h"
#import "TPMVCBankItemCellEntity.h"
#import "TPMVCBankItemModel.h"
#import "TPTransactionModel.h"
#define List_Size 10
@interface TPMVCBanTableViewController ()
@property (weak, nonatomic) IBOutlet YUPageListView *pageListView;


@end

@implementation TPMVCBanTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configPageListView];
    self.view.backgroundColor = [UIColor colorWithHex:@"#F5F5F5"];
    self.pageListView.backgroundColor = [UIColor colorWithHex:@"#F5F5F5"];
    [self refresh];
}
- (void)refresh {
    
    [self.pageListView beginRefreshHeader];
    
}
- (void)configPageListView {
    API_GET_Transaction *getTransactionList = [[API_GET_Transaction alloc]init];
    yudef_weakSelf;
    self.pageListView.pageSize = List_Size;
    self.pageListView.firstPageBlock = ^(block_page_complete  _Nonnull complete)
    {
        getTransactionList.onSuccess = ^(id responseData) {
            NSArray *arrays = (NSArray *)responseData;
            NSMutableArray *listDatas = [[NSMutableArray alloc]init];
            NSMutableArray *models = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dict in arrays) {
                TPMVCBankItemModel *model = [[TPMVCBankItemModel alloc] initWithDictionary:dict];
                [models addObject:model];
                TPMVCBankItemCellEntity *entity = [[TPMVCBankItemCellEntity alloc]init];
                entity.tokenName = weakSelf.curPair.tokenName;
                entity.transType = weakSelf.transactionType;
                entity.data = model;
                [listDatas addObject:entity];
            }
            complete(listDatas);
            
        };
        getTransactionList.onError = ^(NSString *reason, NSInteger code) {
            
        };
        getTransactionList.onEndConnection = ^{
            
        };
        [getTransactionList sendRequestWithIdField:@(0)
                                          pageSize:@(List_Size)
                                            pairId:@(weakSelf.curPair.pairId) transactionType:@(weakSelf.transactionType)
                                              type:@(1)];
        
    };
    self.pageListView.nextPageBlock = ^(block_page_complete  _Nonnull complete, YUPageListView * _Nonnull thisPageView)
    {
        getTransactionList.onSuccess = ^(id responseData) {
            NSArray *arrays = (NSArray *)responseData;
            NSMutableArray *listDatas = [[NSMutableArray alloc]init];
            
            for (NSDictionary *dict in arrays) {
                TPMVCBankItemModel *model = [[TPMVCBankItemModel alloc] initWithDictionary:dict];
                TPMVCBankItemCellEntity *entity = [[TPMVCBankItemCellEntity alloc]init];
                entity.tokenName = weakSelf.curPair.tokenName;
                entity.data = model;
                [listDatas addObject:entity];
                
            }
            complete(listDatas);
            
        };
        getTransactionList.onError = ^(NSString *reason, NSInteger code) {
            
        };
        getTransactionList.onEndConnection = ^{
            
        };
        
        TPMVCBankItemModel *lastModel = (TPMVCBankItemModel *) thisPageView.lastEntity.data;
        
        [getTransactionList sendRequestWithIdField:@(lastModel.idField)
                                          pageSize:@(List_Size)
                                            pairId:@(weakSelf.curPair.pairId) transactionType:@(weakSelf.transactionType)
                                              type:@(0)];
    };
    self.pageListView.yu_didSelectRowAtIndexPath = ^(NSIndexPath * _Nonnull indexPath) {
        TPMVCBankItemModel *model =  weakSelf.pageListView.dataArrays[indexPath.row].data;
   
        TPTransactionModel *backModel = [TPTransactionModel  mj_objectWithKeyValues:model.toDictionary];
        backModel.limitValue = [[NSDecimalNumber alloc] initWithDouble:model.limitValue];
        backModel.price  =model.price;
        backModel.total = [[NSDecimalNumber alloc] initWithDouble:model.total];
        weakSelf.onListTap(backModel);

    };;
    
}

@end
