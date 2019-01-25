//
//  TPInviteRegSecondPageTableViewCell.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/21.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPInviteRegSecondPageTableViewCell.h"
#import "TPInviteRegSecondPageTableViewCellEntity.h"
@interface TPInviteRegSecondPageTableViewCell()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end
@implementation TPInviteRegSecondPageTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    [_backView yu_smallCircleStyleWithRadius:8];
    _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;

    _tableView.delegate =self;
    _tableView.dataSource =self;
    [self setFootRefresh];
}

- (void)setEntity:(YUCellEntity *)entity {
    [super setEntity:entity];
    __weak typeof (self) wsf = self;
    if(!entity.callBackByOuter) {
        entity.callBackByOuter = ^(NSDictionary *info) {
            //  提供给外部回调
            if ([info[@"type"] isEqualToString:@"no-more"]) {
                [wsf.tableView.mj_footer endRefreshingWithNoMoreData];
                
            }else {
                [wsf.tableView.mj_footer endRefreshing];
                
            }
            [wsf.tableView reloadData];
        };
    }
}

- (void)setFootRefresh {
    __weak typeof (self) wsf = self;
    [self.tableView addFooterWithBlock:^(MJRefreshFooter *footer) {
            wsf.entity.callBackByCell(@{@"type":@"loadMore"}); //  下拉加载更多
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TPInviteRegSecondPageTableViewCellEntity *en = (TPInviteRegSecondPageTableViewCellEntity*)self.entity;
    return en.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TPInviteRegSecondPageTableViewCellEntity *en = (TPInviteRegSecondPageTableViewCellEntity*)self.entity;
    return [tableView cellByIndexPath:indexPath dataArrays:en.dataArray];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat  x=  scrollView.contentOffset.y;
    if (x < -30){
        if(self.entity.callBackByCell) {
            self.entity.callBackByCell(@{@"type":@"scroll-change"}); //  翻页
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        TPInviteRegSecondPageTableViewCellEntity *en = (TPInviteRegSecondPageTableViewCellEntity*)self.entity;
    return en.dataArray[indexPath.row].yu_cellHeight;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    printf("%.lf",self.tableView.contentOffset.y);
}
@end
