//
//  TPReleaseProjectDetailVC.m
//  ToPay
//
//  Created by 蒲公英 on 2019/2/18.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPReleaseProjectDetailVC.h"
#import "ReleaseProjectItem.h"
#import "TPReleaseDetailMainInfoCellEntity.h"
#import "TPTitleCellEntity.h"
#import "M_ReleaseProjectJoinedDetail.h"
#import "M_ReleaseProjectRecordItem.h"
#import "TPReleaseRecordItemCell.h"
#import "TPReleaseRecordItemCellEntity.h"
#import "TPReleaseRecordNoDataCellEntity.h"
#define page_size 10
@interface TPReleaseProjectDetailVC () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (strong, nonatomic) NSMutableArray<YUCellEntity *> *dataArrays ;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (assign,nonatomic) CGFloat topH ;

@end

@implementation TPReleaseProjectDetailVC
#pragma mark lazy_load
yudef_lazyLoad(NSMutableArray<YUCellEntity *> , dataArrays, _dataArrays);

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    [self setRefresh];
    [self initDefaultData];
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHex:@"#F7F7F7"];
    [self.tableView.mj_header beginRefreshing];
    [self.headView setHidden:YES];
    _topH = self.dataArrays[0].yu_cellHeight + self.dataArrays[1].yu_cellHeight;
    
}

- (void)setUpNav {
    NSString *title = TPString(@"%@-发布项目",self.fromModel.projectName);
    self.customNavBar.title = title;
    self.top.constant = self.customNavBar.height;
}
- (void)setRefresh {
    __weak typeof (self) wsf = self;
    [self.tableView addHeaderWithBlock:^(MJRefreshHeader *header) {
 
        [wsf fetchMainInfo:^(bool succ) {
            [wsf.tableView reloadData];
            [wsf fetchList:^(bool succ, bool nomore) {
                if ([wsf isNoDataNow]) {
                    TPReleaseRecordNoDataCellEntity *en = [[TPReleaseRecordNoDataCellEntity alloc] init];
                    [self.dataArrays addObject:en]; // 无货币提示
                    
                }
                [header endRefreshing];
                [wsf.tableView.mj_footer endRefreshing];
                [wsf.tableView reloadData];
                if (succ && nomore) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }];
        }];
    }];
    [self.tableView addFooterWithBlock:^(MJRefreshFooter *footer) {
        [wsf fetchList:^(bool succ, bool nomore) {
            [wsf.tableView.mj_footer endRefreshing];
            [wsf.tableView reloadData];
            if (succ && nomore) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }];
    }];
    
}

- (BOOL)isNoDataNow {
    return ![self.dataArrays.lastObject isKindOfClass:TPReleaseRecordItemCellEntity.class];
    
}
#pragma mark

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrays.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView cellByIndexPath:indexPath dataArrays:self.dataArrays];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataArrays[indexPath.row].yu_cellHeight;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    BOOL isHidden = scrollView.contentOffset.y < _topH;
    [_headView setHidden:isHidden];
    
}
#pragma mark serv

- (void)initDefaultData {
    self.dataArrays = [[ NSMutableArray<YUCellEntity *>  alloc] init];
    TPReleaseDetailMainInfoCellEntity *infoEntity = [[TPReleaseDetailMainInfoCellEntity alloc]init];
    TPTitleCellEntity *titleEntity = [[TPTitleCellEntity alloc] init];
    [self.dataArrays addObject:infoEntity];
    [self.dataArrays addObject:titleEntity];
}

- (void)fetchMainInfo:(void(^)(bool succ))complete   {

    NSString *url = TPString(@"project/%ld/publish",self.fromModel.projectId);
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer
                                                 url:url
                                          success:^(id responseObject, BOOL isCacheObject) {
                                              NSDictionary *res = (NSDictionary *)responseObject;
                                              if([res[@"code"]integerValue] == 200 ) {
                                                  [self initDefaultData]; //重置首行数据
                                                  YUCellEntity *firstEntity = (YUCellEntity*)self.dataArrays.firstObject;
                                                  M_ReleaseProjectJoinedDetail *detail = [[M_ReleaseProjectJoinedDetail alloc]initWithDictionary:res[@"data"]];
                                                  firstEntity.data = detail;
                                                
                                                  complete(true);
                                                  
                                              }else {
                                                  complete(false);
                                              }
                                          } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
                                              [self showErrorText:@"网络错误"];
                                              complete(true);
                                          }];
    
}

- (void)fetchList:(void(^)(bool succ,bool nomore))complete {
    // /project/{projectId}/publish/list
    NSString *url = TPString(@"project/%ld/publish/list",self.fromModel.projectId);
    NSMutableDictionary *postDic  =[[NSMutableDictionary alloc]initWithDictionary:@{@"pageSize":@page_size,@"id":@0}] ;
    if (([self.dataArrays.lastObject isKindOfClass:TPReleaseRecordItemCellEntity.class])) {
        // 不是第一次
        // 前两项是详情，和标题的cell
        YUCellEntity *entity = self.dataArrays.lastObject;
        M_ReleaseProjectRecordItem *last_item  = (M_ReleaseProjectRecordItem *)entity.data;
        postDic[@"id"] =@(last_item.idField);
    }
    
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer
                                                 url:url
                                            parameters:postDic
                                             success:^(id responseObject, BOOL isCacheObject) {
                                                 NSDictionary *res = (NSDictionary *)responseObject;
                                                 if([res[@"code"]integerValue] == 200 ) {
                                                     NSArray *arr = res[@"data"];
                                                     for (NSDictionary *dic in arr) {
                                                         M_ReleaseProjectRecordItem *item = [[M_ReleaseProjectRecordItem alloc] initWithDictionary:dic];
                                                         TPReleaseRecordItemCellEntity *en = [[TPReleaseRecordItemCellEntity alloc] init];
                                                         en.data = item;
                                                         [self.dataArrays addObject:en];
                                                         
                                                     }
                                                     complete(true,arr.count < page_size);
                                                 }else {
                                                     complete(false,false);
                                                 }
                                             } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
                                                 [self showErrorText:@"网络错误"];
                                                  complete(false,false);
                                             }];
}


@end
