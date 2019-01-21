//
//  TPInvitedRegisterViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/19.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPInvitedRegisterViewController.h"
#import "TPInvitedRegisterViewModel.h"
#import "TPInviteRegFirstPageTableViewCellEntity.h"
@interface TPInvitedRegisterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
yudef_property_strong(TPInvitedRegisterViewModel, viewModel);
@end
@implementation TPInvitedRegisterViewController
yudef_lazyLoad(TPInvitedRegisterViewModel, viewModel,_viewModel);
#pragma mark load
- (void)loadNetData {
    [self yu_showLoading];
    [self.viewModel loadNewData:^(BOOL isSucc, id data) {
        if( isSucc ) {
            [self.tableView reloadData];
            if([data isKindOfClass:[NSNull class]]) {
                 self.viewModel.dataArray[1].callBackByOuter(@{@"type":@"no-more"}); // 通知第二页内部tableview刷新
            }else {
                 self.viewModel.dataArray[1].callBackByOuter(@{@"type":@"new"}); // 通知第二页内部tableview刷新
            }
           
        }else {
            [self showErrorText:data];
        }
        [self yu_dismissLoading];
    }];
}

#pragma mark sys
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithUI];
    [self initEvent];
    [self loadNetData];
}
- (void)initWithUI {
    self.customNavBar.title = @"邀请注册";
    self.tableView.contentInset = UIEdgeInsetsMake(self.customNavBar.height, 0, 0, 0   );
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.viewModel.dataArray[0].yu_cellHeight = KHeight - self.customNavBar.height;
    self.viewModel.dataArray[1].yu_cellHeight = KHeight - self.customNavBar.height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YUCellEntity *ens = self.viewModel.dataArray[indexPath.row];
    return ens.yu_cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView cellByIndexPath:indexPath dataArrays:self.viewModel.dataArray];
}

#pragma mark event
- (void)initEvent {
    self.viewModel.dataArray[0].callBackByCell = ^(NSDictionary *info) {
        // d第一页事件
        if ([info[@"from"] isEqualToString:@"my-invited"]) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            self.viewModel.curPage =1;
            
            
        }else if([info[@"from"] isEqualToString:@"copy-invited-code"]) {
            TPInviteRegFirstPageTableViewCellEntity *entity = (TPInviteRegFirstPageTableViewCellEntity *)self.viewModel.dataArray[0];
            [QuickDo copyToPastboard:entity.inviteCode];
        }else if([info[@"from"] isEqualToString:@"copy-download-addr"]) {
            
        }
    };
    
    self.viewModel.dataArray[1].callBackByCell = ^(NSDictionary *info) {
        // 第二页滚动事件
        if ([info[@"type"] isEqualToString:@"scroll-change"]) {
            if( self.viewModel.curPage == 1 ) {
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                self.viewModel.curPage =0;
            }
        }else if([info[@"type"] isEqualToString:@"loadMore"]) {
            // 加载更多事件
            [self.viewModel loadMoreData:^(BOOL isSucc, id data) {
                if ([data isKindOfClass:[NSNull class]]) {
                    self.viewModel.dataArray[1].callBackByOuter(@{@"type":@"no-more"}); // 通知第二页内部tableview刷新
                }else {
                    self.viewModel.dataArray[1].callBackByOuter(@{@"type":@"more"}); // 通知第二页内部tableview刷新
                }
                
            }];
            
        }
    };
    
}
@end
