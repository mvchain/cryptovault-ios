//
//  YUTransactionRecordViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/3/14.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUTransactionRecordViewController.h"
#import "YUTagLabel_TwoTagCellEntity.h"
#import "YUItemLeftRightCellEntity.h"
#import "YUPageListView.h"
#import "API_GET_Block_Address_Order.h"
#import "BlockTransactionRecordItem.h"
#import "TransactionRecordDetailViewController.h"
@interface YUTransactionRecordViewController ()
@property (weak, nonatomic) IBOutlet YUPageListView *pageListView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *atly_top;
@end

@implementation YUTransactionRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    self.atly_top.constant = self.customNavBar.height + 5;
    [self configListView];
    [self.pageListView beginRefreshHeader];
    [self setTableEvent];
    
}
- (void)setNav {
    self.customNavBar.title = @"交易记录";
}

- (void)configListView  {
    yudef_weakSelf
    self.pageListView.firstPageBlock = ^(block_page_complete  _Nonnull complete)
    {
        API_GET_Block_Address_Order *GET_Block_Address_Order =[[API_GET_Block_Address_Order alloc] init];
        GET_Block_Address_Order.onSuccess = ^(id responseData) {
            NSArray *responseArr = (NSArray *)responseData ;
            NSMutableArray *listDatas = [[NSMutableArray alloc] init];
            YUTagLabel_TwoTagCellEntity *tag = [[YUTagLabel_TwoTagCellEntity alloc]init];
            tag.leftStr = @"交易类型";
            tag.rightStr = @"交易时间";
            [listDatas addObject:tag];
            [listDatas addObjectsFromArray:[self packetByArray:responseArr]];
            complete(listDatas);
        };
        GET_Block_Address_Order.onError = ^(NSString *reason, NSInteger code) {
            
        };
        GET_Block_Address_Order.onEndConnection = ^{
            
        };
        [GET_Block_Address_Order sendReuqestWithId:@(0)
                                          pageSize:@(10)
                                         publicKey:weakSelf.publicKey];

    };
    self.pageListView.nextPageBlock = ^(block_page_complete  _Nonnull complete, YUPageListView * _Nonnull thisPageView)
    {
        API_GET_Block_Address_Order *GET_Block_Address_Order =[[API_GET_Block_Address_Order alloc] init];
        GET_Block_Address_Order.onSuccess = ^(id responseData) {
            NSArray *responseArr = (NSArray *)responseData ;
            NSMutableArray *listDatas = [[NSMutableArray alloc] init];
            [listDatas addObjectsFromArray:[self packetByArray:responseArr]];
            complete(listDatas);
        };
        GET_Block_Address_Order.onError = ^(NSString *reason, NSInteger code) {
            
        };
        GET_Block_Address_Order.onEndConnection = ^{
            
        };
        BlockTransactionRecordItem *lastItem  = (BlockTransactionRecordItem *)thisPageView.lastEntity.data;
        [GET_Block_Address_Order sendReuqestWithId:@(lastItem.idField)
                                            pageSize:@(10)
                                           publicKey:weakSelf.publicKey];
    };
    
}

- (NSMutableArray *)packetByArray:(NSArray *)arr {
    NSMutableArray *listDatas = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in arr) {
        BlockTransactionRecordItem *item = [[BlockTransactionRecordItem alloc] initWithDictionary:dict];
        YUItemLeftRightCellEntity *en = [[YUItemLeftRightCellEntity alloc]init];
        en.data = item;
        NSArray *titles = @[@"转账",@"币币交易"];
        en.leftStr = titles[item.classify];
        
        en.rightStr = [QuickMaker timeWithTimeInterval_allNumberStyleString:item.createdAt];
        [listDatas addObject:en];
    }
    return listDatas;
}

- (void)setTableEvent {
    yudef_weakSelf;
    self.pageListView.yu_didSelectRowAtIndexPath = ^(NSIndexPath * _Nonnull indexPath) {
        if (indexPath.row == 0) return ;
        YUCellEntity *entity = weakSelf.pageListView.dataArrays[indexPath.row];
        BlockTransactionRecordItem *item = (BlockTransactionRecordItem *)entity.data;
        TransactionRecordDetailViewController *detailVC = [[TransactionRecordDetailViewController alloc] init];
        detailVC.classify = item.classify;
        detailVC.transactionId = item.idField;
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
        
    };
    
}
@end
