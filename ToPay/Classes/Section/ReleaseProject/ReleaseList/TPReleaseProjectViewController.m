//
//  TPReleaseProjectViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/2/18.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPReleaseProjectViewController.h"
#import "TPReleaseProjectCellEntity.h"
#import "ReleaseProjectItem.h"
#import "TPReleasePrjNoMoreCellEntity.h"
#import "TPReleaseProjectDetailVC.h"
#define page_size 10
@interface TPReleaseProjectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray <YUCellEntity *> * dataArrays;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;

@end

@implementation TPReleaseProjectViewController
#pragma mark lazy

yudef_lazyLoad( NSMutableArray <YUCellEntity *>, dataArrays, _dataArrays)

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    [self setRefresh];
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHex:@"#F7F7F7"];
    [self.tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view from its nib.
}
- (void)setRefresh {
    __weak typeof (self) wsf = self;
    [self.tableView addHeaderWithBlock:^(MJRefreshHeader *header) {
        wsf.dataArrays = [[NSMutableArray <YUCellEntity *> alloc] init];
        [wsf fetchPage:^(bool nomore,bool succ) {
            // 没有更多
            if(nomore && succ)
                [wsf.tableView.mj_footer endRefreshingWithNoMoreData];
            if (wsf.dataArrays.count == 0) {
                TPReleasePrjNoMoreCellEntity *noDataEn = [[TPReleasePrjNoMoreCellEntity alloc]init];
                [wsf.dataArrays addObject:noDataEn];
            }
            [wsf.tableView reloadData];
            [header endRefreshing];
            [wsf.tableView.mj_footer endRefreshing];
        }];
    }];
    
    [self.tableView addFooterWithBlock:^(MJRefreshFooter *footer) {
        [wsf fetchPage:^(bool nomore,bool succ ) {
            [wsf.tableView reloadData];
            [footer endRefreshing];
            // 没有更多
            if(nomore && succ)
                    [wsf.tableView.mj_footer endRefreshingWithNoMoreData];

        }];
    }];
}
- (void)setUpNav {
    self.customNavBar.title = @"发布项目";
    _top.constant = self.customNavBar.height;
}
#pragma mark table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.dataArrays.count ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView cellByIndexPath:indexPath dataArrays:self.dataArrays];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TPReleaseProjectDetailVC *detail = [[TPReleaseProjectDetailVC alloc]init];
    detail.fromModel = self.dataArrays[indexPath.row].data;
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma serv
- (void)fetchPage:(void(^)(bool nomore,bool succ))complete {
    // /project/publish
    // data里没数据就拉第一页，有数据就下一页
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"projectId":@"0",@"pageSize":@page_size}];
    if ([self.dataArrays.lastObject isKindOfClass:TPReleaseProjectCellEntity.class] )
        postDic[@"projectId"] = @(((ReleaseProjectItem *) self.dataArrays.lastObject.data).projectId);
    [[WYNetworkManager sharedManager] sendGetRequest:WYJSONRequestSerializer
                                                 url:@"project/publish"
                                          parameters:postDic success:^(id responseObject, BOOL isCacheObject) {
                                              NSDictionary *res = (NSDictionary *)responseObject;
                                              NSArray *arr = res[@"data"];
                                              if([res[@"code"]integerValue] == 200 ) {
                                                  for (NSDictionary *item_dic in arr) {
                                                      ReleaseProjectItem * projectItem = [[ReleaseProjectItem alloc] initWithDictionary:item_dic];
                                                      TPReleaseProjectCellEntity *projectCellEn = [[TPReleaseProjectCellEntity alloc]init];
                                                      projectCellEn.data = projectItem;
                                                      [self.dataArrays addObject:projectCellEn];
                                                  }
                                                  complete(arr.count<page_size,YES);
                                              }else {
                                                  complete(NO,NO);
                                              }
                                          } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
                                              [self showErrorText:@"网络错误"];
                                              complete(NO,NO);
                                          }];
}
@end
