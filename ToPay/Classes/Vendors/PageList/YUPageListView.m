//
//  YUServerListView.m
//  ToPay
//
//  Created by 蒲公英 on 2019/2/27.
//  Copyright © 2019年 MVC. All rights reserved.
//

#import "YUPageListView.h"

#import "YUNoDataCellEntity.h"

#define DEFAULT_PAGE_SIZE 10

@interface YUPageListView() <UITableViewDelegate,
UITableViewDataSource,YUCellDelegate>


@property (strong,nonatomic) NSMutableArray<YUCellEntity *> * backUpDataArrays;
@property (strong,nonatomic) NSMutableArray<YUCellEntity *> * searchResultDataArrays;
@end
@implementation YUPageListView
#pragma mark lazy_load
yudef_lazyLoad(NSMutableArray<YUCellEntity *>, dataArrays, _dataArrays);
yudef_lazyLoad(UITableView, tableView, _tableView);
#pragma mark life cycle

- (void)layoutSubviews
{
    self.tableView.frame = self.bounds;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

#pragma mark private method
- (void)setUp
{
    [self addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.isUsingMJRefresh = YES; // default set
    self.pageSize = DEFAULT_PAGE_SIZE; // default
}

- (void)priavte_initData {
    self.dataArrays = [[NSMutableArray<YUCellEntity *> alloc] init];
    
}

- (void)addHeaderRefresh {
    yudef_weakSelf;
    [self.tableView addHeaderWithBlock:^(MJRefreshHeader *header) {
        [weakSelf firstPage];
    }];
}
- (void)addFooterRefresh {
    yudef_weakSelf;
    [self.tableView addFooterWithBlock:^(MJRefreshFooter *footer) {
        [weakSelf nextPage];
    }];
}

// block ,code block
- (void)firstPage
{
    yudef_weakSelf;
    [self.tableView.mj_footer endRefreshing];
    self.firstPageBlock(^(NSArray<YUCellEntity *> * _Nonnull data) {
        [weakSelf priavte_initData];
        if (data==nil || data.count ==0) {
            YUCellEntity *noDataEntity = [YUNoDataCellEntity quickInit:Localized(@"No data")];
            if (self.noDataEntity){
                noDataEntity = self.noDataEntity();
            }
            [weakSelf.dataArrays addObject:noDataEntity];
            self.tableView.mj_footer = nil;
        }else {
            [weakSelf.dataArrays addObjectsFromArray:data];
        }
        [weakSelf.tableView reloadData];
        if (weakSelf.isUsingMJRefresh) {
            [weakSelf.tableView.mj_header endRefreshing];
            if (data.count < weakSelf.pageSize && weakSelf.tableView.mj_footer ) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
    });
}
- (void)nextPage
{
    yudef_weakSelf;
    [self.tableView.mj_header endRefreshing];
    self.nextPageBlock(^(NSArray<YUCellEntity *> * _Nonnull data)
                       {
                           [weakSelf.dataArrays addObjectsFromArray:data];
                           [weakSelf reloadData];
                           if (data == nil || data.count < weakSelf.pageSize) {
                               [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                           }else {
                               [weakSelf.tableView.mj_footer endRefreshing];
                           }
                           
                       }, self);
}
#pragma mark public method
- (void)reloadData {
    [self.tableView reloadData];
}
- (void)beginRefreshHeader {
    if (self.isUsingMJRefresh) {
        [self.tableView.mj_header beginRefreshing];
        
    }else {
        [self beginRefreshHeaderWithNoAnimate];
    }
}

- (void)beginRefreshHeaderWithNoAnimate {
    [self firstPage];
}

- (YUCellEntity *)lastEntity {
    if (self.dataArrays.count == 0)return nil;
    return self.dataArrays.lastObject;
}

- (YUCellEntity *)lastEntity_KindOfClass:(Class)clss {
    for (NSInteger i = self.dataArrays.count-1 ;i>=0; i--) {
        if ([self.dataArrays[i] isKindOfClass:clss]) return self.dataArrays[i];
    }
    return nil;
}

- (void)setFirstPageBlock:(void (^)(block_page_complete _Nonnull))firstPageBlock {
    _firstPageBlock = firstPageBlock;
    if (_firstPageBlock!=nil && _isUsingMJRefresh) {
        // need headrefresh
        [self addHeaderRefresh];
    }
}

- (void)setNextPageBlock:(void (^)(block_page_complete _Nonnull, YUPageListView * _Nonnull))nextPageBlock {
    _nextPageBlock = nextPageBlock;
    if (_nextPageBlock!=nil && _isUsingMJRefresh) {
        [self addFooterRefresh];
    }
}
- (void)entoSearchingStatus {
    if (self.dataArrays == nil) return;
    self.backUpDataArrays = [[NSMutableArray<YUCellEntity *> alloc] init];
    [self.backUpDataArrays addObjectsFromArray:self.dataArrays];
}
- (void)searchUsingKeyWord:(NSString *)keyword
                matchBlock:(BOOL(^)(id obj))matchBlock {
    
    if (self.backUpDataArrays == nil) return;
    self.dataArrays = [[NSMutableArray<YUCellEntity *> alloc] init];
    [self.dataArrays addObjectsFromArray:self.backUpDataArrays];
    NSPredicate *pre = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return matchBlock(evaluatedObject);
    }];
    [self.dataArrays filterUsingPredicate:pre];
    [self reloadData];
}
- (void)exitSearchingStatus {
    if (self.backUpDataArrays == nil) return;
    self.dataArrays = self.backUpDataArrays;
    self.backUpDataArrays = nil;
    [self reloadData];
}
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.tableView.backgroundColor = backgroundColor;
}
#pragma mark - <tableView delegate >
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrays.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView cellByIndexPath:indexPath dataArrays:self.dataArrays delegate:self];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataArrays[indexPath.row].yu_cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.yu_didSelectRowAtIndexPath)
        self.yu_didSelectRowAtIndexPath(indexPath);
}

#pragma YUCell delegate
- (void)yu_cellMessageNotify:(NSString *)idf content:(id)content sender:(id)sender {
    if (self.yu_eventProduceByInnerCellView) {
        self.yu_eventProduceByInnerCellView(idf, content, sender);
    }
}
- (void)dealloc {
    
}
@end
