//
//  TPBrowserViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/3/12.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPBrowserViewController.h"
#import "YUPageListView.h"
#import "YUBlankCellEntity.h"
#import "YUItemLeftMidRightCellEntity.h"
#import "YUItemLeftRightCellEntity.h"
#import "YUTagLabelCellEntity.h"
#import "YUBrowserHeadCellEntity.h"
#import "YUSmallHeaderCellEntity.h"
#import "YUTagLabel_TwoTagCellEntity.h"
#import "YUItemImageCellEntity.h"
#import "YUBlockDetailViewController.h"
#import "YUBlockListViewController.h"
#import "YUSearchBarView.h"
@interface TPBrowserViewController ()
@property (weak, nonatomic) IBOutlet YUPageListView *pageListView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (assign, nonatomic) BOOL isSearchState;

@property (nonatomic, strong) YUSearchBarView *searchbar;
@end

@implementation TPBrowserViewController
- (YUSearchBarView *)searchbar {
    if( !_searchbar ) {
        _searchbar = [YUSearchBarView xib_loadUsingClassName];
        _searchbar.placeholder = @"搜索币种";
    }
    return _searchbar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self configListView];
    [self.pageListView beginRefreshHeader];
    self.top.constant = self.customNavBar.bottom + 10 ;
    [self setEvent];
    
}
- (YUCellEntity *)blank {
    YUBlankCellEntity *blank = [[YUBlankCellEntity alloc] init];
    blank.bgColor = [UIColor colorWithHex:@"#FBFBFB"];
    blank.yu_cellHeight = 12.0;
    return blank;
}
- (void)setNav {
    self.customNavBar.title = @"区块链浏览器";
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"serch_icon_black"]];
}
- (void)configListView {
    self.pageListView.firstPageBlock = ^(block_page_complete  _Nonnull complete) {
        NSMutableArray<YUCellEntity *> * listDatas = [[NSMutableArray<YUCellEntity *> alloc] init];
        YUBrowserHeadCellEntity *header = [[YUBrowserHeadCellEntity alloc] init];
        [listDatas addObject:header];
        
        YUSmallHeaderCellEntity *blockChainInfo = [[YUSmallHeaderCellEntity alloc] init];
        blockChainInfo.title = @"区块链信息";
        blockChainInfo.isShoMore = NO;
        [listDatas addObject:blockChainInfo];
        YUItemLeftRightCellEntity *core = [[YUItemLeftRightCellEntity alloc] init];
        YUItemLeftRightCellEntity *captial = [[YUItemLeftRightCellEntity alloc] init];
        YUItemLeftRightCellEntity *time = [[YUItemLeftRightCellEntity alloc] init];
        core.leftStr = @"内核版本";
        [listDatas addObject:core];
        captial.leftStr = @"基础资产";
        [listDatas addObject:captial];
        time.leftStr = @"最新时间";
        [listDatas addObject:time];
        [listDatas addObject:[self blank]];

        YUSmallHeaderCellEntity *blockInfo = [[YUSmallHeaderCellEntity alloc] init];
        [listDatas addObject:blockInfo];
        blockInfo.isShoMore = YES;
        blockInfo.title = @"区块信息";
        YUTagLabelCellEntity *blockInfoTag = [[YUTagLabelCellEntity alloc] init];
        blockInfoTag.leftStr = @"区块高度";blockInfoTag.midStr = @"交易数量";blockInfoTag.rightStr = @"出块时间";
        [listDatas addObject:blockInfoTag];
        YUItemLeftMidRightCellEntity *itemInfo0 = [[YUItemLeftMidRightCellEntity alloc] init];
        itemInfo0.leftStr = @"775846";itemInfo0.mideStr = @"156" ;itemInfo0.rightStr = [QuickMaker timeWithTimeIntervalString:0];
        [listDatas addObject:itemInfo0];
        
        YUSmallHeaderCellEntity *recentTrans= [[YUSmallHeaderCellEntity alloc] init];
        recentTrans.isShoMore = NO;
        recentTrans.title = @"最新交易";
        [listDatas addObject:recentTrans];
        YUTagLabelCellEntity *recentTransTag = [[YUTagLabelCellEntity alloc] init];
        recentTransTag.leftStr = @"交易 Hash";recentTransTag.midStr = @"确认数";recentTransTag.rightStr= @"交易时间";
        [listDatas addObject:recentTransTag];
        YUItemLeftMidRightCellEntity *itemInfo1 = [[YUItemLeftMidRightCellEntity alloc] init];
        itemInfo1.leftStr = @"775846";itemInfo1.mideStr = @"156" ;itemInfo1.rightStr = [QuickMaker timeWithTimeIntervalString:0];
        [listDatas addObject:itemInfo1];
        
        YUSmallHeaderCellEntity *nodeList= [[YUSmallHeaderCellEntity alloc] init];
        nodeList.title = @"节点列表";
        nodeList.isShoMore = NO;
        [listDatas addObject:nodeList];
        YUTagLabel_TwoTagCellEntity *nodeListTag = [[YUTagLabel_TwoTagCellEntity alloc] init];
        nodeListTag.leftStr = @"节点" ;nodeListTag.rightStr = @"同步高度";
        [listDatas addObject:nodeListTag];
        YUItemLeftRightCellEntity *item2= [[YUItemLeftRightCellEntity alloc] init];
        item2.leftStr = @"CN";item2.rightStr = @"154687";
        item2.isAlignCenterStyle = YES;
        
        [listDatas addObject:item2];
        [listDatas addObject: [self blank]];
        YUSmallHeaderCellEntity *nodeDistu= [[YUSmallHeaderCellEntity alloc] init];
        nodeDistu.title = @"节点分布图";
        [listDatas addObject:nodeDistu];
        YUItemImageCellEntity *imageEntity = [[YUItemImageCellEntity alloc] init];
        [listDatas addObject:imageEntity];
        complete(listDatas);
        
    };
}
- (void)setEvent {
    yudef_weakSelf
    self.pageListView.yu_didSelectRowAtIndexPath = ^(NSIndexPath * _Nonnull indexPath) {
        YUCellEntity *thisEntity = (YUCellEntity *)weakSelf.pageListView.dataArrays[indexPath.row];
        if ([thisEntity isKindOfClass:YUSmallHeaderCellEntity.class]) {
            YUSmallHeaderCellEntity *head = (YUSmallHeaderCellEntity *)thisEntity;
            if ([head.title isEqualToString:@"区块信息"]) {
                YUBlockListViewController *blockInfo = [[YUBlockListViewController alloc] init];
                [self.navigationController pushViewController:blockInfo animated:YES];
            }
        }
    };
    
    __weak typeof (self) wsf = self;
    [self.customNavBar setOnClickRightButton:^
     {
        // [wsf reBackUpSearchResult] ; // 重置搜索
         YUSearchBarView * search  = wsf.searchbar;
         if( !wsf.isSearchState ) {
             //当前非搜索状态，点击后变成搜索状态
             [wsf.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"cancel_icon_black"]];
             [wsf.customNavBar addSubview:search];
             search.searchTextfield.text = @"";
             [search setHeight:36.0];
             [search setWidth:wsf.customNavBar.width - 90];
             [search setCenterY:wsf.customNavBar.leftButton.centerY];
             [search setCenterX:wsf.customNavBar.centerX];
             [search tobeCircle]; // 圆角
             [search.searchTextfield becomeFirstResponder];
             [search fadeIn:^{
                 
             }];
         }else{
             // 当前搜索状态，点击后变非搜索状态
             [search.searchTextfield resignFirstResponder];
             [search fadeOut:^{
                 [wsf.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"serch_icon_black"]];
                 [wsf.searchbar removeFromSuperview];
             }];
         }
         wsf.isSearchState = !wsf.isSearchState; // 切换状态
         
     }];
}




@end
