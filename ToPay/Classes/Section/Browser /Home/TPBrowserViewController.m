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
#import "YUPublicKeySearchResultCellEntity.h"
#import "API_GET_Block.h"
#import "API_GET_Block_Last.h"
#import "API_GET_Block_Transaction_Last.h"
#import "BlockTransactionInfo.h"
#import "BlockListItem.h"
#import "BlockLastInfo.h"
#import "API_GET_Block_Address_Exist.h"
#import "YUBrowserCaptialViewController.h"
#import "YUTransactionRecordViewController.h"
#import "YUBlockDetailViewController.h"
#import "YUTransactionInfoViewController.h"
@interface TPBrowserViewController ()
@property (weak, nonatomic) IBOutlet YUPageListView *pageListView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (assign, nonatomic) BOOL isSearchState;
@property (copy,nonatomic ) NSString *searchPublicKey;
@property (assign,nonatomic) BOOL isShowDefalutSearchInfo;
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
    _isSearchState = NO;
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
    yudef_weakSelf;
    self.pageListView.firstPageBlock = ^(block_page_complete  _Nonnull complete) {
        if (weakSelf.isSearchState ){
            // searchState
            YUPublicKeySearchResultCellEntity *en = [[YUPublicKeySearchResultCellEntity alloc] init];
            en.publicKey = weakSelf.searchPublicKey;
            if (weakSelf.isShowDefalutSearchInfo ) {
                 complete(@[[YUErrorCellEntity quickInit:@""]]);
            }else {
                if (en.publicKey && en.publicKey.length >0){
                    complete(@[en]);
                }else {
                    complete(@[[YUErrorCellEntity quickInit:@"暂无搜索结果"]]);
                }
            }
            return ;
        }
        dispatch_group_t netGroup = dispatch_group_create() ;
        __block BlockLastInfo *block_last_info ;
        NSMutableArray *block_listArr = [[NSMutableArray alloc] init];
        NSMutableArray *block_transAction_Arr = [[NSMutableArray alloc] init];
        API_GET_Block_Last *GET_Block_Last = [[API_GET_Block_Last alloc] init];
        GET_Block_Last.onSuccess = ^(id responseData) {
            block_last_info = [[BlockLastInfo alloc] initWithDictionary:responseData];
        };
        GET_Block_Last.onError = ^(NSString *reason, NSInteger code) {
            
        };
        GET_Block_Last.onEndConnection = ^{
            dispatch_group_leave(netGroup);
        };
        dispatch_group_enter(netGroup);
        [GET_Block_Last sendReuqest];
        //
        API_GET_Block *GET_Block = [[API_GET_Block alloc] init];
        GET_Block.onSuccess = ^(id responseData) {
            NSArray *arr = (NSArray *)responseData;
            for (NSDictionary *dict in arr) {
                BlockListItem *item =  [[BlockListItem alloc]initWithDictionary:dict];
                [block_listArr addObject:item];
            }
        };
        GET_Block.onError = ^(NSString *reason, NSInteger code) {
            
        };
        GET_Block.onEndConnection = ^{
            dispatch_group_leave(netGroup);
        };
        dispatch_group_enter(netGroup);
        [GET_Block sendReuqestWithBlockId:@(0) pageSize:@(10)];
        
        //
        API_GET_Block_Transaction_Last *GET_Block_Transaction_Last = [[API_GET_Block_Transaction_Last alloc] init];
        GET_Block_Transaction_Last.onSuccess = ^(id responseData) {
             NSArray *arr = (NSArray *)responseData;
            for (NSDictionary *dict in arr) {
                BlockTransactionInfo *item =  [[BlockTransactionInfo alloc]initWithDictionary:dict];
                [block_transAction_Arr addObject:item];
            }
        };
        GET_Block_Transaction_Last.onError = ^(NSString *reason, NSInteger code) {
            
        };
        GET_Block_Transaction_Last.onEndConnection = ^{
            dispatch_group_leave(netGroup);
        };
        dispatch_group_enter(netGroup);
        [GET_Block_Transaction_Last sendReuqestWithPageSize:@(10)];
        
        
        dispatch_group_notify(netGroup, dispatch_get_main_queue(), ^{
            complete([self packetListDatas:block_last_info
                             blockInfoList:block_listArr
                           transactionList:block_transAction_Arr]);
        });
    };
}


- ( NSMutableArray<YUCellEntity *>*)packetListDatas:(BlockLastInfo *)blockLastInfo
                                      blockInfoList:(NSMutableArray *)blockInfoList
                                    transactionList:(NSMutableArray *)transactionList;

