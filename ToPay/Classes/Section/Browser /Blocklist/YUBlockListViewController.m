//
//  YUBlockListViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/3/13.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "YUBlockListViewController.h"
#import "YUTagLabelCellEntity.h"
#import "YUItemLeftMidRightCellEntity.h"
#import "YUPageListView.h"
#import "API_GET_Block.h"
#import "BlockListItem.h"
@interface YUBlockListViewController ()
@property (weak, nonatomic) IBOutlet YUPageListView *pageListView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *atly_top;

@end
@implementation YUBlockListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    self.atly_top.constant = self.customNavBar.height + 5;
    [self configListView];
    [self.pageListView beginRefreshHeader];

}

- (void)configListView  {
    self.pageListView.firstPageBlock = ^(block_page_complete  _Nonnull complete) {
        YUTagLabelCellEntity *tag = [[YUTagLabelCellEntity alloc] init];
        tag.leftStr = @"区块高度";
        tag.midStr = @"交易数量";
        tag.rightStr = @"出块时间";
        API_GET_Block *GET_Block = [[API_GET_Block alloc] init];
        NSMutableArray *listDatas = [[NSMutableArray alloc] init];
        [listDatas addObject:tag];
        
        GET_Block.onSuccess = ^(id responseData) {
            NSArray *arr = (NSArray *)responseData;
            for (NSDictionary *dict in arr) {
                BlockListItem *item =  [[BlockListItem alloc]initWithDictionary:dict];
                YUItemLeftMidRightCellEntity *entity = [[YUItemLeftMidRightCellEntity alloc]init];
                entity.leftStr = @(item.blockId).stringValue ;
                entity.mideStr = @(item.transactions).stringValue;
                entity.rightStr = [QuickMaker timeWithTimeIntervalString:item.createdAt];
                entity.data=item;
                
                [listDatas addObject:entity];
            }
            complete(listDatas);
        };
        GET_Block.onError = ^(NSString *reason, NSInteger code) {
            
        };
        GET_Block.onEndConnection = ^{
            
        };
        [GET_Block sendReuqestWithBlockId:@(0) pageSize:@(10)];
        
    };
    
    self.pageListView.nextPageBlock = ^(block_page_complete  _Nonnull complete, YUPageListView * _Nonnull thisPageView)
    {
        BlockListItem *lastItem = (BlockListItem *)thisPageView.lastEntity.data;
        API_GET_Block *GET_Block = [[API_GET_Block alloc] init];
        NSMutableArray *listDatas = [[NSMutableArray alloc] init];
        GET_Block.onSuccess = ^(id responseData) {
            NSArray *arr = (NSArray *)responseData;
            for (NSDictionary *dict in arr) {
                BlockListItem *item =  [[BlockListItem alloc]initWithDictionary:dict];
                YUItemLeftMidRightCellEntity *entity = [[YUItemLeftMidRightCellEntity alloc]init];
                entity.leftStr = @(item.blockId).stringValue ;
                entity.mideStr = @(item.transactions).stringValue;
                entity.rightStr = [QuickMaker timeWithTimeIntervalString:item.createdAt];
                entity.data = item;
                [listDatas addObject:entity];
            }
            complete(listDatas);
        };
        GET_Block.onError = ^(NSString *reason, NSInteger code) {
            
        };
        GET_Block.onEndConnection = ^{
            
        };
        [GET_Block sendReuqestWithBlockId:@(lastItem.blockId) pageSize:@(10)];
        
        
    };
    
}
- (void)setNav {
    self.customNavBar.title = @"资产";
    
}


@end
