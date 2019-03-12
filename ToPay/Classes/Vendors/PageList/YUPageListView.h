//
//  YUServerListView.h
//  ToPay
//
//  Created by 蒲公英 on 2019/2/27.
//  Copyright © 2019年 MVC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^block_page_complete)(NSArray<YUCellEntity *> *data ) ;
@interface YUPageListView : UIView
#pragma mark property
@property (assign,nonatomic) NSInteger pageSize;
@property (assign,nonatomic) BOOL isUsingMJRefresh;
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray<YUCellEntity *> * dataArrays ;
#pragma mark block must set
@property (copy,nonatomic) void (^firstPageBlock)(block_page_complete complete);
@property (copy,nonatomic) void (^nextPageBlock)(block_page_complete complete,YUPageListView *thisPageView);
@property (copy,nonatomic) YUCellEntity *(^noDataEntity)(void);
#pragma mark block option
@property (copy,nonatomic) void (^yu_didSelectRowAtIndexPath)(NSIndexPath *indexPath);
@property (copy,nonatomic) void (^yu_eventProduceByInnerCellView)(NSString *idf,id content ,id sender );
#pragma mark public method
- (void)beginRefreshHeader ;
- (void)beginRefreshHeaderWithNoAnimate;
- (void)reloadData;
- (void)entoSearchingStatus;
- (void)searchUsingKeyWord:(NSString *)keyword
                matchBlock:(BOOL(^)(id obj))matchBlock;
- (void)exitSearchingStatus;
- (YUCellEntity *)lastEntity;
- (YUCellEntity *)lastEntity_KindOfClass:(Class)clss;

@end

NS_ASSUME_NONNULL_END
