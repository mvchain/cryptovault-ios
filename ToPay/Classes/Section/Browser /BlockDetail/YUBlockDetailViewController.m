//
//  YUBlockDetailViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/3/13.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUBlockDetailViewController.h"
#import "YUTagLabelCellEntity.h"
#import "YUItemLeftMidRightCellEntity.h"
#import "YUPageListView.h"
#import "YUBlankCellEntity.h"
#import "API_GET_Block.h"
#import "API_GET_Block_Blockid.h"
#import "YUItemLeftRightCellEntity.h"
#import "BlockDetailInfo.h"
#import "BlockDetailItem.h"
#import "API_GET_Block_Blockid_Transactions.h"
#import "YUSmallHeaderCellEntity.h"
#import "YUTransactionInfoViewController.h"
@interface YUBlockDetailViewController ()
@property (weak, nonatomic) IBOutlet YUPageListView *pageListView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *atly_top;
@end

@implementation YUBlockDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    self.atly_top.constant = self.customNavBar.height + 5;
    [self configListView];
    [self.pageListView beginRefreshHeader];
   
}
- (void)configListView  {
    yudef_weakSelf
    self.pageListView.firstPageBlock = ^(block_page_complete  _Nonnull complete) {
        API_GET_Block_Blockid *GET_Block_Blockid = [[API_GET_Block_Blockid alloc] init];
        NSMutableArray *listDatas = [[NSMutableArray alloc] init];
        
        __block BlockDetailInfo *blockInfo;
        NSMutableArray *block_listArr = [[NSMutableArray alloc] init];
        dispatch_group_t netGroup = dispatch_group_create() ;
        GET_Block_Blockid.onSuccess = ^(id responseData) {
            NSDictionary *dict = (NSDictionary *)responseData;
            blockInfo = [[BlockDetailInfo alloc] initWithDictionary:dict];
           
            
        };
        GET_Block_Blockid.onError = ^(NSString *reason, NSInteger code) {
            
        };
        GET_Block_Blockid.onEndConnection = ^{
            dispatch_group_leave(netGroup);
        };
        dispatch_group_enter(netGroup);
        [GET_Block_Blockid sendReuqestWithBlockid:@(self.blockId).stringValue];
        
        API_GET_Block_Blockid_Transactions *GET_Block_Blockid_Transactions = [[API_GET_Block_Blockid_Transactions alloc] init];
        GET_Block_Blockid_Transactions.onSuccess = ^(id responseData) {
            NSArray *arr = (NSArray *)responseData;
            for (NSDictionary *dict in arr) {
                BlockDetailItem *item =  [[BlockDetailItem alloc]initWithDictionary:dict];
              
                [block_listArr addObject:item];
            }
        };
        GET_Block_Blockid_Transactions.onError = ^(NSString *reason, NSInteger code) {
            
        };
        GET_Block_Blockid_Transactions.onEndConnection = ^{
            dispatch_group_leave(netGroup);
        };
        dispatch_group_enter(netGroup);
        [GET_Block_Blockid_Transactions sendReuqestWithBlockid:@(self.blockId).stringValue
                                                      PageSize:@(10)
                                                 transactionId:@(0)];
        dispatch_group_notify(netGroup, dispatch_get_main_queue(), ^{
            YUItemLeftRightCellEntity *curBlock = [[YUItemLeftRightCellEntity alloc] init];
            curBlock.leftStr = @"当前区块";
            curBlock.rightStr = @(blockInfo.blockId).stringValue;
            curBlock.rightFont = [UIFont systemFontOfSize:17];
            curBlock.rightColor = [UIColor colorWithHex:@"#595971"];
            YUItemLeftRightCellEntity *transNum = [[YUItemLeftRightCellEntity alloc] init];
            transNum.leftStr = @"交易数量";
            transNum.rightStr = @(blockInfo.transactions).stringValue;
            transNum.rightFont = [UIFont systemFontOfSize:17];
            transNum.rightColor = [UIColor colorWithHex:@"#595971"];
            YUItemLeftRightCellEntity *blockTime = [[YUItemLeftRightCellEntity alloc] init];
            blockTime.leftStr = @"出块时间";
            blockTime.rightStr = [QuickMaker timeWithTimeInterval_allNumberStyleString:blockInfo.createdAt];
            [listDatas addObjectsFromArray:@[curBlock,transNum,blockTime]];
            [listDatas addObject:[self blank]];
            YUSmallHeaderCellEntity *transHead = [[YUSmallHeaderCellEntity alloc] init];
            transHead.title = @"交易";
            [listDatas addObject:transHead];
            YUTagLabelCellEntity *tag = [[YUTagLabelCellEntity alloc]init];
            tag.leftStr = @"交易Hash";tag.midStr = @"确认数";tag.rightStr = @"交易时间";
            [listDatas addObject:tag];
            for (BlockDetailItem *item in block_listArr) {
                YUItemLeftMidRightCellEntity *itemInfo0 = [[YUItemLeftMidRightCellEntity alloc] init];
                itemInfo0.data =item;
                itemInfo0.leftStr = item.yhash;
                if (item.confirm >12)item.confirm = 12;
                itemInfo0.mideStr = TPString(@"%ld个确认数",(long)item.confirm);
                itemInfo0.rightStr = [QuickMaker timeWithTimeIntervalString:item.createdAt];
                [listDatas addObject:itemInfo0];
            }
            complete(listDatas);
        });
    };
    
    self.pageListView.nextPageBlock = ^(block_page_complete  _Nonnull complete, YUPageListView * _Nonnull thisPageView) {
         BlockDetailItem *lastItem  = (BlockDetailItem *)thisPageView.lastEntity.data;
        
        API_GET_Block_Blockid_Transactions *GET_Block_Blockid_Transactions = [[API_GET_Block_Blockid_Transactions alloc] init];
        GET_Block_Blockid_Transactions.onSuccess = ^(id responseData) {
            NSArray *arr = (NSArray *)responseData;
            NSMutableArray *listDatas = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in arr) {
                BlockDetailItem *item =  [[BlockDetailItem alloc]initWithDictionary:dict];
                YUItemLeftMidRightCellEntity *itemInfo0 = [[YUItemLeftMidRightCellEntity alloc] init];
                itemInfo0.data = item;
                itemInfo0.leftStr = item.yhash;
                if (item.confirm >12)item.confirm = 12;
                itemInfo0.mideStr = TPString(@"%ld个确认数",item.confirm);
                itemInfo0.rightStr = [QuickMaker timeWithTimeIntervalString:item.createdAt];
                [listDatas addObject:itemInfo0];
            }
            complete(listDatas);
        };
        GET_Block_Blockid_Transactions.onError = ^(NSString *reason, NSInteger code) {
            
        };
        GET_Block_Blockid_Transactions.onEndConnection = ^{
           
        };
        [GET_Block_Blockid_Transactions sendReuqestWithBlockid:@(self.blockId).stringValue
                                                      PageSize:@(10)
                                                 transactionId:@(lastItem.transactionId)];
        
    };
    
    self.pageListView.yu_didSelectRowAtIndexPath = ^(NSIndexPath * _Nonnull indexPath) {
        YUCellEntity *thisEntity = (YUCellEntity *)weakSelf.pageListView.dataArrays[indexPath.row];
        if (![thisEntity.data isKindOfClass:BlockDetailItem.class]) {
            return ;
        }
        BlockDetailItem *model = (BlockDetailItem*)thisEntity.data;
        YUTransactionInfoViewController *viewControlerr =[[YUTransactionInfoViewController alloc] init];
        viewControlerr.yhash = model.yhash;
        [weakSelf.navigationController pushViewController:viewControlerr animated:YES];
    };
    
}
- (YUCellEntity *)blank {
    YUBlankCellEntity *blank = [[YUBlankCellEntity alloc] init];
    blank.bgColor = [UIColor colorWithHex:@"#FBFBFB"];
    blank.yu_cellHeight = 12.0;
    return blank;
}
- (void)setNav {
    self.customNavBar.title = @"区块详情";
    
}


@end
