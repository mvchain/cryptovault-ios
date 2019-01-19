//
//  TPInvitedRegisterViewController.m
//  ToPay
//
//  Created by 蒲公英 on 2019/1/19.
//  Copyright © 2019年 蒲公英. All rights reserved.
//

#import "TPInvitedRegisterViewController.h"
#import "TPInvitedRegisterViewModel.h"
@interface TPInvitedRegisterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
yudef_property_strong(TPInvitedRegisterViewModel, viewModel);
@end

@implementation TPInvitedRegisterViewController
yudef_lazyLoad(TPInvitedRegisterViewModel, viewModel,_viewModel);

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWithUI];
    
}
- (void)initWithUI {
    self.customNavBar.title = @"邀请注册";
    self.tableView.contentInset = UIEdgeInsetsMake(self.customNavBar.height, 0, 0, 0   );
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.viewModel.dataArray[0].yu_cellHeight = KWidth - self.customNavBar.height;
    
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
@end