{
    NSMutableArray<YUCellEntity *> * listDatas = [[NSMutableArray<YUCellEntity *> alloc] init];
    YUBrowserHeadCellEntity *header = [[YUBrowserHeadCellEntity alloc] init];
    header.blockHeight = blockLastInfo.blockId;
    header.transnum = blockLastInfo.transactionCount;
    header.confirmSecond = 5;
    
    [listDatas addObject:header];
    YUSmallHeaderCellEntity *blockChainInfo = [[YUSmallHeaderCellEntity alloc] init];
    blockChainInfo.title = @"区块链信息";
    blockChainInfo.isShoMore = NO;
    [listDatas addObject:blockChainInfo];
    YUItemLeftRightCellEntity *core = [[YUItemLeftRightCellEntity alloc] init];
    YUItemLeftRightCellEntity *captial = [[YUItemLeftRightCellEntity alloc] init];
    YUItemLeftRightCellEntity *time = [[YUItemLeftRightCellEntity alloc] init];
    core.leftStr = @"内核版本";
    core.rightStr = blockLastInfo.version;
    [listDatas addObject:core];
    captial.leftStr = @"基础资产";
    captial.rightStr = @(blockLastInfo.total).stringValue;
    [listDatas addObject:captial];
    time.leftStr = @"最新时间";
    time.rightStr = [QuickMaker timeWithTimeInterval_allNumberStyleString:blockLastInfo.confirmTime];
    [listDatas addObject:time];
    [listDatas addObject:[self blank]];
    
    YUSmallHeaderCellEntity *blockInfo = [[YUSmallHeaderCellEntity alloc] init];
    [listDatas addObject:blockInfo];
    blockInfo.isShoMore = YES;
    blockInfo.title = @"区块信息";
    YUTagLabelCellEntity *blockInfoTag = [[YUTagLabelCellEntity alloc] init];
    blockInfoTag.leftStr = @"区块高度";blockInfoTag.midStr = @"交易数量";blockInfoTag.rightStr = @"出块时间";
    [listDatas addObject:blockInfoTag];
    for (BlockListItem *itemModel in blockInfoList) {
        YUItemLeftMidRightCellEntity *itemInfo0 = [[YUItemLeftMidRightCellEntity alloc] init];
        itemInfo0.leftStr = @(itemModel.blockId).stringValue ;
        itemInfo0.mideStr = @(itemModel.transactions).stringValue;
        itemInfo0.rightStr = [QuickMaker timeWithTimeIntervalString:itemModel.createdAt];
        itemInfo0.data = itemModel;
        [listDatas addObject:itemInfo0];
    }
    YUSmallHeaderCellEntity *recentTrans= [[YUSmallHeaderCellEntity alloc] init];
    recentTrans.isShoMore = NO;
    recentTrans.title = @"最新交易";
    [listDatas addObject:recentTrans];
    YUTagLabel_TwoTagCellEntity *recentTransTag =[[YUTagLabel_TwoTagCellEntity alloc]init];
   
    recentTransTag.leftStr = @"交易 Hash";recentTransTag.rightStr= @"交易时间";
    recentTransTag.isLabelAlginCenter = YES;
    
    [listDatas addObject:recentTransTag];
    
    for (BlockTransactionInfo *itemModel in  transactionList) {
    
        YUItemLeftRightCellEntity *itemInfo1 = [[YUItemLeftRightCellEntity alloc] init];
       
        
        itemInfo1.leftStr = itemModel.yhash;
        itemInfo1.rightStr = [QuickMaker timeWithTimeIntervalString:itemModel.createdAt];
        itemInfo1.data = itemModel;
        
        [listDatas addObject:itemInfo1];
    }
    YUSmallHeaderCellEntity *nodeList= [[YUSmallHeaderCellEntity alloc] init];
    nodeList.title = @"节点列表";
    nodeList.isShoMore = NO;
    [listDatas addObject:nodeList];
    YUTagLabel_TwoTagCellEntity *nodeListTag = [[YUTagLabel_TwoTagCellEntity alloc] init];
    nodeListTag.leftStr = @"节点" ;nodeListTag.rightStr = @"同步高度";
    [listDatas addObject:nodeListTag];
    nodeListTag.isLabelAlginCenter = YES;
    
    NSArray *regions = @[@"CN",@"US",@"HK",@"UK",@"JP"];
    NSArray *heights = @[@"1546792",@"1546792",@"1546792",@"1546792",@"1546792"];
    int i =0;
    
    for (NSString *region in regions) {
        YUItemLeftRightCellEntity *item2= [[YUItemLeftRightCellEntity alloc] init];
        item2.leftStr = region;item2.rightStr = heights[i];
        item2.isAlignCenterStyle = YES;
        [listDatas addObject:item2];
        i++;
        
    }
    
    [listDatas addObject: [self blank]];
    YUSmallHeaderCellEntity *nodeDistu= [[YUSmallHeaderCellEntity alloc] init];
    nodeDistu.title = @"节点分布图";
    [listDatas addObject:nodeDistu];
    YUItemImageCellEntity *imageEntity = [[YUItemImageCellEntity alloc] init];
    [listDatas addObject:imageEntity];
    return listDatas;
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
       
        if(thisEntity.data && [thisEntity.data isKindOfClass:BlockTransactionInfo.class]) {
            BlockTransactionInfo *model = (BlockTransactionInfo*)thisEntity.data;
            YUTransactionInfoViewController *viewControlerr =[[YUTransactionInfoViewController alloc] init];
            viewControlerr.yhash = model.yhash;
            [weakSelf.navigationController pushViewController:viewControlerr animated:YES];
            
        }
        if(thisEntity.data && [thisEntity.data isKindOfClass:BlockListItem.class]) {
            BlockListItem *model = (BlockListItem*)thisEntity.data;
            YUBlockDetailViewController *detailViewController = [[YUBlockDetailViewController alloc] init];
            detailViewController.blockId = model.blockId;
            [weakSelf.navigationController pushViewController:detailViewController animated:YES];
        }
    };
    
    weakSelf.searchbar.onTextKeyboardReturn = ^(NSString *text) {
        if ([weakSelf isPureInt:text] ) {
            YUBlockDetailViewController *detailViewController = [[YUBlockDetailViewController alloc] init];
            detailViewController.blockId = text.integerValue;
            [weakSelf.navigationController pushViewController:detailViewController animated:YES];
        }else {
            // dont exist
            API_GET_Block_Address_Exist *GET_Block_Address_Exist = [[API_GET_Block_Address_Exist alloc] init];
            GET_Block_Address_Exist.onSuccess = ^(id responseData) {
                NSString *existInfo = (NSString *)responseData ;
                weakSelf.isShowDefalutSearchInfo = NO;
                weakSelf.searchPublicKey = existInfo;
               [weakSelf.pageListView beginRefreshHeaderWithNoAnimate];
            };
            GET_Block_Address_Exist.onError = ^(NSString *reason, NSInteger code) {
                
            };
            GET_Block_Address_Exist.onEndConnection = ^{
                
            };
            [GET_Block_Address_Exist sendReuqestWithPublicKey:text];
        }
    };
    __weak typeof (self) wsf = self;
    [self.customNavBar setOnClickRightButton:^
     {
        // [wsf reBackUpSearchResult] ; // 重置搜索
         YUSearchBarView * search  = wsf.searchbar;
         search.placeholder = @"输入公钥/区块高度";
         if( !wsf.isSearchState ) {
             //当前非搜索状态，点击后变成搜索状态
             weakSelf.isShowDefalutSearchInfo = YES;
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
             wsf.isSearchState = YES;
             [wsf.pageListView beginRefreshHeaderWithNoAnimate];
         }else{
             // 当前搜索状态，点击后变非搜索状态
             [search.searchTextfield resignFirstResponder];
             wsf.isSearchState = NO;
             YUSearchBarView * search  = wsf.searchbar;
             [search fadeOut:^{
                 [wsf.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"serch_icon_black"]];
                 [wsf.searchbar removeFromSuperview];
             }];
             
             [wsf.pageListView beginRefreshHeaderWithNoAnimate];
         }
     }];
    self.searchbar.onTextDidEndEditing = ^(id sender) {
        
    };
    
    self.pageListView.yu_eventProduceByInnerCellView = ^(NSString * _Nonnull idf, id  _Nonnull content, id  _Nonnull sender) {
        YUPublicKeySearchResultCellEntity *en = (YUPublicKeySearchResultCellEntity *)content;
        if ([idf isEqualToString:@"cap"]) {
            YUBrowserCaptialViewController *captialVC = [[YUBrowserCaptialViewController alloc] init];
            
            captialVC.publicKey =  en.publicKey;
            [weakSelf.navigationController pushViewController:captialVC animated:YES];
            
        }
        if ([idf isEqualToString:@"rec"]) {
            YUTransactionRecordViewController *transRecordVC  = [[YUTransactionRecordViewController alloc] init];
            transRecordVC.publicKey = en.publicKey;
            [weakSelf.navigationController pushViewController:transRecordVC animated:YES];
        }
    };
}


- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

@end
